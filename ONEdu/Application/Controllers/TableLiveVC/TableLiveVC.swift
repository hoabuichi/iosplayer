//
//  TableLiveVC.swift
//  ONEdu
//
//  Created by Tran Dat on 08/06/2022.
//

import UIKit

class TableLiveVC: UIViewController {
//    public var type: TypeEventBlock = .channel
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
        let table = UITableView()
        table.backgroundColor = .clear
        table.showsVerticalScrollIndicator = false
        table.register(TableBLockChannelCell.self, forCellReuseIdentifier: TableBLockChannelCell.identifier)
        table.register(TableItemDetailCell.self, forCellReuseIdentifier: TableItemDetailCell.identifier)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

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
        tableView.anchor(top: uiView.topAnchor, left: uiView.leftAnchor, bottom: uiView.bottomAnchor, right: uiView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
    }
    
    func configure(_ name: String) {
        headerView.configure(name)
    }
    
}

extension TableLiveVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableItemDetailCell.identifier, for: indexPath) as? TableItemDetailCell else {
            return UITableViewCell()
        }
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        cell.configureTypeLive()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 107
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if #available(iOS 15.0, *) {
            return 0
        } else {
            return 10
        }
    }

}
