//
//  BackButton.swift
//  ONEdu
//
//  Created by Tran Dat on 05/06/2022.
//

import UIKit

class BackButton: UIView {
    public weak var vc: UIViewController?
    public var isPresenter: Bool = false
    private let backButton: UIButton = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.setImage(UIImage(named: "ic-back-detail"), for: .normal)
        button.backgroundColor = UIColor(hexFromString: "#33333380")
        button.layer.cornerRadius = 12.0
        button.layer.masksToBounds = true
        return button
    }()
    
    override init(frame: CGRect) {
      super.init(frame: frame)
    }
    
    required init() {
      super.init(frame: .zero)
        backButton.addTarget(self, action:#selector(onPress), for: .touchUpInside)
        setupView()
    }
    
    required init?(coder: NSCoder) {
      fatalError("init(coder): Not implemented")
    }
    
    
    func setupView() {
        self.addSubview(backButton)
        backButton.anchor(top: self.safeTopAnchor, left: self.safeLeftAnchor, bottom: self.safeBottomAnchor, right: self.safeRightAnchor)
    }
    
    func configure(_ name: String, _ uiColor: UIColor) {
        backButton.setImage(UIImage(named: name), for: .normal)
        backButton.backgroundColor = uiColor
    }
    
    @objc func onPress() {
        if (isPresenter) {
            vc?.dismiss(animated: true, completion: nil)
        } else {
            vc?.navigationController?.popViewController(animated: true)
        }
    }
}
