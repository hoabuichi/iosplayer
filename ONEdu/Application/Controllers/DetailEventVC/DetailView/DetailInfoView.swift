//
//  DetailInfoView.swift
//  ONEdu
//
//  Created by Tran Dat on 05/06/2022.
//

import UIKit

class DetailInfoView: UIView {
    var isSeeMore: Bool = false
    var onClickSeeMore: ((Bool)-> Void)?
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black900
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.numberOfLines = 2
        return label
    }()
    private var typeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black700
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
    private var typeValueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .blueBasic
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
    private var desLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black700
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 3
        return label
    }()
    public var boxViewSeeMore: UIView = {
        let uiView = UIView()
        return uiView
    }()
    private var buttonSeemore: UIButton = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.backgroundColor = .clear
        return button
    }()
    private var seeMoreLabel: UILabel = {
        let label = UILabel()
        label.textColor = .blueBasic
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    private var iconSeeMore: UIImageView = {
        let icon = UIImageView()
        return icon
    }()
    
    override init(frame: CGRect) {
      super.init(frame: frame)
    }

    required init() {
        super.init(frame: .zero)
        
        buttonSeemore.addTarget(self, action:#selector(onPressSeeMore), for: .touchUpInside)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder): Not implemented")
    }

    func setupView() {
//        let padding: CGFloat = 16.0
//        let screenSizeWidth: CGFloat = UIScreen.main.bounds.width

        self.addSubview(titleLabel)
        titleLabel.anchor(top: self.topAnchor, left: self.leftAnchor, right: self.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0)
        
        self.addSubview(typeLabel)
        self.addSubview(typeValueLabel)
        typeLabel.anchor(top: titleLabel.bottomAnchor, left: self.leftAnchor, paddingTop: 10, paddingLeft: 0)
        typeValueLabel.anchor(top: titleLabel.bottomAnchor, left: typeLabel.rightAnchor, paddingTop: 10, paddingLeft: 0)
        
        self.addSubview(desLabel)
        desLabel.anchor(top: typeLabel.bottomAnchor, left: self.leftAnchor, right: self.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingRight: 0)

        self.addSubview(boxViewSeeMore)
        boxViewSeeMore.anchor(top: desLabel.bottomAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, height: 22)
        boxViewSeeMore.addSubview(seeMoreLabel)
        boxViewSeeMore.addSubview(iconSeeMore)
        seeMoreLabel.anchor(top: boxViewSeeMore.topAnchor, left: boxViewSeeMore.leftAnchor, bottom: boxViewSeeMore.bottomAnchor)
        iconSeeMore.anchor(left: seeMoreLabel.rightAnchor, paddingLeft: 4, width: 12, height: 12)
        iconSeeMore.centerY(inView: seeMoreLabel)
        self.addSubview(buttonSeemore)
        buttonSeemore.anchor(top: boxViewSeeMore.topAnchor, left: boxViewSeeMore.leftAnchor, bottom: boxViewSeeMore.bottomAnchor, right: iconSeeMore.rightAnchor)
    }
    
    func configure(_ data: DetailInfoModel) {
        titleLabel.text = data.title
        typeLabel.text = "Thể loại: "
        typeValueLabel.text = data.typeText
        desLabel.text = data.des
//        textDes = ""
        seeMoreLabel.text = "Xem chi tiết"
        iconSeeMore.image = UIImage(named: "down-arrow")
    }
    
    @objc func onPressSeeMore() {
        print("AAAAA")
        isSeeMore = !isSeeMore
        if !isSeeMore {
            iconSeeMore.image = UIImage(named: "down-arrow")
            seeMoreLabel.text = "Xem chi tiết"
            desLabel.numberOfLines = 3
        } else {
            seeMoreLabel.text = "Thu gọn"
            iconSeeMore.image = UIImage(named: "up-arrow")
            desLabel.numberOfLines = 0
        }
        self.onClickSeeMore?(isSeeMore)
    }
}

