//
//  HeaderInfoView.swift
//  ONEdu
//
//  Created by Tran Dat on 02/06/2022.
//

import UIKit

class HeaderInfoView: UIView {
    var onLogin: (()-> Void)?
    var onSearch: (()-> Void)?
    
    private var logoImage: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "video-tabbar-active")
        logo.contentMode = .scaleAspectFill
        logo.layer.cornerRadius = 23.0
        logo.layer.masksToBounds = true
        logo.layer.borderWidth = 2.0
        logo.layer.borderColor = UIColor.white.cgColor
        return logo
    }()
    
    private var greetingLabel: UILabel = {
        let label = UILabel()
        label.text = "Xin chào,"
        label.textColor = UIColor(hexFromString: "#DAF6FE")
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        return label
    }()
    
    private var fullNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Hoàng Diệu Linh"
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    private var buttonLogin: UIButton = {
        let button = UIButton()
        button.setTitle("ĐĂNG NHẬP", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        button.setTitleColor(UIColor.blueDarker, for: .normal)
        button.backgroundColor = .blueLighter
        button.layer.cornerRadius = 12.0
        button.layer.masksToBounds = true
        return button
    }()
    
    private var buttonSearch: UIButton = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.setImage(UIImage(named: "search-icon"), for: .normal)
        button.backgroundColor = UIColor(hexFromString: "#4398FA")
        button.layer.cornerRadius = 18.0
        button.layer.masksToBounds = true
        return button
    }()
    
    private var ovalView: OvalView = {
        let uiView = OvalView()
        uiView.backgroundColor = .bkg
        uiView.color = .blueDarker
        return uiView
    }()
    
    private var backView: UIView = {
        let view = UIView()
        view.backgroundColor = .blueDarker
        return view
    }()
    
    override init(frame: CGRect) {
      super.init(frame: frame)
    }

    required init() {
        super.init(frame: .zero)
        backgroundColor = .clear
        setupView()
        
        buttonLogin.addTarget(self, action:#selector(onPressLogin), for: .touchUpInside)
        buttonSearch.addTarget(self, action:#selector(onPressSearching), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder): Not implemented")
    }

    func setupView() {
        addSubview(ovalView)
        addSubview(backView)
        addSubview(logoImage)
        addSubview(greetingLabel)
        addSubview(fullNameLabel)
        addSubview(buttonSearch)
        addSubview(buttonLogin)
        
        ovalView.anchor(top: self.topAnchor, paddingTop: -160, width: 596, height: 383)
        ovalView.centerX(inView: self)
        
        backView.anchor(bottom: self.bottomAnchor, width: UIScreen.main.bounds.size.width, height: 700)
        backView.centerX(inView: self)
        
        logoImage.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, paddingLeft: 16, width: 48)
        greetingLabel.anchor(top: self.topAnchor, left: logoImage.rightAnchor, paddingTop: 5, paddingLeft: 8)
        fullNameLabel.anchor(left: logoImage.rightAnchor, bottom: self.bottomAnchor, paddingLeft: 8, paddingBottom: 5)
        buttonSearch.anchor(right: self.rightAnchor, paddingRight: 16, width: 36, height: 36)
        buttonSearch.centerY(inView: self)
        
        buttonLogin.anchor(left: fullNameLabel.rightAnchor, paddingLeft: 16, width: 100, height: 30)
        buttonLogin.centerY(inView: self)
    }
    
    func configure() {
        logoImage.image = UIImage(named: "video-tabbar-active")
        fullNameLabel.text = "Na Na"
    }
    
    @objc func onPressLogin() {
        self.onLogin?()
    }
    
    @objc func onPressSearching() {
        self.onSearch?()
    }
    
}
