//
//  HeaderView.swift
//  ONEdu
//
//  Created by Tran Dat on 07/06/2022.
//

import UIKit

class HeaderView: UIView {
    private var buttonBack: BackButton = {
        let button = BackButton()
        return button
    }()
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black900
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
      super.init(frame: frame)
    }
    
    required init() {
      super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
      fatalError("init(coder): Not implemented")
    }
    
    
    func setupView() {
        self.addSubview(titleLabel)
        titleLabel.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor)
        titleLabel.centerY(inView: self)
        
        self.addSubview(buttonBack)
        buttonBack.configure("block-back", .grayLight)
        buttonBack.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, width: 36)
    }
    
    func setConfigButton(_ isPresenter: Bool, _ vc: UIViewController) {
        buttonBack.isPresenter = isPresenter
        buttonBack.vc = vc
    }
    
    func configure(_ name: String) {
        titleLabel.text = name
    }
}
