//
//  RelateVC.swift
//  ONEdu
//
//  Created by Tran Dat on 05/06/2022.
//

import UIKit

class RelateVC: UIViewController {
    var hideDetailInfo: (()-> Void)?
    var displayDetailInfo: (()-> Void)?
    var lastContentOffset: CGFloat = 0

    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(CollectionSeriesCell.self, forCellWithReuseIdentifier: CollectionSeriesCell.identifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        collectionView.backgroundColor = .bkg
        collectionView.delegate = self
        collectionView.dataSource = self

        setupContraint()
    }
    
    func setupContraint() {
        collectionView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingLeft: 16, paddingRight: 16)
    }
}

extension RelateVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let data = EventModel(id: 1, name: "Doraemon", type: .series, thumbnail: "https://imgonsport.vtvcab.vn/image-upload/2bb3fca9-0fbe-4146-a19b-f4a6056c0009.jpeg")
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionSeriesCell.identifier, for: indexPath) as? CollectionSeriesCell else {
            return UICollectionViewCell()
        }
        cell.backgroundColor = .clear
        cell.configure(data)
        cell.setDisplayName(true)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 16.0
        let width: CGFloat = (view.bounds.width - padding * 2) / 2 - 15
        return CGSize(width: width, height: (width * 3/2) + 30)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.lastContentOffset = scrollView.contentOffset.y
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.lastContentOffset < scrollView.contentOffset.y {
            // print("did move up")
            if scrollView.contentOffset.y > 30.0 {
                self.hideDetailInfo?()
            }
        } else if self.lastContentOffset > scrollView.contentOffset.y {
            // print("did move down")
            if scrollView.contentOffset.y < 0.0 {
                self.displayDetailInfo?()
            }
        } else {
            // print("didn't move")
        }
    }
}
