//
//  HomeRouter.swift
//  ONEdu
//
//  Created by will on 15/06/2022.
//

import Foundation
import Alamofire

final class HomeRouter: Router {
    func fetchBanners() -> URLRequestConvertible {
        let path = buildValidFullPathForRequest("publish/slides/", Router.baseUrl)
        return buildUrlRequest(Route(method: .get,
                                     path: path))
    }
}
