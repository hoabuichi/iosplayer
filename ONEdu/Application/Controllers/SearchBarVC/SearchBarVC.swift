//
//  SearchBarVC.swift
//  ONEdu
//
//  Created by Tran Dat on 14/06/2022.
//

import UIKit

class SearchBarVC: UIViewController {
    private var boxHeaderView: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = .clear
        return uiView
    }()
    private var backButton: BackButton = {
        let button = BackButton()
        return button
    }()
    private var tfSearch: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .grayLight
        textField.textColor = .black500
        textField.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        textField.borderStyle = .none
        textField.attributedPlaceholder = NSAttributedString(string: "Nhập từ khóa cần tìm", attributes: [NSAttributedString.Key.foregroundColor: UIColor.blueLighter, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .medium)])
        textField.setLeftPaddingPoints(10)
        textField.setRightPaddingPoints(30)
        textField.layer.cornerRadius = 16.0
        textField.layer.masksToBounds = true
        return textField
    }()
    private var iconRemove: UIButton = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.setImage(UIImage(named: "x"), for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 13.0
        button.layer.masksToBounds = true
        return button
    }()
    private var borderView: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = .blueLight
        return uiView
    }()
    private var tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .grayLight
        table.showsVerticalScrollIndicator = false
        table.register(TableItemDetailCell.self, forCellReuseIdentifier: TableItemDetailCell.identifier)
        return table
    }()
    
    private var boxEmptyView: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = .clear
        return uiView
    }()
    private var boxImageEmpty: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = .grayLight
        uiView.layer.cornerRadius = 100.0
        uiView.layer.masksToBounds = true
        return uiView
    }()
    private var imageEmpty: UIView = {
        let image = UIImageView()
        image.image = UIImage(named: "search")
        return image
    }()
    private var titleEmpty: UILabel = {
        let label = UILabel()
        label.text = "Rất tiếc, chúng tôi không tìm thấy kết quả phù hợp"
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .black900
        label.textAlignment = .center
        return label
    }()
    private var desLabel: UILabel = {
        let label = UILabel()
        label.text = "Vui lòng thử lại với từ khóa khác"
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .black500
        label.textAlignment = .center
        return label
    }()


    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(boxHeaderView)
        boxHeaderView.addSubview(backButton)
        backButton.configure("block-back", UIColor.grayLight)
        backButton.isPresenter = true
        backButton.vc = self
        
        boxHeaderView.addSubview(tfSearch)
        tfSearch.delegate = self
        tfSearch.isEnabled = true
        tfSearch.isUserInteractionEnabled = true
        tfSearch.addTarget(self, action: #selector(changeCharacter), for: .editingChanged)
        boxHeaderView.addSubview(iconRemove)
        iconRemove.isHidden = true
        iconRemove.isEnabled = false

        view.addSubview(borderView)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.isHidden = true
        
        view.addSubview(boxEmptyView)
        boxEmptyView.addSubview(boxImageEmpty)
        boxImageEmpty.addSubview(imageEmpty)
        boxEmptyView.addSubview(titleEmpty)
        boxEmptyView.addSubview(desLabel)
        boxEmptyView.isHidden = true
        
        setupContraint()
        
        iconRemove.addTarget(self, action: #selector(onRemove), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
    }
    
    func setupContraint() {
        let screenSizeHeight: CGFloat = UIScreen.main.bounds.height
        let padding: CGFloat = 16.0
        
        boxHeaderView.anchor(top: view.safeTopAnchor, left: view.leftAnchor, right: view.rightAnchor, height: 70)
        backButton.anchor(left: boxHeaderView.leftAnchor, paddingLeft: padding, width: 36, height: 36)
        backButton.centerY(inView: boxHeaderView)
        tfSearch.anchor(left: backButton.rightAnchor, right: boxHeaderView.rightAnchor, paddingLeft: 16, paddingRight: padding, height: 42)
        tfSearch.centerY(inView: boxHeaderView)
        iconRemove.anchor(right: tfSearch.rightAnchor, paddingRight: 6, width: 26, height: 26)
        iconRemove.centerY(inView: tfSearch)
        borderView.anchor(top: boxHeaderView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, height: 1)
        
        tableView.anchor(top: borderView.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        
        boxEmptyView.anchor(top: borderView.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        let heightSize: CGFloat = screenSizeHeight * 0.38
        boxImageEmpty.anchor(width: heightSize, height: heightSize)
        boxImageEmpty.centerY(inView: boxEmptyView, constant: -70)
        boxImageEmpty.centerX(inView: boxEmptyView)
        imageEmpty.anchor(width: heightSize - 80, height: heightSize - 80)
        imageEmpty.center(inView: boxImageEmpty)
        titleEmpty.anchor(top: boxImageEmpty.bottomAnchor, left: boxEmptyView.leftAnchor, right: boxEmptyView.rightAnchor, paddingTop: 24, paddingLeft: padding, paddingRight: padding)
        desLabel.anchor(top: titleEmpty.bottomAnchor, left: boxEmptyView.leftAnchor, right: boxEmptyView.rightAnchor, paddingTop: 5, paddingLeft: padding, paddingRight: padding)
    }
    
    func emptyUI() {
        tableView.isHidden = true
        boxEmptyView.isHidden = true
        iconRemove.isHidden = true
        iconRemove.isEnabled = false
    }
    
    @objc func changeCharacter(textField: UITextField) {
        if textField.text == "" {
            emptyUI()
        } else {
            iconRemove.isHidden = false
            iconRemove.isEnabled = true
            if textField.text == "1" {
                tableView.isHidden = true
                boxEmptyView.isHidden = false
            } else {
                tableView.isHidden = false
                boxEmptyView.isHidden = true
            }
        }
    }

    @objc func onRemove() {
        tfSearch.text = ""
        emptyUI()
    }
}

extension SearchBarVC: UITableViewDelegate, UITableViewDataSource {
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
        cell.configure()
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
            return 16
        }
    }

}

extension SearchBarVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
