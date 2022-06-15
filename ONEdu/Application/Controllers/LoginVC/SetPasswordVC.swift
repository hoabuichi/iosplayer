//
//  SetPasswordVC.swift
//  ONEdu
//
//  Created by Tran Dat on 13/06/2022.
//

import UIKit

class SetPasswordVC: UIViewController {
    var isVisibleProgress: Bool = false
    var isView: Bool = false
    var isViewRepeat: Bool = false
    
//    private var backButton: BackButton = {
//        let button = BackButton()
//        return button
//    }()
    private var headerView: HeaderRegister = {
        let header = HeaderRegister()
        header.backgroundColor = .clear
        return header
    }()
    
    private var titlePsw: UILabel = {
        let label = UILabel()
        label.text = "Đặt lại mật khẩu"
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
        label.text = "Mật khẩu mới"
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
    
    private var titleInputPswRepeat: UILabel = {
        let label = UILabel()
        label.text = "Xác nhận lại mật khẩu"
        label.textColor = .yellowBasic
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    private var tfPswRepeat: UITextField = {
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
    private var borderInputRepeat: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = .blueLight
        return uiView
    }()
    private var iconKeyRepeat: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "key")
        return icon
    }()
    private var buttonViewIconRepeat: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setImage(UIImage(named: "view"), for: .normal)
        return button
    }()
    private var boxErrorRepeat: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = .clear
        return uiView
    }()
    private var iconErrorRepeat: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "warning")
        return image
    }()
    private var errorLabelRepeat: UILabel = {
        let label = UILabel()
        label.text = "Mật khẩu chưa khớp!"
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

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .blueDarker
//        view.addSubview(backButton)
//        backButton.configure("block-back", UIColor.blueDarker)
//        backButton.isPresenter = false
//        backButton.vc = self
        view.addSubview(headerView)
        if !isVisibleProgress {
            headerView.hideProgress()
        } else {
            headerView.configure(4)
        }
        headerView.setupBackButton(false, self)
        
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
        
        view.addSubview(titleInputPswRepeat)
        view.addSubview(tfPswRepeat)
        view.addSubview(borderInputRepeat)
        view.addSubview(iconKeyRepeat)
        view.addSubview(buttonViewIconRepeat)
        view.addSubview(boxErrorRepeat)
        boxErrorRepeat.addSubview(iconErrorRepeat)
        boxErrorRepeat.addSubview(errorLabelRepeat)
        boxErrorRepeat.isHidden = true
        
        view.addSubview(buttonlogin)
        
        setupContraint()
        
        tfPsw.delegate = self
        tfPsw.isEnabled = true
        tfPsw.isUserInteractionEnabled = true
        tfPsw.isSecureTextEntry = true
        tfPsw.addTarget(self, action: #selector(changeCharacter), for: .editingChanged)
        
        tfPswRepeat.delegate = self
        tfPswRepeat.isEnabled = true
        tfPswRepeat.isUserInteractionEnabled = true
        tfPswRepeat.isSecureTextEntry = true
        tfPswRepeat.addTarget(self, action: #selector(changeCharacterRepeat), for: .editingChanged)

        buttonlogin.addTarget(self, action: #selector(onLogin), for: .touchUpInside)
        buttonlogin.isEnabled = false
        buttonViewIcon.addTarget(self, action: #selector(onView), for: .touchUpInside)
        buttonViewIconRepeat.addTarget(self, action: #selector(onViewRepeat), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
        self.setColorStatusbar()
    }
    
    func setupContraint() {
        let padding: CGFloat = 16.0

//        backButton.anchor(top: view.safeTopAnchor, left: view.leftAnchor, paddingTop: 0, paddingLeft: 16, width: 36, height: 36)
        headerView.anchor(top: view.safeTopAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 16, paddingRight: 16, height: 36)
        titlePsw.anchor(top: headerView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 34, paddingLeft: padding, paddingRight: padding)
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
        
        titleInputPswRepeat.anchor(top: boxError.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 48, paddingLeft: padding * 2, paddingRight: padding * 2)
        tfPswRepeat.anchor(top: titleInputPswRepeat.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 16, paddingLeft: padding * 2, paddingRight: padding * 2)
        borderInputRepeat.anchor(left: tfPswRepeat.leftAnchor, bottom: tfPswRepeat.bottomAnchor, right: tfPswRepeat.rightAnchor, paddingLeft: 0, paddingBottom: -8, paddingRight: 0, height: 1)
        iconKeyRepeat.anchor(left: tfPswRepeat.leftAnchor, paddingLeft: 0, width: 24, height: 24)
        iconKeyRepeat.centerY(inView: tfPswRepeat)
        buttonViewIconRepeat.anchor(right: tfPswRepeat.rightAnchor, paddingRight: 0, width: 24, height: 24)
        buttonViewIconRepeat.centerY(inView: tfPswRepeat)
        boxErrorRepeat.anchor(top: borderInputRepeat.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 8, paddingLeft: padding * 2, paddingRight: padding * 2, height: 22)
        iconErrorRepeat.anchor(left: boxErrorRepeat.leftAnchor, width: 12, height: 12)
        iconErrorRepeat.centerY(inView: boxErrorRepeat)
        errorLabelRepeat.anchor(left: iconErrorRepeat.rightAnchor, right: boxErrorRepeat.rightAnchor, paddingLeft: 8)
        errorLabelRepeat.centerY(inView: boxErrorRepeat)
        
        buttonlogin.anchor(left: view.leftAnchor, bottom: view.safeBottomAnchor, right: view.rightAnchor, paddingLeft: padding, paddingBottom: 20, paddingRight: padding, height: 52)
    }
    
    @objc func changeCharacter(textField: UITextField) {
        if (self.validatePassword(valChange: textField.text!) && textField.text!.length > 8 && !textField.text!.contains(" ")) {
            boxError.isHidden = true
        } else {
            boxError.isHidden = false
        }
    }
    
    @objc func changeCharacterRepeat(textField: UITextField) {
        if (textField.text == tfPsw.text) {
            boxErrorRepeat.isHidden = true
            buttonlogin.backgroundColor = .clear
            buttonlogin.setTitleColor(UIColor.white, for: .normal)
            buttonlogin.isEnabled = true
        } else {
            boxErrorRepeat.isHidden = false
            buttonlogin.backgroundColor = .blueLighter
            buttonlogin.setTitleColor(UIColor.blueLight, for: .normal)
            buttonlogin.isEnabled = false
        }
    }
    
    @objc func onLogin() {
        if isVisibleProgress {
            let vc = SuccessRegister()
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            self.navigationController?.dismiss(animated: true)
        }
    }
    
    @objc func onView() {
        isView = !isView
        tfPsw.isSecureTextEntry = !isView
    }
    
    @objc func onViewRepeat() {
        isViewRepeat = !isViewRepeat
        tfPswRepeat.isSecureTextEntry = !isViewRepeat
    }
}

extension SetPasswordVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
