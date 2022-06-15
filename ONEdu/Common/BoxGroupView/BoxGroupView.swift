//
//  BoxGroupView.swift
//  ONEdu
//
//  Created by Tran Dat on 31/05/2022.
//

import UIKit

class BoxGroupView: UIView {
    var onClickSeeMore: (()-> Void)?
    
    var uiView: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = .clear
        return uiView
    }()
    var logoGroup: UIImageView = {
        let image = UIImageView()
        return image
    }()
    var groupTitle: UILabel = {
        let label = UILabel()
        label.textColor = .black900
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    var buttonSeeMore: UIButton = {
        let button = UIButton()
        button.setTitle("Xem thêm", for: .normal)
        button.setTitleColor(.blueBasic, for: .normal)
        button.backgroundColor = .clear
        return button
    }()
    
    override init(frame: CGRect) {
      super.init(frame: frame)
    }

    required init() {
        super.init(frame: .zero)

        buttonSeeMore.addTarget(self, action:#selector(onPressSeeMore), for: .touchUpInside)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder): Not implemented")
    }

    func setupView() {
        let heightView: CGFloat = 30.0

        self.addSubview(uiView)
        uiView.addSubview(logoGroup)
        uiView.addSubview(groupTitle)
        uiView.addSubview(buttonSeeMore)
        
        uiView.anchor(top: self.safeTopAnchor, left: self.safeLeftAnchor, right: self.safeRightAnchor, paddingTop: 0, paddingLeft: 16, paddingRight: 16, height: heightView)
        logoGroup.anchor(left: uiView.leftAnchor, paddingLeft: 0, width: 24, height: 24)
        logoGroup.centerY(inView: uiView)
        buttonSeeMore.anchor(right: uiView.rightAnchor, paddingRight: 0, width: 60, height: 18)
        buttonSeeMore.centerY(inView: uiView)
        groupTitle.anchor(top: uiView.topAnchor, left: logoGroup.rightAnchor, bottom: uiView.bottomAnchor, right: buttonSeeMore.leftAnchor, paddingTop: 0, paddingLeft: 9, paddingBottom: 0, paddingRight: 10)
    }
    
    func configure() {
        logoGroup.image = UIImage(named: "books-tabbar-active")
        groupTitle.text = "Mickeymouse"
    }
    
    @objc func onPressSeeMore() {
        self.onClickSeeMore?()
    }
}
