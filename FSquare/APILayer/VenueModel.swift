//
//  VenueModel.swift
//  FSquare
//
//  Created by abdullah barjoud on 6/25/16.
//  Copyright © 2016 abdullah barjoud. All rights reserved.
//

import UIKit
import ObjectMapper
class VenueModel: Mappable {
  
    var name:String?
    var phone:String?
    var location:VenueLocationModel?
    var category:VenueCategoryModel?
    var stats:VenueStatsModel?
    var price:VenuePriceModel?
    var rating:Int?
    var ratingColor:String?
    var ratingSignals:Int?
    var hoursStatus:String?
    var isOpen:Bool?
    var photos:Array<PhotoModel>?
    
    
    required init?(_ map: Map){
    }
    
    init() {
    }
    
    
    
    func mapping(map: Map) {
        name <- map["name"]
        phone <- map["contact.phone"]
        location <- map["location"]
        category <- map["categories.0"]
        stats <- map["stats"]
        price <- map["price"]
        rating <- map["rating"]
        ratingColor <- map["ratingColor"]
        ratingSignals <- map["ratingSignals"]
        hoursStatus <- map["hours.status"]
        isOpen <- map["hours.isOpen"]
        photos <- map["photos.groups.0.items"]
    }

}
