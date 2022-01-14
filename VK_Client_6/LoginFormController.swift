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
    var token:AuthStateDidChangeListenerHandle!
    

    
    @IBAction func enterButton(_ sender: Any?) {
        if let userName = userName.text {
            if let password = password.text {
                authFireBase.signIn(withEmail: userName, password: password) { authResult, error in
                    if let error = error {
                        self.showLoginError(title: "Неверное имя пользователя или пароль", text: error.localizedDescription)
                        return
                    }
                    self.showWEBAccessView()
                }
            }
        }
    }
    
    @IBAction func singInButton(_ sender: Any) {
        if let userName = userName.text {
            if let password = password.text {
                authFireBase.createUser(withEmail: userName, password: password) { authResult, error in
                    if let error = error {
                        self.showLoginError(title: "Ошибка при создании пользователя", text: error.localizedDescription)
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
    
    // метод отписки при исчезновении контроллера с экрана
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        // присваеваем его UIScrollview
        scrollView?.addGestureRecognizer(hideKeyboardGesture)
        
        token = authFireBase.addStateDidChangeListener({ auth, user in
            guard user != nil else { return }
            self.showWEBAccessView()
        })
       
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
    
    func showWEBAccessView() {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "WEBAccessView") as? WebAccessViewController {
            if let window = self.view.window {
                window.rootViewController = vc
            }
        }
    }
    
}

 extension UIImageView {
    func applyDesign() {
        self.layer.cornerRadius = self.frame.height / 2
        self.backgroundColor = UIColor.white
    }
}
