//
//  VenueCategoryModel.swift
//  FSquare
//
//  Created by abdullah barjoud on 6/25/16.
//  Copyright © 2016 abdullah barjoud. All rights reserved.
//

import UIKit
import ObjectMapper

class VenueCategoryModel: Mappable {
    var name:String?
    var icon:String?
    var iconSuffix:String?
    
    required init?(_ map: Map){
    }
    
    init() {
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        icon <- map["icon.prefix"]
        iconSuffix <- map["icon.suffix"]
    }
}
