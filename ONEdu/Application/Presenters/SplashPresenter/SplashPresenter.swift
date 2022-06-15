//
//  SplashPresenter.swift
//  ONEdu
//
//  Created by Tran Dat on 31/05/2022.
//

import Foundation
import UIKit

class SplashPresenter: BasePresenter {
    typealias View = SplashVC
    var view: SplashVC?
    
    func onAttach(view: SplashVC) {
        self.view = view
        if #available(iOS 13.0, *) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
                guard let `self` = self else { return }
                self.router()
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                guard let `self` = self else { return }
                self.router()
            }
        }
    }

    func onDetach(view: SplashVC) {
        self.view = nil
    }
    
    @objc private func router() {
        Utils.appDelegate?.routeToTabbar()
//        if SessionManager.shared.isLoggedIn {
//            // go to main
//            Utils.appDelegate?.routeToTabbar()
//        } else {
//            if !SessionManager.shared.isLoggedIn {
//                // go to login
//                Utils.appDelegate?.routeToLogin()
//            }
//        }
    }
}
