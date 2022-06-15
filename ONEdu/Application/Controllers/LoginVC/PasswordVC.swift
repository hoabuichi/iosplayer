//
//  PasswordVC.swift
//  ONEdu
//
//  Created by Tran Dat on 09/06/2022.
//

import UIKit

class PasswordVC: UIViewController {
    var isView: Bool = false
    var phone: String = ""
    
    private var backButton: BackButton = {
        let button = BackButton()
        return button
    }()
    
    private var titlePsw: UILabel = {
        let label = UILabel()
        label.text = "Mật khẩu"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    private var desPsw: UILabel = {
        let label = UILabel()
        label.text = "Mật khẩu phải chứa 8 kí tự trở lên bao gồm ít nhất một chữ in hoa và không chứa dấu cách"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    private var titleInputPsw: UILabel = {
        let label = UILabel()
        label.text = "Mật khẩu"
        label.textColor = .yellowBasic
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    private var tfPsw: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .clear
        textField.textColor = .white87
        textField.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        textField.borderStyle = .none
        textField.attributedPlaceholder = NSAttributedString(string: "Nhập mật khẩu của bạn", attributes: [NSAttributedString.Key.foregroundColor: UIColor.blueLighter, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .medium)])
        textField.setLeftPaddingPoints(32)
        textField.setRightPaddingPoints(32)
        return textField
    }()
    private var borderInput: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = .blueLight
        return uiView
    }()
    private var iconKey: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "key")
        return icon
    }()
    private var buttonViewIcon: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setImage(UIImage(named: "view"), for: .normal)
        return button
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
        label.text = "Mật khẩu chưa đúng định dạng!"
        label.textColor = .redLight
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
    
    private var buttonlogin: UIButton = {
        let button = UIButton()
        button.setTitle("ĐĂNG NHẬP", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.setTitleColor(UIColor.blueLight, for: .normal)
        button.backgroundColor = .blueLighter
        button.layer.cornerRadius = 12.0
        button.layer.masksToBounds = true
        button.layer.borderWidth = 4
        button.layer.borderColor = UIColor.blueLight.cgColor
        return button
    }()
    private var buttonForget: UIButton = {
        let button = UIButton()
        button.setTitle("Bạn quên mật khẩu?", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.setTitleColor(UIColor.cyanBasic, for: .normal)
        button.backgroundColor = .clear
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .blueDarker
        view.addSubview(backButton)
        backButton.configure("block-back", UIColor.blueDarker)
        backButton.isPresenter = false
        backButton.vc = self
        
        view.addSubview(titlePsw)
        view.addSubview(desPsw)
        view.addSubview(titleInputPsw)
        view.addSubview(tfPsw)
        view.addSubview(borderInput)
        view.addSubview(iconKey)
        view.addSubview(buttonViewIcon)
        view.addSubview(boxError)
        boxError.addSubview(iconError)
        boxError.addSubview(errorLabel)
        boxError.isHidden = true
        
        view.addSubview(buttonlogin)
        view.addSubview(buttonForget)
        
        setupContraint()
        
        tfPsw.delegate = self
        tfPsw.isEnabled = true
        tfPsw.isUserInteractionEnabled = true
//        tfPsw.textContentType = .password
        tfPsw.isSecureTextEntry = true
        tfPsw.addTarget(self, action: #selector(changeCharacter), for: .editingChanged)

        buttonlogin.addTarget(self, action: #selector(onLogin), for: .touchUpInside)
        buttonlogin.isEnabled = false
        buttonForget.addTarget(self, action: #selector(onForgetPsw), for: .touchUpInside)
        buttonViewIcon.addTarget(self, action: #selector(onView), for: .touchUpInside)
//        tfPsw.inputAccessoryView = toolBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
        self.setColorStatusbar()
    }
    
    func setupContraint() {
        let padding: CGFloat = 16.0

        backButton.anchor(top: view.safeTopAnchor, left: view.leftAnchor, paddingTop: 0, paddingLeft: 16, width: 36, height: 36)
        titlePsw.anchor(top: backButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 34, paddingLeft: padding, paddingRight: padding)
        desPsw.anchor(top: titlePsw.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 8, paddingLeft: padding, paddingRight: padding)
        titleInputPsw.anchor(top: desPsw.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 60, paddingLeft: padding * 2, paddingRight: padding * 2)
        tfPsw.anchor(top: titleInputPsw.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 16, paddingLeft: padding * 2, paddingRight: padding * 2)
        borderInput.anchor(left: tfPsw.leftAnchor, bottom: tfPsw.bottomAnchor, right: tfPsw.rightAnchor, paddingLeft: 0, paddingBottom: -8, paddingRight: 0, height: 1)
        iconKey.anchor(left: tfPsw.leftAnchor, paddingLeft: 0, width: 24, height: 24)
        iconKey.centerY(inView: tfPsw)
        buttonViewIcon.anchor(right: tfPsw.rightAnchor, paddingRight: 0, width: 24, height: 24)
        buttonViewIcon.centerY(inView: tfPsw)
        boxError.anchor(top: borderInput.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 8, paddingLeft: padding * 2, paddingRight: padding * 2, height: 22)
        iconError.anchor(left: boxError.leftAnchor, width: 12, height: 12)
        iconError.centerY(inView: boxError)
        errorLabel.anchor(left: iconError.rightAnchor, right: boxError.rightAnchor, paddingLeft: 8)
        errorLabel.centerY(inView: boxError)
        
        buttonlogin.anchor(left: view.leftAnchor, bottom: view.safeBottomAnchor, right: view.rightAnchor, paddingLeft: padding, paddingBottom: 20, paddingRight: padding, height: 52)
        buttonForget.anchor(left: view.leftAnchor, bottom: buttonlogin.topAnchor, right: view.rightAnchor, paddingLeft: padding, paddingBottom: 48, paddingRight: padding, width: 140, height: 30)
    }
    
    @objc func changeCharacter(textField: UITextField) {
        if (self.validatePassword(valChange: textField.text!) && textField.text!.length > 8 && !textField.text!.contains(" ")) {
            boxError.isHidden = true
            buttonlogin.backgroundColor = .clear
            buttonlogin.setTitleColor(UIColor.white, for: .normal)
            buttonlogin.isEnabled = true
        } else {
            boxError.isHidden = false
            buttonlogin.backgroundColor = .blueLighter
            buttonlogin.setTitleColor(UIColor.blueLight, for: .normal)
            buttonlogin.isEnabled = false
        }
    }
    
    @objc func onLogin() {
        self.navigationController?.dismiss(animated: true)
    }
    
    @objc func onForgetPsw() {
        let vc = ForgetPassword()
        vc.tfPhone.text = phone
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func onView() {
        isView = !isView
        tfPsw.isSecureTextEntry = !isView
    }
}

extension PasswordVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
