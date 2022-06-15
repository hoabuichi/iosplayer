//
//  FirstLoginVC.swift
//  ONEdu
//
//  Created by Tran Dat on 09/06/2022.
//

import UIKit

class FirstLoginVC: UIViewController {
    private var bigImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "big-image-login")
        return image
    }()
    private var titleExist: UILabel = {
        let label = UILabel()
        label.text = "Đã có tài khoản?"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    private var titleContinue: UILabel = {
        let label = UILabel()
        label.text = "Tiếp tục xem nội dung bạn đã lựa chọn."
        label.textColor = .blueLight
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    private var buttonLogin: UIButton = {
        let button = UIButton()
        button.setTitle("ĐĂNG NHẬP", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.setTitleColor(UIColor.blueDarker, for: .normal)
        button.backgroundColor = .blueLighter
        button.layer.cornerRadius = 12.0
        button.layer.masksToBounds = true
        return button
    }()
    private var buttonSignUp: UIButton = {
        let button = UIButton()
        button.setTitle("ĐĂNG KÝ", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 12.0
        button.layer.masksToBounds = true
        button.layer.borderWidth = 4
        button.layer.borderColor = UIColor.white.cgColor
        return button
    }()
    private var titleStart: UILabel = {
        let label = UILabel()
        label.text = "Bắt đầu ngay để xem video mới hấp dẫn mỗi ngày!"
        label.textColor = .blueLight
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    private var titleNew: UILabel = {
        let label = UILabel()
        label.text = "Bạn mới tham gia ON Edu?"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .center
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .blueDarker
        view.addSubview(bigImage)
        view.addSubview(titleExist)
        view.addSubview(titleContinue)
        view.addSubview(buttonLogin)
        
        view.addSubview(buttonSignUp)
        view.addSubview(titleStart)
        view.addSubview(titleNew)
        
        setupContraint()
        buttonLogin.addTarget(self, action:#selector(onLogin), for: .touchUpInside)
        buttonSignUp.addTarget(self, action:#selector(onSignUp), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
        self.setColorStatusbar()
    }

    func setupContraint() {
        let screenSizeHeight: CGFloat = UIScreen.main.bounds.height
        let padding: CGFloat = 16
        bigImage.anchor(top: view.safeTopAnchor, paddingTop: 0, width: screenSizeHeight*0.42, height: screenSizeHeight*0.42)
        bigImage.centerX(inView: view)
        titleExist.anchor(top: bigImage.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 36, paddingLeft: padding, paddingRight: padding)
        titleContinue.anchor(top: titleExist.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 5, paddingLeft: padding, paddingRight: padding)
        buttonLogin.anchor(top: titleContinue.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 16, paddingLeft: padding, paddingRight: padding, height: 52)
        
        buttonSignUp.anchor(left: view.leftAnchor, bottom: view.safeBottomAnchor, right: view.rightAnchor, paddingLeft: padding, paddingBottom: 20, paddingRight: padding, height: 52)
        titleStart.anchor(left: view.leftAnchor, bottom: buttonSignUp.topAnchor, right: view.rightAnchor, paddingLeft: padding, paddingBottom: 16, paddingRight: padding)
        titleNew.anchor(left: view.leftAnchor, bottom: titleStart.topAnchor, right: view.rightAnchor, paddingLeft: padding, paddingBottom: 5, paddingRight: padding)
    }
    
    @objc func onLogin() {
        let vc = LoginVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func onSignUp() {
        let vc = AgeChoiceVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
