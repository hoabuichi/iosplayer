//
//  HomePresenter.swift
//  ONEdu
//
//  Created by will on 15/06/2022.
//

import Foundation

protocol HomeDelegate: NSObjectProtocol {
    func displayBanner(banners: [BannerModel])
}

class HomePresenter {
    private let homeService: HomeService
    weak private var homeDelegate : HomeDelegate?

    init(homeService: HomeService){
       self.homeService = homeService
    }
    
    func setViewDelegate(homeDelegate: HomeDelegate?){
        self.homeDelegate = homeDelegate
    }
    
    func fetchBanners() {
        homeService.fetchBanners().cloudResponse {[weak self] (response) in
            print(response.data)
            self?.homeDelegate?.displayBanner(banners: response.data)
        }.cloudError { (errMsg, code: Int?) in
            //handle login error
        }
    }
}
