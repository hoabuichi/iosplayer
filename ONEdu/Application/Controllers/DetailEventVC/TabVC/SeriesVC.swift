//
//  SeriesVC.swift
//  ONEdu
//
//  Created by Tran Dat on 05/06/2022.
//

import UIKit

struct SeriesModel {
    var id: String = ""
    var name: String = ""
    var list: [String] = []
}

class SeriesVC: UIViewController {
    var dataSource: [SeriesModel] = [SeriesModel(id: "", name: "Mùa 1", list: ["1", "1", "1", "1", "1"]), SeriesModel(id: "", name: "Mùa 2", list: ["1", "1", "1", "1", "1"]), SeriesModel(id: "", name: "Mùa 3", list: ["1", "1", "1", "1", "1"]), SeriesModel(id: "", name: "Mùa 4", list: ["1", "1", "1", "1", "1"]), SeriesModel(id: "", name: "Mùa 5", list: ["1", "1", "1", "1", "1"])]
    var hideDetailInfo: (()-> Void)?
    var displayDetailInfo: (()-> Void)?
    var lastContentOffset: CGFloat = 0
    
    private var seriesTable: UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        table.showsVerticalScrollIndicator = false
        table.register(TableItemDetailCell.self, forCellReuseIdentifier: TableItemDetailCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(seriesTable)
        seriesTable.delegate = self
        seriesTable.dataSource = self
        seriesTable.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        seriesTable.anchor(top: view.safeTopAnchor, left: view.safeLeftAnchor, bottom: view.safeBottomAnchor, right: view.safeRightAnchor, paddingLeft: 0, paddingRight: 0)
    }
}

extension SeriesVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let data = dataSource[indexPath.section].list
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableItemDetailCell.identifier, for: indexPath) as? TableItemDetailCell else {
            return UITableViewCell()
        }
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        cell.configure()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 107 + 10
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
