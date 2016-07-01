//
//  ProfileModel.swift
//  CarRental
//
//  Created by abdullah barjoud on 4/3/16.
//  Copyright © 2016 IMENA. All rights reserved.
//

import AlamofireObjectMapper
import ObjectMapper

class ProfileModel: Mappable {
    var firstName:String?
    var lastName:String?
    var fatherName:String?
    var email:String?
    var telephone:String?
    var customerIdType:String?
    var birthDate:String?
    var nationality:String?
    
    required init?(_ map: Map){
    }
    
    init() {
    }
    
    
    
    func mapping(map: Map) {
        firstName <- map["data.firstname"]
        lastName <- map["data.lastname"]
        fatherName <- map["data.fathername"]
        email <- map["data.email"]
        telephone <- map["data.telephone"]
        customerIdType <- map["data.customer_id_type"]
        birthDate <- map["data.birthdate"]
        nationality <- map["data.nationality"]
    }

}
