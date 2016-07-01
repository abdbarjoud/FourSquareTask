//
//  VenuStatusModel.swift
//  FSquare
//
//  Created by abdullah barjoud on 6/25/16.
//  Copyright © 2016 abdullah barjoud. All rights reserved.
//

import UIKit
import ObjectMapper

class VenueStatsModel: Mappable {
    var checkinsCount:Int?
    var usersCount:Int?
    var tipCount:Int?
    
    required init?(_ map: Map){
    }
    
    init() {
    }
    
    func mapping(map: Map) {
        checkinsCount <- map["checkinsCount"]
        usersCount <- map["usersCount"]
        tipCount <- map["tipCount"]
    }
}
