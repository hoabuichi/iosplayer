//
//  AlarmofireRetry.swift
//  ONSports
//
//  Created by will on 06/08/2021.
//
import Foundation
import Alamofire

let retryLimit = 3

class CustomRetryInterceptor: RequestInterceptor {
//    let loginService = LoginService()

    public func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var request = urlRequest
        guard let token = getKeyChain(accessTokenName), let _ = urlRequest.value(forHTTPHeaderField: "Authorized-Header") else {
            completion(.success(request))
            return
        }

        let bearerToken = "Bearer \(token)"
        request.setValue(bearerToken, forHTTPHeaderField: "Authorization")
        completion(.success(request))
    }

    public func retry(_ request: Request,
                      for session: Session,
                      dueTo error: Error,
                      completion: @escaping (RetryResult) -> Void) {
        guard request.retryCount < retryLimit else {
            completion(.doNotRetry)
            return
        }

        let response = request.task?.response as? HTTPURLResponse
        if let statusCode = response?.statusCode {
            if statusCode == 401 {
                refreshToken { isSuccess in
                    isSuccess ? completion(.retry) : completion(.doNotRetry)
                }
            } else {
                completion(.doNotRetry)
            }
        } else {
            completion(.doNotRetry)
        }
    }

    func refreshToken(completion: @escaping (_ isSuccess: Bool) -> Void) {
        guard getKeyChain(refreshTokenName) != nil else { return }
//        loginService.refreshToken().cloudResponse { (socialLoginResponse) in
//            guard let state = socialLoginResponse.status?.state else { return }
//            switch state {
//                case .success:
//                    saveKeyChain(socialLoginResponse.datas.accessToken, accessTokenName)
//                    saveKeyChain(socialLoginResponse.datas.refreshToken, refreshTokenName)
//                    completion(true)
//                    break
//                case .error(code: _):
//                    completion(false)
//            }
//        }.cloudError {(errMsg, code: Int?) in
//            completion(false)
//        }
    }
}

class CustomSessionManager {

    static let sharedManager: Alamofire.Session = {
        let config = Session.default.session.configuration
        let manager = Alamofire.Session(configuration: config, interceptor: CustomRetryInterceptor())
        return manager
    }()
}
