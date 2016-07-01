//
//  NearbyListModel.swift
//  FSquare
//
//  Created by abdullah barjoud on 6/25/16.
//  Copyright © 2016 abdullah barjoud. All rights reserved.
//

import UIKit
import ObjectMapper
class NearbyListModel: Mappable {
    var nearbyList:Array<NearbyModel>?
    
    
    required init?(_ map: Map){
    }
    
    init() {
    }
    
    
    
    func mapping(map: Map) {
        nearbyList <- map["response.groups.0.items"]
    }
}
