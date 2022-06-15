//
//  DetailEventVC.swift
//  ONEdu
//
//  Created by Tran Dat on 05/06/2022.
//

import UIKit

struct DetailInfoModel {
    var title: String = ""
    var des: String = ""
    var typeText: String = ""
}

class DetailEventVC: UIViewController {
    var dataInfo: DetailInfoModel = DetailInfoModel(title: "Doraemon mùa 1 - tập 2: Cỗ máy thời gian của Doraemon", des: "Description series: Sau một nến đỏ dài là một nến nhỏ xanh/đen (đây là nến ngôi sao) và tạo khoảng trống phía dưới cây nến đỏ trước đó. Nến thứ 3 aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa", typeText: "Xem chi tiết")
    let padding: CGFloat = 16.0
    var currentIndex: Int = 0 {
        didSet {
            collectionView.reloadData()
        }
    }
    var subControllers: [UIViewController] = []
    var tabs: [String] = ["Tập", "Nội dung liên quan"]
    var heightDetailInfo: CGFloat = 0.0
    var topAnchorCollection: NSLayoutConstraint?
    var topAnchorCollectionNew: NSLayoutConstraint?
    var playViewBottomAnchorCollection: NSLayoutConstraint?
    var playViewHeightAnchorCollection: NSLayoutConstraint?
    
    private var playerView: VideoPlayer = {
        let view = VideoPlayer()
        return view
    }()
    
    private var detailInfoView: DetailInfoView = {
        let uiView = DetailInfoView()
        uiView.backgroundColor = .clear
        return uiView
    }()
    
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = false
        collectionView.register(CollectionTabCell.self, forCellWithReuseIdentifier: CollectionTabCell.identifier)
        return collectionView
    }()
    
    private var pageView: PagingView = {
        let page = PagingView()
        page.backgroundColor = .clear
        return page
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .bkg
        // Do any additional setup after loading the view.
        
        view.addSubview(playerView)
        view.addSubview(detailInfoView)
        view.addSubview(collectionView)
        view.addSubview(pageView)

        detailInfoView.configure(dataInfo)
        
        collectionView.delegate = self
        collectionView.dataSource = self

        let seriesVC = SeriesVC()
        seriesVC.hideDetailInfo = {[weak self] in
            self?.onHideInfo()
        }
        seriesVC.displayDetailInfo = {[weak self] in
            self?.onDisplayInfo()
        }
        let relateVC = RelateVC()
        relateVC.hideDetailInfo = {[weak self] in
            self?.onHideInfo()
        }
        relateVC.displayDetailInfo = {[weak self] in
            self?.onDisplayInfo()
        }
        subControllers = [seriesVC, relateVC]
        pageView.setParentController(vc: self)
        pageView.pages = subControllers
        pageView.setCurrentIndex(currentIndex)
        pageView.currentIndexChange = { [weak self] index in
            guard  let `self` = self else {
                return
            }
            self.currentIndex = index
        }
        setContrains()
        playVideo()
        
        NotificationCenter.default.addObserver(self, selector: #selector(showFullScreen), name: .PlayerFullScreen, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(hideFullScreen), name: .PlayerMinimizeScreen, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func showFullScreen() {
        playViewHeightAnchorCollection?.isActive = false
        playViewBottomAnchorCollection?.isActive = true
        view.layoutIfNeeded()
        view.backgroundColor = .black
        detailInfoView.isHidden = true
        collectionView.isHidden = true
        pageView.isHidden = true
    }
    
    @objc func hideFullScreen() {
        playViewHeightAnchorCollection?.isActive = true
        playViewBottomAnchorCollection?.isActive = false
        view.backgroundColor = .bkg
        view.layoutIfNeeded()
        
        detailInfoView.isHidden = false
        collectionView.isHidden = false
        pageView.isHidden = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        playerView.updateLayoutSubviews()
    }
    
    private func playVideo() {
        playerView.playVideo(with: PlayerConstant.urlString, isLive: false)
        playerView.dismissClosure = { [weak self] in
            self?.dismiss(animated: true)
        }
    }
    
    func setContrains() {
        playerView.anchor(top: view.safeTopAnchor, left: view.safeLeftAnchor, right: view.safeRightAnchor)
        playViewHeightAnchorCollection = playerView.heightAnchor.constraint(equalTo: playerView.widthAnchor, multiplier: 9.0/16.0)
        playViewHeightAnchorCollection?.isActive = true
        
        playViewBottomAnchorCollection = playerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        
        detailInfoView.anchor(top: playerView.bottomAnchor, left: view.safeLeftAnchor, right: view.safeRightAnchor, paddingTop: 24, paddingLeft: padding, paddingRight: padding)
        
        collectionView.anchor(left: view.safeLeftAnchor, right: view.safeRightAnchor, paddingLeft: 0, paddingRight: 0, height: 32)
        topAnchorCollection = collectionView.topAnchor.constraint(equalTo: detailInfoView.bottomAnchor, constant: 24)
        topAnchorCollection?.isActive = true
        topAnchorCollectionNew = collectionView.topAnchor.constraint(equalTo: playerView.bottomAnchor, constant: 0)
        topAnchorCollectionNew?.isActive = false

        pageView.anchor(top: collectionView.bottomAnchor, left: view.safeLeftAnchor, bottom: view.safeBottomAnchor, right: view.safeRightAnchor, paddingTop: 24)
    }

    func configure() {
       
    }
    
    func onHideInfo() {
        UIView.animate(withDuration: 0.2) {
            self.detailInfoView.isHidden = true
            self.topAnchorCollection?.isActive = false
        }
        
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.2, delay: 0, options: [], animations: {
            self.topAnchorCollectionNew?.isActive = true
            self.collectionView.layoutIfNeeded()
            self.view.layoutIfNeeded()
        })
    }
    
    func onDisplayInfo() {
        UIView.animate(withDuration: 0.2) {
            self.detailInfoView.isHidden = false
            self.topAnchorCollectionNew?.isActive = false
        }
        
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.2, delay: 0, options: [], animations: {
            self.topAnchorCollection?.isActive = true
            self.collectionView.layoutIfNeeded()
            self.view.layoutIfNeeded()
        })
    }
}

extension DetailEventVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentIndex = indexPath.row
        pageView.setCurrentIndex(indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let itemContent = tabs[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionTabCell.identifier, for: indexPath) as? CollectionTabCell else {
            return UICollectionViewCell()
        }
        cell.configure(itemContent)
        if currentIndex == indexPath.row {
            cell.setActiveLabel()
        } else {
            cell.setDefaultLabel()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let _data = tabs[indexPath.row]
        let label = UILabel()
        label.text = _data
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        let width: CGFloat = label.intrinsicContentSize.width
        return CGSize(width: width + 32, height: 32)
    }
}

extension DetailEventVC {
    func heightForLabel(text:String, font:UIFont, width:CGFloat) -> CGFloat {
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text

        label.sizeToFit()
        return label.frame.height
    }
}
