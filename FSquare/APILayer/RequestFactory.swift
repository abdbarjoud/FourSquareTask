//
//  RequestFactory.swift
//  DropBy
//
//  Created by abdullah barjoud on 2/13/16.
//  Copyright © 2016 DropBy. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
enum RequestFactory {

    /**
    factory function to get all reqests information for connection manager depending on request name
    
        - parameter reqeust: the request Name
        - return: structure object contain all needed information for this request (name,type,url,parameters,store type)
    */
    static  func getRequestObject(request:RequestName,parameters:Dictionary<Parameter,AnyObject>) -> RequestObject
    {
        log.info("Getting Request Object for \(request.rawValue)")
        let properties:RequestProperties = self.getRequestProperties(request)
        let requestObject = RequestObject(name: request, properties: properties, inputParameters: parameters)
        return requestObject
    }

    
    /**
     get all properties for the given request 
     
     */
   private static func getRequestProperties(requestName:RequestName) -> RequestProperties
    {
        switch requestName {
        case .VenueExplore:
            return RequestProperties(type:.GET,cachLevel:.Temporary,parameters:RequestFactory.getParametersInputForRequest(requestName),encoding:.URLEncodedInURL)
        }
    }
    

    private static func getParametersInputForRequest(requestName:RequestName) -> Array<ParameterKey>
    {
        switch requestName {
        case .VenueExplore:
            return [ParameterKey(.ClientId),ParameterKey(.ClientSecret),ParameterKey(.Altitude),ParameterKey(.Accuracy),ParameterKey(.Radius),ParameterKey(.Section),ParameterKey(.Limit),ParameterKey(.Offset),ParameterKey(.Time),ParameterKey(.Day),ParameterKey(.Photos),ParameterKey(.IsOpen),ParameterKey(.Sort),ParameterKey(.Price),ParameterKey(.Saved),ParameterKey(.Specials),ParameterKey(.ClientId),ParameterKey(.ClientId),ParameterKey(.Coordinates),ParameterKey(.CoordinatesAccuracy),ParameterKey(.Version)]
        }
    }
}


