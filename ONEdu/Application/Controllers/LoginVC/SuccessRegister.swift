//
//  SuccessRegister.swift
//  ONEdu
//
//  Created by Tran Dat on 14/06/2022.
//

import UIKit

class SuccessRegister: UIViewController {
    private var titleRegister: UILabel = {
        let label = UILabel()
        label.text = "ĐĂNG KÝ THÀNH CÔNG!"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    private var desRegister: UILabel = {
        let label = UILabel()
        label.text = "Chúc mừng bạn đã đăng ký thành công. Truy cập tới trang chủ để xem những nội dung cực hấp dẫn."
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    private var buttonHome: UIButton = {
        let button = UIButton()
        button.setTitle("TỚI TRANG CHỦ", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.setTitleColor(UIColor.blueLight, for: .normal)
        button.backgroundColor = .blueLighter
        button.layer.cornerRadius = 12.0
        button.layer.masksToBounds = true
        button.layer.borderWidth = 4
        button.layer.borderColor = UIColor.blueLight.cgColor
        return button
    }()
    private var imageBackground: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "background-success")
        return image
    }()
    private var imageMusician: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "musician")
        return image
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .blueDarker
        view.addSubview(imageBackground)
        view.addSubview(titleRegister)
        view.addSubview(desRegister)
        view.addSubview(buttonHome)
        view.addSubview(imageMusician)
        
        setupContraint()
        
        buttonHome.addTarget(self, action: #selector(onBackHome), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
        self.setColorStatusbar()
    }
    
    func setupContraint() {
        let padding: CGFloat = 16.0
        
        imageBackground.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        titleRegister.anchor(top: view.safeTopAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 80, paddingLeft: padding, paddingRight: padding)
        desRegister.anchor(top: titleRegister.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 8, paddingLeft: padding, paddingRight: padding)
        buttonHome.anchor(top: desRegister.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft: padding, paddingRight: padding, height: 52)
        imageMusician.anchor(left: view.leftAnchor, bottom: view.safeBottomAnchor, paddingLeft: 42, paddingBottom: 80, width: 306, height: 306)
    }
    
    @objc func onBackHome() {
        self.navigationController?.dismiss(animated: true)
    }
}
