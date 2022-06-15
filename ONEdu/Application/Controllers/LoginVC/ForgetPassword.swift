//
//  ForgetPassword.swift
//  ONEdu
//
//  Created by Tran Dat on 14/06/2022.
//

import UIKit

class ForgetPassword: UIViewController {
    private var backButton: BackButton = {
        let button = BackButton()
        return button
    }()
    
    private var titleForget: UILabel = {
        let label = UILabel()
        label.text = "Quên mật khẩu"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    private var desForget: UILabel = {
        let label = UILabel()
        label.text = "Nhập số điện thoại để nhận OTP đặt lại mật khẩu"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    private var titlePhone: UILabel = {
        let label = UILabel()
        label.text = "Số điện thoại"
        label.textColor = .yellowBasic
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    public var tfPhone: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .clear
        textField.textColor = .white87
        textField.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        textField.borderStyle = .none
        textField.attributedPlaceholder = NSAttributedString(string: "Nhập số điện thoại", attributes: [NSAttributedString.Key.foregroundColor: UIColor.blueLighter, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .medium)])
        textField.setLeftPaddingPoints(44)
        return textField
    }()
    private var borderInput: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = .blueLight
        return uiView
    }()
    private var iconPhone: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "phone-input")
        return icon
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
        label.text = "Số điện thoại chưa đúng định dạng"
        label.textColor = .redLight
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
    
    private var buttonContinue: UIButton = {
        let button = UIButton()
        button.setTitle("TIẾP TỤC", for: .normal)
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
        view.addSubview(backButton)
        backButton.configure("block-back", UIColor.blueDarker)
        backButton.isPresenter = false
        backButton.vc = self
        
        view.addSubview(titleForget)
        view.addSubview(desForget)
        view.addSubview(titlePhone)
        view.addSubview(tfPhone)
        view.addSubview(borderInput)
        view.addSubview(iconPhone)
        view.addSubview(boxError)
        boxError.addSubview(iconError)
        boxError.addSubview(errorLabel)
        changeCharacter(textField: tfPhone)
        
        view.addSubview(buttonContinue)

        setupContraint()
        
        tfPhone.isEnabled = true
        tfPhone.isUserInteractionEnabled = true
        tfPhone.textContentType = .telephoneNumber
        tfPhone.keyboardType = .phonePad
        tfPhone.addTarget(self, action: #selector(changeCharacter), for: .editingChanged)
        tfPhone.inputAccessoryView = toolBar()
        
        buttonContinue.addTarget(self, action: #selector(onContinue), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
        self.setColorStatusbar()
    }
    
    func setupContraint() {
        let padding: CGFloat = 16.0
        
        backButton.anchor(top: view.safeTopAnchor, left: view.leftAnchor, paddingTop: 0, paddingLeft: 16, width: 36, height: 36)
        titleForget.anchor(top: backButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 34, paddingLeft: padding, paddingRight: padding)
        desForget.anchor(top: titleForget.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 8, paddingLeft: padding, paddingRight: padding)
        titlePhone.anchor(top: desForget.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 60, paddingLeft: padding, paddingRight: padding)
        tfPhone.anchor(top: titlePhone.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 16, paddingLeft: padding, paddingRight: padding)
        borderInput.anchor(left: tfPhone.leftAnchor, bottom: tfPhone.bottomAnchor, right: tfPhone.rightAnchor, paddingLeft: 0, paddingBottom: -8, paddingRight: 0, height: 1)
        iconPhone.anchor(left: tfPhone.leftAnchor, paddingLeft: 5, width: 24, height: 24)
        iconPhone.centerY(inView: tfPhone)
        
        boxError.anchor(top: borderInput.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 8, paddingLeft: padding * 2, paddingRight: padding * 2, height: 22)
        iconError.anchor(left: boxError.leftAnchor, width: 12, height: 12)
        iconError.centerY(inView: boxError)
        errorLabel.anchor(left: iconError.rightAnchor, right: boxError.rightAnchor, paddingLeft: 8)
        errorLabel.centerY(inView: boxError)
        
        buttonContinue.anchor(left: view.leftAnchor, bottom: view.safeBottomAnchor, right: view.rightAnchor, paddingLeft: padding, paddingBottom: 20, paddingRight: padding, height: 52)
    }
    
    @objc func changeCharacter(textField: UITextField) {
        if (self.validatePhone(valChange: textField.text!)) {
            boxError.isHidden = true
            buttonContinue.backgroundColor = .clear
            buttonContinue.setTitleColor(UIColor.white, for: .normal)
            buttonContinue.isEnabled = true
        } else {
            boxError.isHidden = false
            buttonContinue.backgroundColor = .blueLighter
            buttonContinue.setTitleColor(UIColor.blueLight, for: .normal)
            buttonContinue.isEnabled = false
        }
    }
    
    @objc func onContinue() {
        let vc = OtpVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
