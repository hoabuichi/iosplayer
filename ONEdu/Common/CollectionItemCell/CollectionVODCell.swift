//
//  CollectionItemCell.swift
//  ONEdu
//
//  Created by Tran Dat on 31/05/2022.
//

import UIKit

class CollectionVODCell: UICollectionViewCell {
    static let identifier = "CollectionItemCell"
    
    var thumbnail: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.backgroundColor = .red
        image.layer.borderWidth = 4.0
        image.layer.borderColor = UIColor(hexFromString: "#FFFFFF").cgColor
        image.layer.cornerRadius = 16.0
        image.layer.masksToBounds = true
        return image
    }()
    var timeLabel: PaddingLabel = {
        let label = PaddingLabel()
        label.textColor = .black900
        label.font = UIFont.systemFont(ofSize: 10, weight: .semibold)
        label.topInset = 2
        label.bottomInset = 2
        label.leftInset = 4
        label.rightInset = 4
        label.backgroundColor = .white
        label.layer.cornerRadius = 6.0
        label.layer.masksToBounds = true
        return label
    }()
    var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black700
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        content add subview
        
        contentView.backgroundColor = .clear
        contentView.addSubview(thumbnail)
        contentView.addSubview(timeLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(boxStatus)
        boxStatus.addSubview(statusView)
        boxStatus.addSubview(statusLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        thumbnail.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, height: contentView.bounds.width * (9/16))
        timeLabel.anchor(bottom: thumbnail.bottomAnchor, right: thumbnail.rightAnchor, paddingBottom: 8, paddingRight: 8)
        titleLabel.anchor(top: thumbnail.bottomAnchor, left: contentView.safeLeftAnchor, right: contentView.safeRightAnchor, paddingTop: 9, paddingLeft: 16, paddingRight: 16)
        
        boxStatus.anchor(bottom: thumbnail.bottomAnchor, right: thumbnail.rightAnchor, paddingBottom: 8, paddingRight: 8, height: 14)
        statusView.anchor(left: boxStatus.leftAnchor, paddingLeft: 4, width: 6, height: 6)
        statusView.centerY(inView: boxStatus)
        statusLabel.anchor(top: boxStatus.topAnchor, left: statusView.rightAnchor, bottom: boxStatus.bottomAnchor, right: boxStatus.rightAnchor, paddingTop: 0, paddingLeft: 2, paddingBottom: 0, paddingRight: 4)
    }
    
    func configure(_ data: EventModel) {
        thumbnail.setRemoteImg(url: data.thumbnail)
        timeLabel.text = "03:50"
        titleLabel.text = data.name
        
        if data.type == .category {
            timeLabel.isHidden = false
            boxStatus.isHidden = true
        } else {
            timeLabel.isHidden = true
            boxStatus.isHidden = false
        }
    }
}
