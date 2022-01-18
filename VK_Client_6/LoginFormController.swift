//
//  LoginFormController.swift
//  VK_Client_6
//
//  Created by Igor Polousov on 29.03.2021.
//

import UIKit
import Firebase

class LoginFormController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    
    let authFireBase = Auth.auth()
    var token: AuthStateDidChangeListenerHandle!
    let ref = Database.database(url: "https://vc-client-default-rtdb.europe-west1.firebasedatabase.app").reference(withPath: "userData")
    
    var userData = [FireBase]()
    
    @IBAction func enterButton(_ sender: Any?) {
        if let email = userName.text {
            if let password = password.text {
                authFireBase.signIn(withEmail: email, password: password) { authResult, error in
                    
                    if let userIds = authResult?.user.uid {
                        self.addUserIdToFireBase(userId: userIds)
                    }
                    
                    if let error = error {
                        self.showLoginError(title: "SingIn Error", text: error.localizedDescription)
                        return
                    }
                    self.showHomeViewController()
                }
            }
        }
    }
    
    
    @IBAction func signUp(_ sender: Any) {
        if let email = userName.text {
            if let password = password.text {
                authFireBase.createUser(withEmail: email, password: password) { authResult, error in
                    if let error = error {
                        self.showLoginError(title: "SingUp Error", text: error.localizedDescription)
                        return
                    }
                    self.enterButton(nil)
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // подписываемся на два уведомления
        // уведомление при появлении клавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        //уведомление при исчезновении клавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        token = authFireBase.addStateDidChangeListener({ auth, user in
            if let userIds = user?.uid {
                self.addUserIdToFireBase(userId: userIds)
            }
            
            guard user != nil else { return }
            self.showHomeViewController()
        })
        
        ref.observe(.value, with: { snapshot in
            print(snapshot.value as Any)
            
            var userData = [FireBase]()
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot, let user = FireBase(snapshot: snapshot) {
                    userData.append(user)
                }
            }
            self.userData = userData
            let _ = self.userData.map { print($0.iserId, $0.groupAdded)}
        })
        
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        // присваеваем его UIScrollview
        scrollView?.addGestureRecognizer(hideKeyboardGesture)
        
    }
    
    // метод отписки при исчезновении контроллера с экрана
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func addUserIdToFireBase(userId: String) {
        let user = FireBase(userId: userId, groupAdded: "")
        let userContainerRef = self.ref.child(user.iserId)
        userContainerRef.setValue(user.toAnyObject())
    }
    
    @objc func keyboardWasShown(notification: Notification){
        // Получаем размер клавиатуры
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        // Добавим отступ внизу UIScrollView равный размеру клавиатуры
        self.scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    // когда клавиатура исчезает
    @objc func keyboardWillBeHidden(notification: Notification){
        // устанавливем отсуп снизу UIScrollView, равным нулю
        let contenInsets = UIEdgeInsets.zero
        scrollView?.contentInset = contenInsets
    }
    

    
    @objc func hideKeyboard(){
        self.scrollView?.endEditing(true)
    }
    
//    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
//        // Проверяем данные
//        let checkResult = checkUserData()
//        // Если данные неверны, покажем ошибку
//        if !checkResult {
//            showLoginError()
//        }
//        // Вернём результат
//        return checkResult
//    }
    
//    func checkUserData() -> Bool {
//        let login = userName.text
//        let passwords = password.text
//        if login == "a" && passwords == "1"{
//            return true
//        } else {
//            return false
//        }
//    }
    
    func showHomeViewController() {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "VKLoginView") as? WebAccessViewController {
            if let window = self.view.window {
                window.rootViewController = vc
            }
        }
    }
    
    func showLoginError(title: String?, text: String?) {
        // создаём Alert контроллер
        let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
        // Создаём кнопку для UIAlertController
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        // добавляем кнопку на UIAlertController
        alert.addAction(action)
        // показываем UIAlertController
        present(alert, animated: true, completion: nil)
    }

}

 extension UIImageView {
    func applyDesign() {
        self.layer.cornerRadius = self.frame.height / 2
        self.backgroundColor = UIColor.white
    }
}
