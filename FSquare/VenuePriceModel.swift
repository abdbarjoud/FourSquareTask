//
//  VenuePriceModel.swift
//  FSquare
//
//  Created by abdullah barjoud on 6/25/16.
//  Copyright © 2016 abdullah barjoud. All rights reserved.
//

import UIKit
import ObjectMapper

class VenuePriceModel: Mappable {

    var tier:Int?
    var message:String?
    var currency:String?

    required init?(_ map: Map){
    }
    
    init() {
    }
    
    
    
    func mapping(map: Map) {
        tier <- map["tier"]
        message <- map["message"]
        currency <- map["currency"]
        
    }
}
