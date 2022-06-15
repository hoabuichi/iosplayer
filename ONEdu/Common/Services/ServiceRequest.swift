//
//  ServiceRequest.swift
//  ONSports
//
//  Created by Dao Thuy on 7/18/21.
//

import UIKit
import Alamofire
import SwiftyJSON

final class ServiceRequest<T: Decodable> {
    private var cloudResponseClosure: ((T) -> Void)?
    private var cloudErrorClosure: ((_ status: String, _ code: Int?) -> Void)?
    private var finallyClosure: (() -> Void)?
    var cachedResult: T!
    public init() {
        self.cloudResponseClosure = nil
        self.cloudErrorClosure = nil
    }
    @discardableResult
    func cloudResponse(_ closure: ((T) -> Void)? = nil) -> Self {
        self.cloudResponseClosure = closure
        return self
    }
    @discardableResult
    func cloudError(_ closure: ((_ status: String, _ code: Int?) -> Void)? = nil) -> Self {
        self.cloudErrorClosure = closure
        return self
    }
    @discardableResult
    func finally(_ closure: (() -> Void)?) -> Self {
        self.finallyClosure = closure
        return self
    }
    func handleResponseJSON(response: DataResponse<T,AFError>, isLogin: Bool = false) {
        defer {
            finallyClosure?()
        }
        
        switch response.result {
        case .success:
            if let value = response.value {
                cloudResponseClosure?(value)
            }
            break
        case .failure:
            if let statusCode = response.response?.statusCode, let error = response.error {
                if statusCode == 401 {
                    // TODO
                    return
                }
                
                // Show error message
                var errorMsg = error.localizedDescription
                if let data = response.data {
                    let json = try? JSON(data: data)
                    if let msgs = json?["error_message"].arrayValue.map({$0.stringValue}) {
                        if msgs.count > 0 {
                            errorMsg = msgs[0]
                        }
                    }
                }
                cloudErrorClosure?(errorMsg, statusCode)
            }
            break
        }
    }
}
