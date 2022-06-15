//
//  CollectionViewVC.swift
//  ONEdu
//
//  Created by Tran Dat on 07/06/2022.
//

import UIKit

class CollectionViewVC: UIViewController {
    public var type: TypeEventBlock = .series
    private var headerView: HeaderView = {
        let headerView = HeaderView()
        headerView.backgroundColor = .white
        return headerView
    }()
    private var uiView: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = .bkg
        return uiView
    }()
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 32, left: 0, bottom: 0, right: 0)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(CollectionSeriesCell.self, forCellWithReuseIdentifier: CollectionSeriesCell.identifier)
        collectionView.register(CollectionVODCell.self, forCellWithReuseIdentifier: CollectionVODCell.identifier)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(headerView)
        headerView.setConfigButton(true, self)
        
        view.addSubview(uiView)
        uiView.addSubview(collectionView)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        
        setupContraint()
    }
    
    func setupContraint() {
        headerView.anchor(top: view.safeTopAnchor, left: view.safeLeftAnchor, right: view.safeRightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, height: 36)
        uiView.anchor(top: headerView.bottomAnchor, left: view.safeLeftAnchor, bottom: view.bottomAnchor, right: view.safeRightAnchor, paddingTop: 25, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        collectionView.anchor(top: uiView.topAnchor, left: uiView.leftAnchor, bottom: uiView.bottomAnchor, right: uiView.rightAnchor, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 16)
    }
    
    func configure(_ name: String) {
        headerView.configure(name)
    }

}

extension CollectionViewVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if type == .series {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionSeriesCell.identifier, for: indexPath) as? CollectionSeriesCell else {
                return UICollectionViewCell()
            }
            cell.backgroundColor = .clear
            cell.configure(EventModel(id: 1, name: "Doraemon", type: .series, thumbnail: "https://imgonsport.vtvcab.vn/image-upload/2bb3fca9-0fbe-4146-a19b-f4a6056c0009.jpeg"))
            cell.setDisplayName(true)
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionVODCell.identifier, for: indexPath) as? CollectionVODCell else {
                return UICollectionViewCell()
            }
            cell.backgroundColor = .clear
            cell.configure(EventModel(id: 1, name: "Chuột Mickey và căn nhà huyền bí", type: type, thumbnail: "https://imgonsport.vtvcab.vn/image-upload/a8ed22d3-c5c0-45fb-8189-b87dbfdb9bd3.jpeg"))
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 16.0
        var width: CGFloat = 0.0
        if type == .series {
            width = (view.bounds.width - padding * 2) / 2 - 15
            return CGSize(width: width, height: (width * 3/2) + 30)
        } else {
            width = (view.bounds.width - padding * 2) / 2 - 15
            return CGSize(width: width, height: (width * 9/16) + 22)
        }
    }
}
