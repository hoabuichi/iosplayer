//
//  AppDelegate+Route.swift
//  ONEdu
//
//  Created by Tran Dat on 31/05/2022.
//

import UIKit
import Foundation

extension AppDelegate {
    func routeToTabbar() {
        let tabbarVC = TabbarVC()
        Utils.mostTopViewController = tabbarVC
    }
    
    func routeToSplash() {
//        let splashVC = Utils.loadController(from: Storyboard.Main, of: SplashVC.self)
//        Utils.mostTopViewController = splashVC
    }
//    func routeToLogin() {
//        if let rootVC = UIApplication.shared.keyWindow?.rootViewController {
//            let loginVC = Utils.loadController(from: Storyboard.Login, of: LoginVC.self)
//            loginVC.callbackLogin = {
//                loginVC.dismiss(animated: false)
//            }
//            let navController = UINavigationController(rootViewController: loginVC)
//            navController.isNavigationBarHidden = true
//            navController.modalPresentationStyle = .fullScreen
//            rootVC.present(navController, animated: true, completion: nil)
//        }
//    }
}
