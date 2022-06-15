//
//  BannerModel.swift
//  ONEdu
//
//  Created by will on 08/06/2022.
//

import UIKit

struct BannerModel: Decodable {
    var title: String = ""
    var thumbnail: String = ""
    
    private enum CodingKeys : String, CodingKey {
        case title="name", thumbnail
    }
}

struct BannerResponse: Decodable {
    var data: [BannerModel]
}

struct BannerBlock {
    
    var banners = [BannerModel]()
    
    init(){}
    
    init(banners: [BannerModel]) {
        self.banners = banners
    }
    
//    func getCellIdentifier() -> String {
//        return BannerTableCell.identifier
//    }
//    
//    func getCellHeight() -> CGFloat {
//        return BannerTableCell.cellHeight
//    }
}
