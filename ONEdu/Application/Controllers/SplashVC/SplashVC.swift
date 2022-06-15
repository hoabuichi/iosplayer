//
//  SplashVC.swift
//  ONEdu
//
//  Created by Tran Dat on 31/05/2022.
//

import UIKit

class SplashVC: BaseVC<BaseModel,BaseView, SplashPresenter> {
    private var splashImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Splashscreen")
        return image
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(splashImage)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
        let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
        let statusBarColor = UIColor(hexFromString: "#4398FA")
        statusBarView.backgroundColor = statusBarColor
        view.addSubview(statusBarView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        splashImage.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
    }

    override func createPresenter() -> SplashPresenter {
        return SplashPresenter()
    }
}
