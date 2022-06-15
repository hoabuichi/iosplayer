//
//  CollectionSeriesCell.swift
//  ONEdu
//
//  Created by Tran Dat on 04/06/2022.
//

import UIKit

class CollectionSeriesCell: UICollectionViewCell {
    static let identifier = "CollectionSeriesCell"
    private var isShowingText: Bool = false
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 16.0
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 4.0
        imageView.layer.borderColor = UIColor.white.cgColor
        return imageView
    }()
    private var titlelabel: UILabel = {
        let label = UILabel()
        label.textColor = .black700
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        content add subview
        
        contentView.backgroundColor = .clear
        contentView.addSubview(imageView)
        contentView.addSubview(titlelabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var height: CGFloat = 0.0
        if isShowingText {
            height = contentView.bounds.height - 30
        } else {
            height = contentView.bounds.height
        }
        imageView.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, height: height)
        titlelabel.anchor(top: imageView.bottomAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
    }
    
    func configure(_ event: EventModel) {
        imageView.setRemoteImg(url: event.thumbnail)
        titlelabel.text = "Doraemon"
    }
    
    func setDisplayName(_ isDisplay: Bool) {
        if isDisplay {
            titlelabel.isHidden = false
        } else {
            titlelabel.isHidden = true
        }
        isShowingText = isDisplay
    }
}
