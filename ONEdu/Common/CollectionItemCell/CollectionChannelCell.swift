//
//  CollectionChannelCell.swift
//  ONEdu
//
//  Created by Tran Dat on 04/06/2022.
//

import UIKit

class CollectionChannelCell: UICollectionViewCell {
    static let identifier = "CollectionChannelCell"
    
    private var logo: UIImageView = {
        let logo = UIImageView()
//        logo.layer.cornerRadius = 54.0
//        logo.layer.masksToBounds = true
//        logo.layer.borderWidth = 6.0
//        logo.layer.borderColor = UIColor.red.cgColor
        return logo
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        content add subview
        
        contentView.backgroundColor = .clear
        contentView.addSubview(logo)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        logo.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor)
        let lineWidth = CGFloat(4.0)
        let rect = CGRect(x: 0.0, y: 0.0, width: contentView.bounds.width, height: contentView.bounds.width)
        let sides = 6
        let rotationOffset = CGFloat(Double.pi / 2.0)

        let path = self.roundedPolygonPath(rect: rect,
                                      lineWidth: lineWidth,
                                      sides: sides,
                                      cornerRadius: 16.0,
                                      rotationOffset: rotationOffset)

        let maskLayer = CAShapeLayer()
        maskLayer.frame = CGRect(x: 0.0, y: 0.0, width: path.bounds.width + lineWidth, height: path.bounds.height + lineWidth)
        maskLayer.path = path.cgPath
        logo.layer.mask = maskLayer
        
        let borderLayer = CAShapeLayer()
        borderLayer.path = maskLayer.path // Reuse the Bezier path
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = UIColor.white.cgColor
        borderLayer.lineWidth = lineWidth * 2
        borderLayer.frame = logo.bounds
        logo.layer.addSublayer(borderLayer)
    }
    
    func configure(_ event: EventModel) {
        logo.setRemoteImg(url: event.thumbnail)
    }
}
