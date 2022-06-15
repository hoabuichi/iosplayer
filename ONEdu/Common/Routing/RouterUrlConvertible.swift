//
//  RouterUrlConvertible.swift
//  ONSports
//
//  Created by Dao Thuy on 7/18/21.
//

import Foundation
import Alamofire

final class RouterUrlConvertible: URLRequestConvertible {
    var urlRequest: URLRequest!
    private let jsonEncoding = JSONEncoding()
    private let urlEncoding = URLEncoding()
    public init(route: Route) {
        var urlPath = route.path
        if let queryParams = route.queryParams {
            urlPath = queryParameterEncodedRequestURL(urlPath, queryParams: queryParams)
        }
        
        if let refreshToken = getKeyChain(refreshTokenName) {
            print(refreshToken)
        }
        
        var headers: HTTPHeaders = ["Accept-Language": "vn"]
        headers["TokenDevice"] = UserDefaults.standard.string(forKey: "DeviceToken")
        if route.withAuthToken {
            headers = ["Authorized-Header": "True"]
        }
        if route.withAuthRefreshToken {
            if let refreshToken = getKeyChain(refreshTokenName) {
                headers = ["Authorization": "Bearer \(refreshToken)"]
            }
        }
        
        var buildUrlRequest = try? URLRequest(url: urlPath, method: route.method, headers: headers)
        buildUrlRequest?.cachePolicy = .reloadIgnoringLocalCacheData
        // START: session and header here
        // END
        guard let urlRequestUnwrapp = buildUrlRequest else {
            return
        }
        if let bodyParams = route.jsonParams {
            buildUrlRequest = try? jsonEncoding.encode(urlRequestUnwrapp, with: bodyParams)
        }
        urlRequest = buildUrlRequest
    }
    public func asURLRequest() throws -> URLRequest {
        return urlRequest
    }
    private func queryParameterEncodedRequestURL(_ urlString: String, queryParams: [String: Any]) -> String {
        guard let url = URL(string: urlString) else {
            return urlString
        }
        guard let request = try? urlEncoding.encode(URLRequest(url: url), with: queryParams),
              let encodedUrlString = request.url?.absoluteString else {
            return urlString
        }
        return encodedUrlString.replacingOccurrences(of: "%5B%5D", with: "")
    }
}
