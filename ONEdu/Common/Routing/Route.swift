//
//  Route.swift
//  OnEdu
//
//  Created by Dao Thuy on 7/18/21.
//

import Foundation
import Alamofire

class Route {
    open fileprivate(set) var method: HTTPMethod
    open fileprivate(set) var path: String
    open fileprivate(set) var headers: HTTPHeaders?
    open fileprivate(set) var queryParams: [String: Any]?
    open fileprivate(set) var jsonParams: [String: Any]?
    open fileprivate(set) var withAuthToken: Bool
    open fileprivate(set) var withAuthRefreshToken: Bool
    public init(method: HTTPMethod,
                path: String,
                headers: HTTPHeaders? = nil,
                queryParams: [String: Any]? = nil,
                jsonParams: [String: Any]? = nil,
                withAuthToken: Bool = false,
                withAuthRefreshToken: Bool = false
        ) {
        self.method = method
        self.path = path
        self.headers = headers
        self.queryParams = queryParams
        self.jsonParams = jsonParams
        self.withAuthToken = withAuthToken
        self.withAuthRefreshToken = withAuthRefreshToken
    }
}
