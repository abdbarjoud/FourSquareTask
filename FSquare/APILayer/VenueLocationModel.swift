//
//  LocationModel.swift
//  FSquare
//
//  Created by abdullah barjoud on 6/25/16.
//  Copyright © 2016 abdullah barjoud. All rights reserved.
//

import ObjectMapper

class VenueLocationModel: Mappable {

    var address:String?
    var lat:Float?
    var lon:Float?
    var distance:Int?
    var cc:String?
    var city:String?
    var state:String?
    var country:String?
    
    
    
    required init?(_ map: Map){
    }
    
    init() {
    }
    
    func mapping(map: Map) {
        address <- map["address"]
        lat <- map["lat"]
        lon <- map["lng"]
        distance <- map["distance"]
        cc <- map["cc"]
        city <- map["city"]
        state <- map["state"]
        country <- map["country"]
    }
}
