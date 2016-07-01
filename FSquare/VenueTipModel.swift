//
//  VenueTip.swift
//  FSquare
//
//  Created by abdullah barjoud on 6/25/16.
//  Copyright © 2016 abdullah barjoud. All rights reserved.
//

import UIKit
import ObjectMapper

class VenueTipModel: Mappable {
    var createdAt:Double?
    var text:String?
    var likes:Int?
    var firstName:String?
    var lastName:String?
    var photoPrefix:String?
    var photoSuffix:String?
    var gender:String?
    
    
    
    required init?(_ map: Map){
    }
    
    init() {
    }
    
    func mapping(map: Map) {
        createdAt <- map["createdAt"]
        text <- map["text"]
        likes <- map["likes.count"]
        firstName <- map["user.firstName"]
        lastName <- map["user.lastName"]
        gender <- map["user.gender"]
        photoPrefix <- map["user.photo.prefix"]
        photoSuffix <- map["user.photo.suffix"]
    }

}
