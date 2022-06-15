//
//  HomeVC.swift
//  ONEdu
//
//  Created by Tran Dat on 31/05/2022.
//

import UIKit

class HomeVC: UIViewController {
    
    private let presenter = HomePresenter(homeService: HomeService())

    var dataSource: [HomeModel] = [HomeModel(id: 0, nameBLock: "Hot Series", listEvent: [EventModel(id: 0, name: "ABC", type: .series, thumbnail: "https://imgonsport.vtvcab.vn/image-upload/2bb3fca9-0fbe-4146-a19b-f4a6056c0009.jpeg"), EventModel(id: 0, name: "ABC", type: .series, thumbnail: "https://imgonsport.vtvcab.vn/image-upload/2bb3fca9-0fbe-4146-a19b-f4a6056c0009.jpeg"), EventModel(id: 0, name: "ABC", type: .series, thumbnail: "https://imgonsport.vtvcab.vn/image-upload/2bb3fca9-0fbe-4146-a19b-f4a6056c0009.jpeg"), EventModel(id: 0, name: "ABC", type: .series, thumbnail: "https://imgonsport.vtvcab.vn/image-upload/2bb3fca9-0fbe-4146-a19b-f4a6056c0009.jpeg")], logo: "https://imgonsport.vtvcab.vn/image-upload/3ceed58a-d428-409f-9411-db0779db04d6.png", type: .series), HomeModel(id: 1, nameBLock: "Truyền hình", listEvent: [EventModel(id: 0, name: "vtv1", type: .channel, thumbnail: "https://imgonsport.vtvcab.vn/image-upload/6f13f1b1-ddc5-4b7c-b7fe-4654b02a42b2.png"), EventModel(id: 0, name: "vtv1", type: .channel, thumbnail: "https://imgonsport.vtvcab.vn/image-upload/6f13f1b1-ddc5-4b7c-b7fe-4654b02a42b2.png"), EventModel(id: 0, name: "vtv1", type: .channel, thumbnail: "https://imgonsport.vtvcab.vn/image-upload/6f13f1b1-ddc5-4b7c-b7fe-4654b02a42b2.png"), EventModel(id: 0, name: "vtv1", type: .channel, thumbnail: "https://imgonsport.vtvcab.vn/image-upload/6f13f1b1-ddc5-4b7c-b7fe-4654b02a42b2.png")], logo: "https://imgonsport.vtvcab.vn/image-upload/3ceed58a-d428-409f-9411-db0779db04d6.png", type: .channel), HomeModel(id: 3, nameBLock: "Moonbug Kids", listEvent: [EventModel(id: 0, name: "Chuột Mickey và căn nhà huyền bí", type: .category, thumbnail: "https://imgonsport.vtvcab.vn/image-upload/a8ed22d3-c5c0-45fb-8189-b87dbfdb9bd3.jpeg")], logo: "https://imgonsport.vtvcab.vn/image-upload/3ceed58a-d428-409f-9411-db0779db04d6.png", type: .category), HomeModel(id: 3, nameBLock: "Sự kiện", listEvent: [EventModel(id: 0, name: "Chuột Mickey và căn nhà huyền bí", type: .live, thumbnail: "https://imgonsport.vtvcab.vn/image-upload/a8ed22d3-c5c0-45fb-8189-b87dbfdb9bd3.jpeg")], logo: "https://imgonsport.vtvcab.vn/image-upload/3ceed58a-d428-409f-9411-db0779db04d6.png", type: .live)]
    
    var banners: [BannerModel] = [BannerModel]() {
        didSet {
            homeTable.reloadData()
        }
    }
    
    private var homeTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.backgroundColor = .clear
        table.showsVerticalScrollIndicator = false
        table.register(TableItemCell.self, forCellReuseIdentifier: TableItemCell.identifier)
        table.register(BannerTableCell.self, forHeaderFooterViewReuseIdentifier: BannerTableCell.identifier)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setViewDelegate(homeDelegate: self)
        presenter.fetchBanners()
        view.backgroundColor = .bkg
        view.addSubview(homeTable)
        
        homeTable.delegate = self
        homeTable.dataSource = self
        homeTable.separatorStyle = UITableViewCell.SeparatorStyle.none
        // Do any additional setup after loading the view.
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        homeTable.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
        let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
        statusBarView.backgroundColor = UIColor.blueDarker
        view.addSubview(statusBarView)
    }
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = dataSource[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableItemCell.identifier, for: indexPath) as? TableItemCell else {
            return UITableViewCell()
        }
        cell.backgroundColor = .clear
        cell.configure(data)
        cell.selectionStyle = .none
        cell.onClickItem = { [weak self] _event in
            guard let `self` = self else {
                return
            }
            if _event.type == .series || _event.type == .category || _event.type == .live {
                let detailVC = DetailEventVC()
                detailVC.configure()
                self.presentInFullScreen(detailVC, animated: true)
            }
        }
        cell.onClickSeeMore = { [weak self] in
            guard let `self` = self else {
                return
            }
            if data.type == .series || data.type == .category {
                let blockVC = CollectionViewVC()
                blockVC.modalPresentationStyle = .fullScreen
                blockVC.configure(data.nameBLock)
                blockVC.type = data.type
                self.present(blockVC, animated: false)
            } else if data.type == .channel {
                let blockVC = TableChannelVC()
                blockVC.modalPresentationStyle = .fullScreen
                blockVC.configure(data.nameBLock)
                blockVC.type = data.type
                self.present(blockVC, animated: false)
            } else if data.type == .live {
                let blockVC = TableLiveVC()
                blockVC.modalPresentationStyle = .fullScreen
                blockVC.configure(data.nameBLock)
                self.present(blockVC, animated: false)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let data = dataSource[indexPath.row].listEvent[0]
        let height: CGFloat = 46
        if data.type == .category || data.type == .live {
            return height + 142.0 + 32.0
        } else if data.type == .channel {
            return height + 108.0 + 32
        } else {
            return height + 193.0 + 32
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: BannerTableCell.identifier) as? BannerTableCell else {
            return UITableViewHeaderFooterView()
        }
        header.configure(with: BannerBlock(banners: banners))
        header.vc = self
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return BannerTableCell.cellHeight
    }
}

extension HomeVC: HomeDelegate {
    func displayBanner(banners: [BannerModel]) {
        self.banners = banners
    }
}
