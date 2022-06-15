//
//  Router.swift
//  ONSports
//
//  Created by Dao Thuy on 7/18/21.
//

import Foundation
import Alamofire

class Router {

    static var nsDictionary: NSDictionary? {
        if let path = Bundle.main.path(forResource: "Info", ofType: "plist") {
            return NSDictionary(contentsOfFile: path)
        }
        return nil
    }
    
    static var baseUrl: String {
        let url = nsDictionary!["SERVER_URL"] as? String ?? ""
        return "\(url)/api/v2/"
    }
    
    func buildUrlRequest(_ route: Route) -> URLRequestConvertible {
        return RouterUrlConvertible(route: route)
    }
    public func buildValidFullPathForRequest(_ path: String, _ baseUrl: String = Router.baseUrl) -> String {
        if let url = URL(string: baseUrl) {
            return url.appendingPathComponent(path).absoluteString
        }
        return path
    }
}
