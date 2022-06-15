//
//  ServerResponseObject.swift
//  ONSports
//
//  Created by Dao Thuy on 7/18/21.
//

import Foundation
import UIKit

class ServerResponseObject: CoreObject {
    var status: ServerResponseStatus?
    var isSuccess: Bool?
    required init(data: [AnyHashable: Any]?) {
        if let errorCode = data?["code"] as? String, let errorMessage = data?["message"] as? String {
            self.status = ServerResponseStatus(errorCode: errorCode, errorMessage: errorMessage)
        }
        isSuccess = data?["succeed"] as? Bool
    }
}
