//
//  TableViewVC.swift
//  ONEdu
//
//  Created by Tran Dat on 08/06/2022.
//

import UIKit

struct ItemChannel {
    var id: String = ""
    var thumb: String = ""
}

struct BlockChanel {
    var id: String = ""
    var name: String = ""
    var list: [ItemChannel] = []
}

class TableChannelVC: UIViewController {
    var dataSource: [BlockChanel] = [BlockChanel(id: "", name: "Kênh dành cho bé", list: [ItemChannel(id: "", thumb: "https://imgonsport.vtvcab.vn/image-upload/6f13f1b1-ddc5-4b7c-b7fe-4654b02a42b2.png"), ItemChannel(id: "", thumb: "https://imgonsport.vtvcab.vn/image-upload/6f13f1b1-ddc5-4b7c-b7fe-4654b02a42b2.png")]), BlockChanel(id: "", name: "Kênh VTV", list: [ItemChannel(id: "", thumb: "https://imgonsport.vtvcab.vn/image-upload/6f13f1b1-ddc5-4b7c-b7fe-4654b02a42b2.png"), ItemChannel(id: "", thumb: "https://imgonsport.vtvcab.vn/image-upload/6f13f1b1-ddc5-4b7c-b7fe-4654b02a42b2.png"), ItemChannel(id: "", thumb: "https://imgonsport.vtvcab.vn/image-upload/6f13f1b1-ddc5-4b7c-b7fe-4654b02a42b2.png"), ItemChannel(id: "", thumb: "https://imgonsport.vtvcab.vn/image-upload/6f13f1b1-ddc5-4b7c-b7fe-4654b02a42b2.png"), ItemChannel(id: "", thumb: "https://imgonsport.vtvcab.vn/image-upload/6f13f1b1-ddc5-4b7c-b7fe-4654b02a42b2.png")]), BlockChanel(id: "", name: "Kênh K+", list: [ItemChannel(id: "", thumb: "https://imgonsport.vtvcab.vn/image-upload/6f13f1b1-ddc5-4b7c-b7fe-4654b02a42b2.png"), ItemChannel(id: "", thumb: "https://imgonsport.vtvcab.vn/image-upload/6f13f1b1-ddc5-4b7c-b7fe-4654b02a42b2.png"), ItemChannel(id: "", thumb: "https://imgonsport.vtvcab.vn/image-upload/6f13f1b1-ddc5-4b7c-b7fe-4654b02a42b2.png")])]
    
    static let widthItemChannel: CGFloat = UIScreen.main.bounds.width / 3 - 32
    public var type: TypeEventBlock = .channel
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
    private var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.backgroundColor = .clear
        table.showsVerticalScrollIndicator = false
        table.register(TableBLockChannelCell.self, forCellReuseIdentifier: TableBLockChannelCell.identifier)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("type screen: \(type)")

        view.backgroundColor = .white
        view.addSubview(headerView)
        headerView.setConfigButton(true, self)
        
        view.addSubview(uiView)
        uiView.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        setupContraint()
    }
    
    func setupContraint() {
        headerView.anchor(top: view.safeTopAnchor, left: view.safeLeftAnchor, right: view.safeRightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, height: 36)
        uiView.anchor(top: headerView.bottomAnchor, left: view.safeLeftAnchor, bottom: view.bottomAnchor, right: view.safeRightAnchor, paddingTop: 25, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        tableView.anchor(top: uiView.topAnchor, left: uiView.leftAnchor, bottom: uiView.bottomAnchor, right: uiView.rightAnchor, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 16)
    }
    
    func configure(_ name: String) {
        headerView.configure(name)
    }
    
}

extension TableChannelVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = dataSource[indexPath.section]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableBLockChannelCell.identifier, for: indexPath) as? TableBLockChannelCell else {
            return UITableViewCell()
        }
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        cell.configure(data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var _newCount: Int = 1
        let countList: Int = dataSource[indexPath.section].list.count
        let heightTitle: CGFloat = 24.0
        if countList % 3 == 0 {
            _newCount = countList / 3
        } else {
            _newCount = (countList / 3) + 1
        }
        return CGFloat(TableChannelVC.widthItemChannel * CGFloat(_newCount) + (16 * CGFloat(_newCount)) + heightTitle)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
}
