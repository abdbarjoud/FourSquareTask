//
//  NearbyModel.swift
//  FSquare
//
//  Created by abdullah barjoud on 6/25/16.
//  Copyright © 2016 abdullah barjoud. All rights reserved.
//

import UIKit
import ObjectMapper

class NearbyModel: Mappable {
  
    var venue:VenueModel?
    var tips:Array<VenueTipModel>?
    
    
    required init?(_ map: Map){
    }
    
    init() {
    }
    
    
    
    func mapping(map: Map) {
        venue <- map["venue"]
        tips <- map["tips"]
    }
}
