//
//  UIViewController+UITextField.swift
//  ONEdu
//
//  Created by Tran Dat on 09/06/2022.
//

import Foundation
import UIKit

extension UIViewController {
    func toolBar() -> UIToolbar{
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.barTintColor = UIColor.init(red: 0/255, green: 25/255, blue: 61/255, alpha: 1) //Write what you want for color
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let buttonTitle = "Xong" //Or "Tamam"
//            var cancelButtonTitle = "Cancel" //Or "İptal" for Turkish
        let doneButton = UIBarButtonItem(title: buttonTitle, style: .done, target: self, action: #selector(onClickDoneButton))
//            let cancelButton = UIBarButtonItem(title: cancelButtonTitle, style: .plain, target: self, action: #selector(onClickCancelButton))
        doneButton.tintColor = .white
//            cancelButton.tintColor = .white
        toolBar.setItems([space, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        return toolBar
    }

    @objc func onClickDoneButton(){
        view.endEditing(true)
    }
    
    func validatePhone(valChange: String) -> Bool {
        let PHONE_REGEX = "^0[3|5|7|8|9]\\d{8}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result = phoneTest.evaluate(with: valChange)
        return result
    }
    
    func validatePassword(valChange: String) -> Bool {
//        let SPACE_REGEX = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}\\s*"
        let UPPERCASE_REGEX = "(?s)[^A-Z]*[A-Z].*"
//        let spaceTest = NSPredicate(format: "SELF MATCHES %@", SPACE_REGEX)
        let uppercaseTest = NSPredicate(format: "SELF MATCHES %@", UPPERCASE_REGEX)
//        print("spaceTest.evaluate: \(spaceTest.evaluate(with: valChange))")
        if uppercaseTest.evaluate(with: valChange) {
            return true
        }
        return false
    }
}
