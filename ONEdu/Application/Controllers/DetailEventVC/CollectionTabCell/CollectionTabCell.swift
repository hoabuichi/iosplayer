//
//  CollectionTabCell.swift
//  ONEdu
//
//  Created by Tran Dat on 05/06/2022.
//

import Foundation
import UIKit

class CollectionTabCell: UICollectionViewCell {
    static let identifier = "CollectionTabCell"
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    var borderView: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = .blueBasic
        return uiView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        content add subview
        
        contentView.backgroundColor = .clear
        contentView.addSubview(titleLabel)
        contentView.addSubview(borderView)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        titleLabel.anchor(top: contentView.safeTopAnchor, left: contentView.safeLeftAnchor, bottom: contentView.safeBottomAnchor, right: contentView.safeRightAnchor)
        borderView.anchor(left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: titleLabel.rightAnchor, height: 4)
    }
    
    func setActiveLabel() {
        titleLabel.textColor = .black900
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        borderView.isHidden = false
    }
    
    func setDefaultLabel() {
        titleLabel.textColor = .black500
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        borderView.isHidden = true
    }
    
    func configure(_ name: String) {
        titleLabel.text = name
    }
}
