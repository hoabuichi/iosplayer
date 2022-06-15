//
//  SignupVC.swift
//  ONEdu
//
//  Created by Tran Dat on 13/06/2022.
//

import UIKit

struct AgeModel {
    var image: String = ""
    var title: String = ""
    var isChoice: Bool = false
}

class AgeChoiceVC: UIViewController {
    var dataSource: [AgeModel] = [AgeModel(image: "video-tabbar-active", title: "Dưới 4 tuổi", isChoice: false), AgeModel(image: "video-tabbar-active", title: "Từ 5 đến 9 tuổi", isChoice: false), AgeModel(image: "video-tabbar-active", title: "9 tuổi trở lên", isChoice: false), AgeModel(image: "video-tabbar-active", title: "Mọi lứa tuổi", isChoice: false)]
    
    private var headerView: HeaderRegister = {
        let header = HeaderRegister()
        header.backgroundColor = .clear
        return header
    }()

    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Lựa chọn lứa tuổi"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    private var desLabel: UILabel = {
        let label = UILabel()
        label.text = "Chúng tôi sẽ tùy chỉnh nội dung hiển thị trên ứng dụng này theo độ tuổi của con bạn."
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.register(TableAgeCell.self, forCellReuseIdentifier: TableAgeCell.identifier)
        return tableView
    }()
    
    private var buttonContinue: UIButton = {
        let button = UIButton()
        button.setTitle("TIẾP TỤC", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.backgroundColor = .blueLighter
        button.setTitleColor(UIColor.blueLight, for: .normal)
        button.layer.cornerRadius = 12.0
        button.layer.masksToBounds = true
        button.layer.borderWidth = 4
        button.layer.borderColor = UIColor.blueLight.cgColor
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blueDarker
        view.addSubview(headerView)
        headerView.configure(1)
        headerView.setupBackButton(false, self)
        
        view.addSubview(titleLabel)
        view.addSubview(desLabel)
        view.addSubview(buttonContinue)
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none

        buttonContinue.addTarget(self, action: #selector(onContinue), for: .touchUpInside)
        buttonContinue.isEnabled = false
        
        setupContraint()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
        self.setColorStatusbar()
    }
    
    func setupContraint() {
        let padding: CGFloat = 16.0
        
        headerView.anchor(top: view.safeTopAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 16, paddingRight: 16, height: 36)
        titleLabel.anchor(top: headerView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 34, paddingLeft: padding, paddingRight: padding)
        desLabel.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 8, paddingLeft: padding, paddingRight: padding)
        
        buttonContinue.anchor(left: view.leftAnchor, bottom: view.safeBottomAnchor, right: view.rightAnchor, paddingLeft: padding, paddingBottom: 20, paddingRight: padding, height: 52)
        
        tableView.anchor(top: desLabel.bottomAnchor, left: view.leftAnchor, bottom: buttonContinue.topAnchor, right: view.rightAnchor, paddingTop: 18)
    }
    
    @objc func onContinue() {
        let vc = SignUpVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension AgeChoiceVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        for (index, itemAge) in dataSource.enumerated() {
            if index == indexPath.section {
                print(itemAge)
                dataSource[index].isChoice = true
                buttonContinue.backgroundColor = .clear
                buttonContinue.setTitleColor(UIColor.white, for: .normal)
                buttonContinue.isEnabled = true
            } else {
                dataSource[index].isChoice = false
            }
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = dataSource[indexPath.section]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableAgeCell.identifier, for: indexPath) as? TableAgeCell else {
            return UITableViewCell()
        }
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        cell.configure(item)
        
        if item.isChoice {
            cell.setShowIcon()
        } else {
            cell.setHideIcon()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
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
            return 16
        }
    }
}
