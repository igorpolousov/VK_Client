//
//  ShadowView.swift
//  VK_Client_6
//
//  Created by Igor Polousov on 30.03.2021.
//

import UIKit

class ShadowView: UIView {

}

extension ShadowView {
    func applyDesignShadow(){
        self.layer.shadowColor = UIColor.orangeWeight.cgColor
        self.layer.shadowOpacity = 0.8
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.shadowRadius = 5
        self.layer.shadowOffset = CGSize(width: 5, height: 5)
    }
}
// Flyweight
extension UIColor {
    static let orangeWeight = UIColor(red: 255.0 / 255.0, green: 100.0 / 255.0, blue: 20.0 / 255.0, alpha: 1.0)
}

extension UIFont {
    static let myFont = UIFont(name: "Chalkduster", size: 15)
}

extension UILabel {
    func applyFont() {
        self.font = UIFont(name: "Chalkduster", size: 16)
        self.textColor = UIColor.orangeWeight
    }
}
