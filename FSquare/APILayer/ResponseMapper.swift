//
//  ResponseMapper.swift
//  DropBy
//
//  Created by abdullah barjoud on 2/13/16.
//  Copyright © 2016 DropBy. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

enum ResponseMapper {

    
static func mapResponse<Model:Mappable>(responseObject:Alamofire.Request, forRequest requestObject:RequestObject,completion:(Model?,String?) -> Void)  {
        
        log.info("Mapping Response of Request [\(requestObject.name)] to Model Type ")

            responseObject.responseObject{(response: Response<Model, NSError>) in
                if let error = response.result.error {
                    log.error("Parse response for request [\(requestObject.name)] made an error [\(error.description)]")
                    completion(nil,error.description)
                    return
                }
                else {
                    let value:Model = response.result.value!
                    
                    log.info("Parsing data successfully for reqeust [[\(requestObject.name)]] with value ")
                    DataManager.sharedInstance.saveObject(value, forRequest: requestObject,completion: completion)
                }
            }
    }
}


