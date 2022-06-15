//
//  BannerCarouselCell.swift
//  ONEdu
//
//  Created by Tran Dat on 02/06/2022.
//

import UIKit

class BannerCarouselCell: UICollectionViewCell {
    static let identifier = "BannerCarouselCell"
    static var cellWidth: CGFloat {
        let deviceIdiom = UIScreen.main.traitCollection.userInterfaceIdiom
        switch deviceIdiom {
        case .phone:
            return UIScreen.main.bounds.size.width - 52
        case .pad:
            return (UIScreen.main.bounds.size.width - 68)/2
        default:
            return UIScreen.main.bounds.size.width - 52
        }
    }
    
    public let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 24
        view.layer.masksToBounds = true
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.white.cgColor
        return view
    }()
    
    public var thumbnail: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    public let bannerTitle: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = AppFont.semiBold.of(style: .callout)
        label.numberOfLines = 1
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .clear
        contentView.addSubview(mainView)
        mainView.addSubview(thumbnail)
        mainView.addSubview(bannerTitle)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        mainView.anchor(top: self.topAnchor, left: self.leftAnchor, right: self.rightAnchor, height: (BannerCarouselCell.cellWidth - 4) * 9 / 16 + 44)
        
        thumbnail.anchor(top: mainView.topAnchor, left: mainView.leftAnchor, right: mainView.rightAnchor, paddingLeft: 2, paddingRight: 2, height: (BannerCarouselCell.cellWidth - 4) * 9 / 16)
        
        bannerTitle.anchor(top: thumbnail.bottomAnchor, left: self.leftAnchor, right: self.rightAnchor, paddingTop: 8, paddingLeft: 16, paddingRight: 16)
    }
    
    @objc func rotated() {
//        heightConstraint.constant = BannerCarouselCell.cellWidth * 9 / 16
    }
    
//    @objc func didGetValue(_ notification: Notification) {
//        if let obj = notification.object as? VODDetailModel {
//            if obj.id == eventObj?.id {
//                if let newEvent = eventObj {
//                    newEvent.isSetNoti = obj.isSetNoti
//                    boxStatus.configure(with: newEvent, widthStatusAnchor: widthStatusAnchor)
//                }
//            }
//        }
//    }
    
    func configure(_ banner: BannerModel) {
        thumbnail.setRemoteImg(url: banner.thumbnail)
        bannerTitle.text = banner.title
    }
}
