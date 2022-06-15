//
//  TableBLockChannelCell.swift
//  ONEdu
//
//  Created by Tran Dat on 08/06/2022.
//

import UIKit

class TableBLockChannelCell: UITableViewCell {
    static let identifier = "TableBLockChannelCell"
    var list: [ItemChannel] = []
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black900
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(CollectionChannelCell.self, forCellWithReuseIdentifier: CollectionChannelCell.identifier)
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.backgroundColor = .clear
        contentView.addSubview(titleLabel)
        contentView.addSubview(collectionView)
        collectionView.backgroundColor = .bkg
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, height: 24)
        collectionView.anchor(top: titleLabel.bottomAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingTop: 16, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
    }
    
    func configure(_ block: BlockChanel) {
        titleLabel.text = block.name
        list = block.list
    }
}

extension TableBLockChannelCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = list[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionChannelCell.identifier, for: indexPath) as? CollectionChannelCell else {
            return UICollectionViewCell()
        }
        cell.backgroundColor = .clear
        cell.configure(EventModel(id: 1, name: "", type: .channel, thumbnail: item.thumb))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSizeWidth: CGFloat = TableChannelVC.widthItemChannel
        return CGSize(width: screenSizeWidth, height: screenSizeWidth)
    }
}
