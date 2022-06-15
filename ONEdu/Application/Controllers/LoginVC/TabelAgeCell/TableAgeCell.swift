//
//  TabelAgeCell.swift
//  ONEdu
//
//  Created by Tran Dat on 13/06/2022.
//

import UIKit

class TableAgeCell: UITableViewCell {
    static let identifier = "TableAgeCell"
    
    private var boxMain: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = .blueLighter
        uiView.layer.cornerRadius = 24.0
        uiView.layer.masksToBounds = true
        return uiView
    }()
    private var imageLogo: UIImageView = {
        let image = UIImageView()
        return image
    }()
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black900
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    private var iconTick: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "checked")
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.backgroundColor = .clear
        contentView.addSubview(boxMain)
        boxMain.addSubview(imageLogo)
        boxMain.addSubview(titleLabel)
        boxMain.addSubview(iconTick)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        boxMain.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingTop: 0, paddingLeft: 32, paddingBottom: 0, paddingRight: 32)
        imageLogo.anchor(top: boxMain.topAnchor, left: boxMain.leftAnchor, bottom: boxMain.bottomAnchor, paddingTop: 14, paddingLeft: 24, paddingBottom: 14, width: 72)
        iconTick.anchor(top: boxMain.topAnchor, right: boxMain.rightAnchor, paddingTop: 14, paddingRight: 12, width: 24, height: 24)
        titleLabel.anchor(left: imageLogo.rightAnchor, right: iconTick.leftAnchor, paddingLeft: 16, paddingRight: 0)
        titleLabel.centerY(inView: boxMain)
    }
    
    func configure(_ item: AgeModel) {
        iconTick.isHidden = true
        imageLogo.image = UIImage(named: item.image)
        titleLabel.text = item.title
    }
    
    func setShowIcon() {
        iconTick.isHidden = false
        boxMain.backgroundColor = .grayLight
    }
    
    func setHideIcon() {
        iconTick.isHidden = true
        boxMain.backgroundColor = .blueLighter
    }
}
