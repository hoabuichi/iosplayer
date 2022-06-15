//
//  HeaderRegister.swift
//  ONEdu
//
//  Created by Tran Dat on 13/06/2022.
//

import UIKit

class HeaderRegister: UIView {
    private var backButton: BackButton = {
        let button = BackButton()
        button.backgroundColor = .clear
        return button
    }()
    private var lineView: UIView = {
        let line = UIView()
        line.backgroundColor = .white
        line.layer.cornerRadius = 2.0
        line.layer.masksToBounds = true
        return line
    }()
    private var lineOne: UIView = {
        let line = UIView()
        line.backgroundColor = .blueLighter
        line.layer.cornerRadius = 2.0
        line.layer.masksToBounds = true
        return line
    }()
    private var lineTwo: UIView = {
        let line = UIView()
        line.backgroundColor = .blueLighter
        line.layer.cornerRadius = 2.0
        line.layer.masksToBounds = true
        return line
    }()
    private var lineThree: UIView = {
        let line = UIView()
        line.backgroundColor = .blueLighter
        line.layer.cornerRadius = 2.0
        line.layer.masksToBounds = true
        return line
    }()
    private var lineFour: UIView = {
        let line = UIView()
        line.backgroundColor = .blueLighter
        line.layer.cornerRadius = 2.0
        line.layer.masksToBounds = true
        return line
    }()
    private var currentIndexLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    private var totalIndexLabel: UILabel = {
        let label = UILabel()
        label.text = "/4"
        label.textColor = .blueLighter
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    override init(frame: CGRect) {
      super.init(frame: frame)
    }

    required init() {
        super.init(frame: .zero)

        self.backgroundColor = .clear
        self.addSubview(backButton)
        backButton.configure("block-back", UIColor.blueDarker)
        self.addSubview(totalIndexLabel)
        self.addSubview(currentIndexLabel)
        self.addSubview(lineView)
        
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder): Not implemented")
    }

    func setupView() {
        backButton.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, width: 36)
        totalIndexLabel.anchor(top: self.topAnchor, bottom: self.bottomAnchor, right: self.rightAnchor)
        currentIndexLabel.anchor(top: self.topAnchor, bottom: self.bottomAnchor, right: totalIndexLabel.leftAnchor)
        lineView.anchor(left: backButton.rightAnchor, right: currentIndexLabel.leftAnchor, paddingLeft: 7, paddingRight: 9, height: 4)
        lineView.centerY(inView: self)
    }
    
    func configure(_ index: Int) {
        let screenSizeWidth: CGFloat = UIScreen.main.bounds.width
        let spaceLine: CGFloat = 4.0
        let widthLine: CGFloat = screenSizeWidth - 32 - 36
        let widthEachLine: CGFloat = widthLine / 4 - (spaceLine*3)
        currentIndexLabel.text = "\(index)"
        
        if index == 1 {
            self.addSubview(lineOne)
            lineOne.anchor(top: lineView.topAnchor, left: lineView.leftAnchor, bottom: lineView.bottomAnchor, width: widthEachLine)
        } else if index == 2 {
            self.addSubview(lineOne)
            self.addSubview(lineTwo)
            lineOne.anchor(top: lineView.topAnchor, left: lineView.leftAnchor, bottom: lineView.bottomAnchor, width: widthEachLine)
            lineTwo.anchor(top: lineView.topAnchor, left: lineOne.rightAnchor, bottom: lineView.bottomAnchor, paddingLeft: 4, width: widthEachLine)
        } else if index == 3 {
            self.addSubview(lineOne)
            self.addSubview(lineTwo)
            self.addSubview(lineThree)
            lineOne.anchor(top: lineView.topAnchor, left: lineView.leftAnchor, bottom: lineView.bottomAnchor, width: widthEachLine)
            lineTwo.anchor(top: lineView.topAnchor, left: lineOne.rightAnchor, bottom: lineView.bottomAnchor, paddingLeft: 4, width: widthEachLine)
            lineThree.anchor(top: lineView.topAnchor, left: lineTwo.rightAnchor, bottom: lineView.bottomAnchor, paddingLeft: 4, width: widthEachLine)
        } else {
            self.addSubview(lineOne)
            self.addSubview(lineTwo)
            self.addSubview(lineThree)
            self.addSubview(lineFour)
            lineOne.anchor(top: lineView.topAnchor, left: lineView.leftAnchor, bottom: lineView.bottomAnchor, width: widthEachLine)
            lineTwo.anchor(top: lineView.topAnchor, left: lineOne.rightAnchor, bottom: lineView.bottomAnchor, paddingLeft: 4, width: widthEachLine)
            lineThree.anchor(top: lineView.topAnchor, left: lineTwo.rightAnchor, bottom: lineView.bottomAnchor, paddingLeft: 4, width: widthEachLine)
            lineFour.anchor(top: lineView.topAnchor, left: lineThree.rightAnchor, bottom: lineView.bottomAnchor, paddingLeft: 4, width: widthEachLine)
        }
    }
    
    func hideProgress() {
        lineView.isHidden = true
        for item in [lineOne, lineTwo, lineThree, lineFour] {
            item.isHidden = true
        }
        currentIndexLabel.isHidden = true
        totalIndexLabel.isHidden = true
    }
    
    func setupBackButton(_ isPresenter: Bool, _ vc: UIViewController) {
        backButton.isPresenter = isPresenter
        backButton.vc = vc
    }
}
