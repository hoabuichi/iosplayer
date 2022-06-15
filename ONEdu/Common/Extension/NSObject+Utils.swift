//
//  NSObject+Utils.swift
//  ONSports
//
//  Created by Steve on 11/07/2021.
//

import Foundation
extension NSObject {

    var className: String {

        return String(describing: type(of: self))
    }

    class var className: String {

        return String(describing: self)
    }
}
