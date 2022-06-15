//
//  UIViewController+StatusBar.swift
//  ONEdu
//
//  Created by Tran Dat on 09/06/2022.
//

import Foundation
import UIKit

extension UIViewController {
    func setColorStatusbar() {
        let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
        let statusBarColor = UIColor(hexFromString: "#358AF5")
        statusBarView.backgroundColor = statusBarColor
        view.addSubview(statusBarView)
    }
}
