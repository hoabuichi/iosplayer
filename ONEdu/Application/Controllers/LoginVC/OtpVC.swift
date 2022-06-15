//
//  OtpVC.swift
//  ONEdu
//
//  Created by Tran Dat on 10/06/2022.
//

import UIKit

protocol MyTextFieldDelegate: AnyObject {
    func textFieldDidDelete(_ textField: UITextField)
}

class MyTextField: UITextField {

    weak var myDelegate: MyTextFieldDelegate?

    override func deleteBackward() {
        self.myDelegate?.textFieldDidDelete(self)
        super.deleteBackward()
    }

}

class OtpVC: UIViewController {
    var otp = ""
    var isSubmit = false
    var isVisibleProgress: Bool = false
    
//    private var backButton: BackButton = {
//        let button = BackButton()
//        return button
//    }()
    private var headerView: HeaderRegister = {
        let header = HeaderRegister()
        header.backgroundColor = .clear
        return header
    }()
    
    private var titleOtp: UILabel = {
        let label = UILabel()
        label.text = "Xác thực số điện thoại"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    private var desOtp: UILabel = {
        let label = UILabel()
        label.text = "Nhập mã OTP được gửi tới số điện thoại của bạn."
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()

    private var boxOTP: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = .clear
        return uiView
    }()
    private var tfOtpOne: MyTextField = {
        let textField = MyTextField()
        textField.backgroundColor = .white
        textField.textColor = .black900
        textField.font = UIFont.systemFont(ofSize: 32, weight: .semibold)
        textField.textAlignment = .center
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor(hexFromString: "#57BFFC").cgColor
        textField.layer.cornerRadius = 16.0
        textField.layer.masksToBounds = true
        return textField
    }()
    private var tfOtpTwo: MyTextField = {
        let textField = MyTextField()
        textField.backgroundColor = .white
        textField.textColor = .black900
        textField.font = UIFont.systemFont(ofSize: 32, weight: .semibold)
        textField.textAlignment = .center
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor(hexFromString: "#57BFFC").cgColor
        textField.layer.cornerRadius = 16.0
        textField.layer.masksToBounds = true
        return textField
    }()
    private var tfOtpThree: MyTextField = {
        let textField = MyTextField()
        textField.backgroundColor = .white
        textField.textColor = .black900
        textField.font = UIFont.systemFont(ofSize: 32, weight: .semibold)
        textField.textAlignment = .center
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor(hexFromString: "#57BFFC").cgColor
        textField.layer.cornerRadius = 16.0
        textField.layer.masksToBounds = true
        return textField
    }()
    private var tfOtpFour: MyTextField = {
        let textField = MyTextField()
        textField.backgroundColor = .white
        textField.textColor = .black900
        textField.font = UIFont.systemFont(ofSize: 32, weight: .semibold)
        textField.textAlignment = .center
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor(hexFromString: "#57BFFC").cgColor
        textField.layer.cornerRadius = 16.0
        textField.layer.masksToBounds = true
        return textField
    }()
    private var tfOtpFive: MyTextField = {
        let textField = MyTextField()
        textField.backgroundColor = .white
        textField.textColor = .black900
        textField.font = UIFont.systemFont(ofSize: 32, weight: .semibold)
        textField.textAlignment = .center
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor(hexFromString: "#57BFFC").cgColor
        textField.layer.cornerRadius = 16.0
        textField.layer.masksToBounds = true
        return textField
    }()
    private var tfOtpSix: MyTextField = {
        let textField = MyTextField()
        textField.backgroundColor = .white
        textField.textColor = .black900
        textField.font = UIFont.systemFont(ofSize: 32, weight: .semibold)
        textField.textAlignment = .center
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor(hexFromString: "#57BFFC").cgColor
        textField.layer.cornerRadius = 16.0
        textField.layer.masksToBounds = true
        return textField
    }()

    private var boxError: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = .clear
        return uiView
    }()
    private var iconError: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "warning")
        return image
    }()
    private var errorLabel: UILabel = {
        let label = UILabel()
        label.text = "Mật khẩu chưa chính xác"
        label.textAlignment = .center
        label.textColor = .redLight
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
    private var buttonSend: UIButton = {
        let button = UIButton()
        button.setTitle("Gửi lại mã OTP", for: .normal)
        button.setTitleColor(UIColor.cyanBasic, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return button
    }()
    
    private var buttonConfirm: UIButton = {
        let button = UIButton()
        button.setTitle("XÁC NHẬN", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.setTitleColor(UIColor.blueLight, for: .normal)
        button.backgroundColor = .blueLighter
        button.layer.cornerRadius = 12.0
        button.layer.masksToBounds = true
        button.layer.borderWidth = 4
        button.layer.borderColor = UIColor.blueLight.cgColor
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .blueDarker
        view.addSubview(headerView)
        if !isVisibleProgress {
            headerView.hideProgress()
        } else {
            headerView.configure(3)
        }
        headerView.setupBackButton(false, self)
        
        view.addSubview(titleOtp)
        view.addSubview(desOtp)

        view.addSubview(boxOTP)
        boxOTP.addSubview(tfOtpOne)
        boxOTP.addSubview(tfOtpTwo)
        boxOTP.addSubview(tfOtpThree)
        boxOTP.addSubview(tfOtpFour)
        boxOTP.addSubview(tfOtpFive)
        boxOTP.addSubview(tfOtpSix)

        view.addSubview(boxError)
        boxError.addSubview(iconError)
        boxError.addSubview(errorLabel)
        boxError.isHidden = true

        view.addSubview(buttonSend)
        view.addSubview(buttonConfirm)
        buttonConfirm.isEnabled = false
        
        setupContraint()
        
        if #available(iOS 12.0, *) {
            tfOtpOne.textContentType = .oneTimeCode
        } else {
            print("Not supported")
        }
        
        addLogicType([tfOtpOne, tfOtpTwo, tfOtpThree, tfOtpFour, tfOtpFive, tfOtpSix])
        tfOtpOne.becomeFirstResponder()

        buttonConfirm.addTarget(self, action: #selector(onConfirm), for: .touchUpInside)
    }
    
    func addLogicType(_ textFields: [MyTextField]) {
        for item in textFields {
            item.myDelegate = self
            
            item.isEnabled = true
            item.isUserInteractionEnabled = true
            item.textContentType = .telephoneNumber
            item.keyboardType = .phonePad
            item.addTarget(self, action: #selector(changeCharacter), for: .editingChanged)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
        self.setColorStatusbar()
    }
    
    func setupContraint() {
        let padding: CGFloat = 16.0
        let screenSizeWidth: CGFloat = UIScreen.main.bounds.width - (32 * 2) - (8 * 5)

//        backButton.anchor(top: view.safeTopAnchor, left: view.leftAnchor, paddingTop: 0, paddingLeft: 16, width: 36, height: 36)
        headerView.anchor(top: view.safeTopAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 16, paddingRight: 16, height: 36)
        titleOtp.anchor(top: headerView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 34, paddingLeft: padding, paddingRight: padding)
        desOtp.anchor(top: titleOtp.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 8, paddingLeft: padding, paddingRight: padding)
        
        boxOTP.anchor(top: desOtp.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: padding * 3, paddingLeft: padding * 2, paddingRight: padding * 2, height: 56)
        
        tfOtpOne.anchor(top: boxOTP.topAnchor, left: boxOTP.leftAnchor, bottom: boxOTP.bottomAnchor, paddingTop: 0, paddingLeft: 0, width: screenSizeWidth / 6)
        tfOtpTwo.anchor(top: boxOTP.topAnchor, left: tfOtpOne.rightAnchor, bottom: boxOTP.bottomAnchor, paddingTop: 0, paddingLeft: 8, width: screenSizeWidth / 6)
        tfOtpThree.anchor(top: boxOTP.topAnchor, left: tfOtpTwo.rightAnchor, bottom: boxOTP.bottomAnchor, paddingTop: 0, paddingLeft: 8, width: screenSizeWidth / 6)
        tfOtpFour.anchor(top: boxOTP.topAnchor, left: tfOtpThree.rightAnchor, bottom: boxOTP.bottomAnchor, paddingTop: 0, paddingLeft: 8, width: screenSizeWidth / 6)
        tfOtpFive.anchor(top: boxOTP.topAnchor, left: tfOtpFour.rightAnchor, bottom: boxOTP.bottomAnchor, paddingTop: 0, paddingLeft: 8, width: screenSizeWidth / 6)
        tfOtpSix.anchor(top: boxOTP.topAnchor, left: tfOtpFive.rightAnchor, bottom: boxOTP.bottomAnchor, paddingTop: 0, paddingLeft: 8, width: screenSizeWidth / 6)

        boxError.anchor(top: tfOtpOne.bottomAnchor, paddingTop: 8, width: 190, height: 22)
        boxError.centerX(inView: view)
        iconError.anchor(left: boxError.leftAnchor, width: 12, height: 12)
        iconError.centerY(inView: boxError)
        errorLabel.anchor(left: iconError.rightAnchor, right: boxError.rightAnchor, paddingLeft: 8)
        errorLabel.centerY(inView: boxError)
        buttonSend.anchor(top: boxError.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: padding * 2, paddingLeft: padding * 2, paddingRight: padding * 2, width: 120, height: 30)
        
        buttonConfirm.anchor(left: view.leftAnchor, bottom: view.safeBottomAnchor, right: view.rightAnchor, paddingLeft: padding, paddingBottom: 20, paddingRight: padding, height: 52)
    }
    
    @objc func changeCharacter(textField: UITextField) {
        if ((textField.text?.utf8.count)! >= 1) {
            let splitText = Array("\(textField.text ?? "")")
            if splitText.count > 1 {
                textField.text = "\(splitText[splitText.count - 1])"
            }
            switch textField {
            case tfOtpOne:
                tfOtpTwo.becomeFirstResponder()
                otp = "\(tfOtpOne.text!)\(tfOtpTwo.text!)\(tfOtpThree.text!)\(tfOtpFour.text!)\(tfOtpFive.text!)\(tfOtpSix.text!)"
                onChangeButtonLayer(buttonSubmit: buttonConfirm)
            case tfOtpTwo:
                tfOtpThree.becomeFirstResponder()
                otp = "\(tfOtpOne.text!)\(tfOtpTwo.text!)\(tfOtpThree.text!)\(tfOtpFour.text!)\(tfOtpFive.text!)\(tfOtpSix.text!)"
                onChangeButtonLayer(buttonSubmit: buttonConfirm)
            case tfOtpThree:
                tfOtpFour.becomeFirstResponder()
                otp = "\(tfOtpOne.text!)\(tfOtpTwo.text!)\(tfOtpThree.text!)\(tfOtpFour.text!)\(tfOtpFive.text!)\(tfOtpSix.text!)"
                onChangeButtonLayer(buttonSubmit: buttonConfirm)
            case tfOtpFour:
                tfOtpFive.becomeFirstResponder()
                otp = "\(tfOtpOne.text!)\(tfOtpTwo.text!)\(tfOtpThree.text!)\(tfOtpFour.text!)\(tfOtpFive.text!)\(tfOtpSix.text!)"
                onChangeButtonLayer(buttonSubmit: buttonConfirm)
            case tfOtpFive:
                tfOtpSix.becomeFirstResponder()
                otp = "\(tfOtpOne.text!)\(tfOtpTwo.text!)\(tfOtpThree.text!)\(tfOtpFour.text!)\(tfOtpFive.text!)\(tfOtpSix.text!)"
                onChangeButtonLayer(buttonSubmit: buttonConfirm)
            case tfOtpSix:
                otp = "\(tfOtpOne.text!)\(tfOtpTwo.text!)\(tfOtpThree.text!)\(tfOtpFour.text!)\(tfOtpFive.text!)\(tfOtpSix.text!)"
                onChangeButtonLayer(buttonSubmit: buttonConfirm)
                view.endEditing(true)
            default:
                break
            }
        } else if ((textField.text?.isEmpty) == true) {
            self.onBackspaceTf(textField, false)
        }
        
        if #available(iOS 12.0, *) {
            if textField.textContentType == UITextContentType.oneTimeCode{
                //here split the text to your four text fields
                if let otpCode = textField.text, otpCode.count >= 6 {
                    tfOtpOne.text = String(otpCode[otpCode.index(otpCode.startIndex, offsetBy: 0)])
                    tfOtpTwo.text = String(otpCode[otpCode.index(otpCode.startIndex, offsetBy: 1)])
                    tfOtpThree.text = String(otpCode[otpCode.index(otpCode.startIndex, offsetBy: 2)])
                    tfOtpFour.text = String(otpCode[otpCode.index(otpCode.startIndex, offsetBy: 3)])
                    tfOtpFive.text = String(otpCode[otpCode.index(otpCode.startIndex, offsetBy: 4)])
                    tfOtpSix.text = String(otpCode[otpCode.index(otpCode.startIndex, offsetBy: 5)])
                }
            }
         }
    }
    
    func onBackspaceTf(_ textField: UITextField, _ isEmptyTextField: Bool) {
        switch textField {
            case tfOtpSix:
                if isEmptyTextField {
                    tfOtpFive.becomeFirstResponder()
                }
                otp = "\(tfOtpOne.text!)\(tfOtpTwo.text!)\(tfOtpThree.text!)\(tfOtpFour.text!)\(tfOtpFive.text!)\(tfOtpSix.text!)"
                onChangeButtonLayer(buttonSubmit: buttonConfirm)
            case tfOtpFive:
                if isEmptyTextField {
                    tfOtpFour.becomeFirstResponder()
                }
                otp = "\(tfOtpOne.text!)\(tfOtpTwo.text!)\(tfOtpThree.text!)\(tfOtpFour.text!)\(tfOtpFive.text!)\(tfOtpSix.text!)"
                onChangeButtonLayer(buttonSubmit: buttonConfirm)
            case tfOtpFour:
                if isEmptyTextField {
                    tfOtpThree.becomeFirstResponder()
                }
                otp = "\(tfOtpOne.text!)\(tfOtpTwo.text!)\(tfOtpThree.text!)\(tfOtpFour.text!)\(tfOtpFive.text!)\(tfOtpSix.text!)"
                onChangeButtonLayer(buttonSubmit: buttonConfirm)
            case tfOtpThree:
                if isEmptyTextField {
                    tfOtpTwo.becomeFirstResponder()
                }
                otp = "\(tfOtpOne.text!)\(tfOtpTwo.text!)\(tfOtpThree.text!)\(tfOtpFour.text!)\(tfOtpFive.text!)\(tfOtpSix.text!)"
                onChangeButtonLayer(buttonSubmit: buttonConfirm)
            case tfOtpTwo:
                if isEmptyTextField {
                    tfOtpOne.becomeFirstResponder()
                }
                otp = "\(tfOtpOne.text!)\(tfOtpTwo.text!)\(tfOtpThree.text!)\(tfOtpFour.text!)\(tfOtpFive.text!)\(tfOtpSix.text!)"
                onChangeButtonLayer(buttonSubmit: buttonConfirm)
            default:
                break
        }
    }
    
    func onChangeButtonLayer(buttonSubmit: UIButton) {
        if (otp.length != 6) {
            buttonSubmit.backgroundColor = .blueLighter
            buttonSubmit.isEnabled = false
            isSubmit = false
        } else {
            buttonSubmit.backgroundColor = .clear
            buttonSubmit.isEnabled = true
            isSubmit = true
        }
    }
    
    @objc func onConfirm() {
        let vc = SetPasswordVC()
        if isVisibleProgress {
            vc.isVisibleProgress = isVisibleProgress
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension OtpVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (textField.text!.utf16.count >= 1 && !string.isEmpty) {
            return false
        }

        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

extension OtpVC: MyTextFieldDelegate {
    func textFieldDidDelete(_ textField: UITextField) {
        if (textField.text?.isEmpty) == true {
            self.onBackspaceTf(textField, true)
        }
    }
}
