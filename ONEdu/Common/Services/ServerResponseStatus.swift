//
//  ServerResponseStatus.swift
//  ONSports
//
//  Created by Dao Thuy on 7/18/21.
//

import Foundation

/**
Wraps server's response status, which normally depicted through the response's `errorCode` and `errorMessage`.
*/
struct ServerResponseStatus {
    // TODO: Revisit whether these sub-definitions should be moved to their own files.
    /**
    State of server's response.
    */
    enum ResponseState {
        case success
        case error(code: String)
    }
    // MARK: - Public properties
    let state: ResponseState
    /**
    Corresponding message along with the `state`.
    */
    let message: String
    // MARK: - Initializers
    init(state: ResponseState, message: String) {
        self.state = state
        self.message = message
    }
    init(errorCode: String, errorMessage: String) {
        self.state = ServerResponseStatus.responseState(for: errorCode)
        self.message = errorMessage
    }
    // MARK: - Private methods
    static private func responseState(for errorCode: String) -> ResponseState {
        if errorCode == "OK" {
            return .success
        }
        return .error(code: errorCode)
    }
}
