//
//  Constants.swift
//  DropBy
//
//  Created by abdullah barjoud on 2/13/16.
//  Copyright © 2016 DropBy. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

struct Constants {
    struct ClientKeys {
         static let clientId = "BSRYCVGKMKMZ1OWWPBHAOSWDJFRRA4P4E2R3HLHUGRDOB3XK"
         static let clientSecret = "2MQ2EZ52YBP2OBVV0EWSVMDJOF30PVIRMNH3PWCN4VEKT4SB"
    }
}

/// tuple for all required properties for each request
typealias RequestProperties = (type:RequestType,cachLevel:CachLevel,parameters:Array<ParameterKey>,encoding:ParameterEncoding)

/**
 Http Request method GET,POST,PUT,PATCH,DELETE
*/
enum RequestType: Int {
    case GET = 1
    case POST = 2
    case PUT = 3
    case PATCH = 4
    case DELETE = 5
}


enum RequestError: ErrorType
{
    case MissingParameter(parameterName:Parameter)
    case ParseObjectFail(parseError:String)
}
/**
 Define all requests used in the application, passed as parameter to requests factory to get all request properties
*/
enum RequestName: String {
    
    case VenueExplore = "venues/explore"
    static let allValues = [VenueExplore]
}

/**
 Define all parameters can be passed to the requests
*/
enum Parameter: String{
    case ClientId = "client_id"
    case ClientSecret = "client_secret"
    case Altitude = "alt"
    case Accuracy = "altAcc"
    case Radius = "radius"
    case Section = "section"
    case Limit = "limit"
    case Offset = "offset"
    case Time = "time"
    case Day = "day"
    case Photos = "venuePhotos"
    case IsOpen = "openNow"
    case Sort = "sortByDistance"
    case Price = "price"
    case Saved = "saved"
    case Specials = "specials"
    case Coordinates = "ll"
    case CoordinatesAccuracy = "llAcc"
    case Version = "v"
}

/**
 Define parameter names
 */
struct ParameterKey {
    let parameter:Parameter
    let required:Bool
    
    init( _ parameter:Parameter, _ isRequired:Bool = true)
    {
        self.parameter = parameter;
        self.required = isRequired;
    }
}

/**
 Define configurations on application level, those configurations saved in application data
*/
enum Configuration: String{
    case hash = "hash"
    case deviceId = "device_id"
}

/**
 Define if the Response of the request should be saved temporary, parmenantly or not saved at all
*/
enum CachLevel: Int{
    case None = 0
    case Temporary = 1
    case Permanent = 2
}

/**
 *  protocol for request object functions
 */
protocol RequestObjectProtocol {
    /**
     Get Parameters Dictionary depending on passed parameters
     throw exception in case of missing required parameter
     */
    func getRequestParameters() throws ->Dictionary<String,AnyObject>
}
/**
    Request object that has all information about each request that application use, this object created from requests factory by passing request name
 
    -requestName: the name passed for the request
    -parameters: a list of parameters names for this request
    -requestType: type of http Method for this request (GET,POST,PUT,DELETE,PATCH)
    -requestUrl: the url of the endpoint for the request
    -cachLevel: define how the response of the request will be saved (temperary, paremenent, or won't be saved)
    -requestClosure: the function that create the request and get completion response object or error
*/
struct RequestObject:RequestObjectProtocol {
    let name:RequestName
    let properties:RequestProperties
    let inputParameters:Dictionary<Parameter,AnyObject>?
    let requestUrl:String
    // API base url
    
     static let rootAPI = "https://api.foursquare.com/v2/"
    // Initializers
    init(name:RequestName,properties:RequestProperties,inputParameters:Dictionary<Parameter,AnyObject>? = nil) {
        self.name = name
        self.inputParameters = inputParameters
        self.properties = properties
        self.requestUrl = String(format: "%@%@",RequestObject.rootAPI,name.rawValue)
    }
    // map struct status with almofire status
    var httpMethod:Alamofire.Method
    {
        switch properties.type {
        case RequestType.GET: return Alamofire.Method.GET;
        case RequestType.POST: return Alamofire.Method.POST;
        case RequestType.PUT: return Alamofire.Method.PUT;
        case RequestType.PATCH: return Alamofire.Method.PATCH;
        case RequestType.DELETE: return Alamofire.Method.DELETE;
        }
    }
    
    /**
        Get Parameters Dictionary depending on passed parameters
        throw exception in case of missing required parameter
     */
    func getRequestParameters() throws ->Dictionary<String,AnyObject>
    {
        var outputDictionary:Dictionary<String,AnyObject> = Dictionary();
        
        for parameterkey in properties.parameters {
            if let value = inputParameters![parameterkey.parameter] {
                outputDictionary[parameterkey.parameter.rawValue] = value
            }
            else// no parameter value for this key
            {
                if parameterkey.required {
                    throw RequestError.MissingParameter(parameterName: parameterkey.parameter)
                }
            }
        }
        return outputDictionary
    }
    
}





