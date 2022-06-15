//
//  TableItemCell.swift
//  ONEdu
//
//  Created by Tran Dat on 31/05/2022.
//

import UIKit

class TableItemCell: UITableViewCell {
    static let identifier = "TableItemCell"
    var item: HomeModel? = nil
    var onClickItem: ((EventModel)-> Void)?
    
    var onClickSeeMore: (()-> Void)?
    
    var uiView: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = .clear
        return uiView
    }()
    var logoGroup: UIImageView = {
        let image = UIImageView()
        return image
    }()
    var groupTitle: UILabel = {
        let label = UILabel()
        label.textColor = .black900
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    var buttonSeeMore: UIButton = { 
        let button = UIButton()
        button.setTitle("Xem thêm", for: .normal)
        button.setTitleColor(.blueBasic, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        button.backgroundColor = .clear
        return button
    }()
    var collectionItemView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(CollectionVODCell.self, forCellWithReuseIdentifier: CollectionVODCell.identifier)
        collectionView.register(CollectionChannelCell.self, forCellWithReuseIdentifier: CollectionChannelCell.identifier)
        collectionView.register(CollectionSeriesCell.self, forCellWithReuseIdentifier: CollectionSeriesCell.identifier)
        return collectionView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.backgroundColor = .clear
        contentView.addSubview(uiView)
        uiView.addSubview(logoGroup)
        uiView.addSubview(groupTitle)
        uiView.addSubview(buttonSeeMore)
        
        contentView.addSubview(collectionItemView)
        collectionItemView.backgroundColor = .clear
        collectionItemView.delegate = self
        collectionItemView.dataSource = self
        
        buttonSeeMore.addTarget(self, action:#selector(onPressSeeMore), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let heightView: CGFloat = 30.0
        
        uiView.anchor(top: contentView.safeTopAnchor, left: contentView.safeLeftAnchor, right: contentView.safeRightAnchor, paddingTop: 0, paddingLeft: 16, paddingRight: 16, height: heightView)
        logoGroup.anchor(left: uiView.leftAnchor, paddingLeft: 0, width: 24, height: 24)
        logoGroup.centerY(inView: uiView)
        buttonSeeMore.anchor(right: uiView.rightAnchor, paddingRight: 0, width: 60, height: 18)
        buttonSeeMore.centerY(inView: uiView)
        groupTitle.anchor(top: uiView.topAnchor, left: logoGroup.rightAnchor, bottom: uiView.bottomAnchor, right: buttonSeeMore.leftAnchor, paddingTop: 0, paddingLeft: 9, paddingBottom: 0, paddingRight: 10)
        
        collectionItemView.anchor(top: uiView.bottomAnchor, left: contentView.safeLeftAnchor, bottom: contentView.safeBottomAnchor, right: contentView.safeRightAnchor, paddingTop: 16, paddingLeft: 0, paddingBottom: 32, paddingRight: 0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(_ data: HomeModel) {
        logoGroup.setRemoteImg(url: data.logo)
        groupTitle.text = data.nameBLock
        
        item = data
    }
    
    @objc func onPressSeeMore() {
        self.onClickSeeMore?()
    }
}

extension TableItemCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let _data = item?.listEvent {
            return _data.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("select: \(indexPath.row)")
        if let _event = item?.listEvent {
            self.onClickItem?(_event[indexPath.row])
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let data = item?.listEvent[indexPath.row]
        if data?.type == .series {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionSeriesCell.identifier, for: indexPath) as? CollectionSeriesCell else {
                return UICollectionViewCell()
            }
            cell.backgroundColor = .clear
            cell.setDisplayName(false)
            if let _data = data {
                cell.configure(_data)
            }
            return cell
        } else if data?.type == .channel {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionChannelCell.identifier, for: indexPath) as? CollectionChannelCell else {
                return UICollectionViewCell()
            }
            cell.backgroundColor = .clear
            if let _data = data {
                cell.configure(_data)
            }
            return cell
        } else if data?.type == .category || data?.type == .live {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionVODCell.identifier, for: indexPath) as? CollectionVODCell else {
                return UICollectionViewCell()
            }
            cell.backgroundColor = .clear
            if let _data = data {
                cell.configure(_data)
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let data = item?.listEvent[indexPath.row]
        if data?.type == .category || data?.type == .live {
            return CGSize(width: 200.0, height: 142.0)
        } else if data?.type == .channel {
            return CGSize(width: 108.0, height: 108.0)
        } else {
            return CGSize(width: 128.0, height: 193.0)
        }
    }
}
