//
//  BannerTableCell.swift
//  ONEdu
//
//  Created by will on 08/06/2022.
//

import UIKit

class BannerTableCell: UITableViewHeaderFooterView {
    static let identifier = "BannerTableCell"
    var vc: UIViewController?
    private var collectionViewFlowLayout: CustomBannerFlowLayout?
    var banners: [BannerModel] = [BannerModel]() {
        didSet {
            bannerCollection.reloadData()
        }
    }
    var timer = Timer()
    var count = 0
    
    static var cellHeight: CGFloat {
       16 + 48 + 16 + BannerCarouselCell.cellWidth * 9 / 16 + 44 + 40
   }
    
    func setupCollectionViewFlowLayout(_ collectionView: UICollectionView) {
       collectionViewFlowLayout = CustomBannerFlowLayout(itemSize: CGSize(width: BannerCarouselCell.cellWidth, height: BannerCarouselCell.cellWidth * 9 / 16 + 44))
       bannerCollection.collectionViewLayout = collectionViewFlowLayout!
    }
    
    private var headerInfoView: HeaderInfoView = {
        let uiView = HeaderInfoView()
        return uiView
    }()
    
    private let bannerCollection: UICollectionView = {
        let collectionViewFlowLayout = CustomBannerFlowLayout(itemSize: CGSize(width: BannerCarouselCell.cellWidth, height: BannerCarouselCell.cellWidth * 9 / 16 + 44))
        let collection = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collection.register(BannerCarouselCell.self, forCellWithReuseIdentifier: BannerCarouselCell.identifier)
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        style()
        contentView.addSubview(headerInfoView)
        headerInfoView.onLogin = {
            let navVc = UINavigationController(rootViewController: FirstLoginVC())
            navVc.isNavigationBarHidden = true
            navVc.modalPresentationStyle = .fullScreen
            self.vc?.present(navVc, animated: true, completion: nil)
        }
        headerInfoView.onSearch = {
            let vcSearch = SearchBarVC()
            vcSearch.modalPresentationStyle = .fullScreen
            self.vc?.present(vcSearch, animated: true)
        }
        contentView.addSubview(bannerCollection)
        bannerCollection.delegate = self
        bannerCollection.dataSource = self
        
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
    }
    
    func configure(with object: BannerBlock) {
       self.banners = object.banners
       bannerCollection.reloadData()
       if(count == 0 && self.banners.count > 0) {
           count = self.banners.count * 500
           let index = IndexPath.init(item: count, section: 0)
           self.bannerCollection.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
       }
    }
    
    @objc func changeImage() {
        if self.banners.count > 0 {
            if count < self.banners.count * 1000 {
                let index = IndexPath.init(item: count, section: 0)
                self.bannerCollection.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
                count += 1
            } else {
                count = self.banners.count * 500
                let index = IndexPath.init(item: count, section: 0)
                self.bannerCollection.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
                count += 1
            }
        }
    }
    
    func style() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        tintColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        headerInfoView.anchor(top: self.topAnchor, left: self.leftAnchor, right: self.rightAnchor, paddingTop: 16, height: 48)
        bannerCollection.anchor(top: headerInfoView.bottomAnchor, left: self.leftAnchor, right: self.rightAnchor, paddingTop: 16, height: BannerCarouselCell.cellWidth * 9 / 16 + 44)
    }
}

// MARK: UICollectionView Delegate
extension BannerTableCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return banners.count * 1000
   }

   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let cell = bannerCollection.dequeueReusableCell(withReuseIdentifier: BannerCarouselCell.identifier, for: indexPath) as! BannerCarouselCell
       cell.configure(banners[indexPath.row % banners.count])
       return cell
   }

   func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       print("ok")
   }

   func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
       targetContentOffset.pointee = scrollView.contentOffset
       var indexes = self.bannerCollection.indexPathsForVisibleItems
       indexes.sort()
       var index = indexes.first!

       if velocity.x > 0 {
              index.row += 1
       } else if velocity.x == 0 {
           let cell = self.bannerCollection.cellForItem(at: index)!
           let position = self.bannerCollection.contentOffset.x - cell.frame.origin.x
           if position > cell.frame.size.width / 2 {
              index.row += 1
           }
       }
       count = index.row
       self.bannerCollection.scrollToItem(at: index, at: .centeredHorizontally, animated: true )
   }
}
