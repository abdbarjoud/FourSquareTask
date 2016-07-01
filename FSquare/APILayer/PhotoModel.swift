//
//  PhotoModel.swift
//  FSquare
//
//  Created by abdullah barjoud on 6/26/16.
//  Copyright © 2016 abdullah barjoud. All rights reserved.
//

import UIKit
import ObjectMapper

class PhotoModel: Mappable {
    var prefix:String?
    var suffix:String?
    
    
    
    required init?(_ map: Map){
    }
    
    init() {
    }
    
    
    
    func mapping(map: Map) {
        suffix <- map["suffix"]
        prefix <- map["prefix"]
    }
    
    func getImageLink() -> String {
        return "\(prefix!)160x160\(suffix!)"
    }

}
