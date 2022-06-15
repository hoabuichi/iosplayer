//
//  HomeService.swift
//  ONEdu
//
//  Created by will on 15/06/2022.
//

import Foundation

class HomeService {
    private let router = HomeRouter()
    
    func fetchBanners() -> ServiceRequest<BannerResponse> {
        let request = ServiceRequest<BannerResponse>()
        CustomSessionManager.sharedManager.request(router.fetchBanners()).validate().responseDecodable(of: BannerResponse.self) { response in
            request.handleResponseJSON(response: response)
        }
        return request
    }
}
