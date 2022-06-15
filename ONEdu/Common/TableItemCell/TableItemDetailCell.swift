//
//  CollectionItemDetailCell.swift
//  ONEdu
//
//  Created by Tran Dat on 06/06/2022.
//

import UIKit

class TableItemDetailCell: UITableViewCell {
    static let identifier = "TableItemDetailCell"
    
    private var thumbImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 16.0
        image.layer.masksToBounds = true
        image.layer.borderWidth = 2.0
        image.layer.borderColor = UIColor.white.cgColor
        return image
    }()
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black900
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.numberOfLines = 3
        return label
    }()
    private var timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black500
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        return label
    }()
    
    var boxStatus: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = .white
        uiView.layer.cornerRadius = 8.0
        uiView.layer.masksToBounds = true
        return uiView
    }()
    var statusView: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = .redDark
        uiView.layer.cornerRadius = 3.0
        uiView.layer.masksToBounds = true
        return uiView
    }()
    var statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Trực tiếp"
        label.textColor = .black900
        label.font = UIFont.systemFont(ofSize: 10, weight: .semibold)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.backgroundColor = .clear
        contentView.addSubview(thumbImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(timeLabel)
        
        contentView.addSubview(boxStatus)
        boxStatus.addSubview(statusView)
        boxStatus.addSubview(statusLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let height = self.bounds.height
//        let paddingTop: CGFloat = 10.0
        let padding: CGFloat = 16.0

        thumbImage.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, paddingTop: 0, paddingLeft: padding, width: height * (16/9), height: height)
        titleLabel.anchor(top: contentView.topAnchor, left: thumbImage.rightAnchor, right: contentView.rightAnchor, paddingTop: 3, paddingLeft: 9, paddingRight: padding)
        timeLabel.anchor(top: titleLabel.bottomAnchor, left: thumbImage.rightAnchor, right: contentView.rightAnchor, paddingTop: 8, paddingLeft: 9, paddingRight: padding)
        
        boxStatus.anchor(bottom: thumbImage.bottomAnchor, right: thumbImage.rightAnchor, paddingBottom: 8, paddingRight: 8, height: 14)
        statusView.anchor(left: boxStatus.leftAnchor, paddingLeft: 4, width: 6, height: 6)
        statusView.centerY(inView: boxStatus)
        statusLabel.anchor(top: boxStatus.topAnchor, left: statusView.rightAnchor, bottom: boxStatus.bottomAnchor, right: boxStatus.rightAnchor, paddingTop: 0, paddingLeft: 2, paddingBottom: 0, paddingRight: 4)
    }
    
    func configure() {
        thumbImage.setRemoteImg(url: "https://imgonsport.vtvcab.vn/image-upload/a8ed22d3-c5c0-45fb-8189-b87dbfdb9bd3.jpeg")
        titleLabel.text = "Doraemon mùa 1 - Tập 2: Cỗ máy thời gian của Doremon"
        timeLabel.text = "01:30:00"
        boxStatus.isHidden = true
    }
    
    func configureTypeLive() {
        boxStatus.isHidden = false
        thumbImage.setRemoteImg(url: "https://imgonsport.vtvcab.vn/image-upload/a8ed22d3-c5c0-45fb-8189-b87dbfdb9bd3.jpeg")
        titleLabel.text = "Trực tiếp Street dance Việt Nam - Bước nhảy đường phố phần 3"
        timeLabel.text = "08:00 | 01/01"
    }
}
