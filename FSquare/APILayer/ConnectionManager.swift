//
//  ConnectionManager.swift
//  DropBy
//
//  Created by abdullah barjoud on 2/13/16.
//  Copyright © 2016 DropBy. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
class ConnectionManager {
    static let sharedInstance = ConnectionManager()
    var defaultManager:Alamofire.Manager
    private init() {
        defaultManager = {
            let serverTrustPolicies: [String: ServerTrustPolicy] = [
                "httpbin.org": .DisableEvaluation,
            ]
            
            let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
            configuration.HTTPAdditionalHeaders = Alamofire.Manager.defaultHTTPHeaders
            
            return Alamofire.Manager(
                configuration: configuration,
                serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
            )
            }()
    }
    /**
     Send Request to API Returning the object model for the json response or error in case of any error
     
     -requestName: the name passed for the request
     -parameters: a list of parameters names for this request
     -completion: the returned completion block including Object Model in success case, or error message for any error
     */
    func sendRequest<Model:Mappable>(requestName:RequestName,withParameters parameters:Dictionary<Parameter,AnyObject>,completion:(Model?,String?)-> Void)
    {
        log.verbose("Start function")
        do {
            // get response stucture for the request
            let requestObject = RequestFactory.getRequestObject(requestName, parameters: parameters)
            // get parameters for the request
            let parameters = try requestObject.getRequestParameters()
            let url:URLStringConvertible = requestObject.requestUrl
            let encoding = requestObject.properties.encoding
            
            // send the request
                let request:Request =  self.defaultManager.request(requestObject.httpMethod, url, parameters:parameters, encoding: encoding, headers: nil)
                
            
                self.printRequest(request)

                // check the response of request
                request.responseJSON { response in
                    self.printResponse(request,response: response)
                    if let error = response.result.error// error response
                    {
                        log.error("Connection Error for request \(requestName.rawValue) Error Description is: \(error.description)")
                        completion(nil,error.description)
                    }
                    else// valid response, send to backend parser
                    {
                        log.info("Request: \(requestName.rawValue) called successfully ")
                        // map json response to according class (Model) , and save the response if saving is required
                       ResponseMapper.mapResponse(request, forRequest: requestObject, completion: completion)
                    }
                }
        }
        catch {
            let error = error as? RequestError
            log.error("Error making a request: \(error)")
        }

        log.verbose("End function")

    }
    
  private  func printRequest(request:Alamofire.Request)
    {
        let body:String
        if let data = request.request?.HTTPBody {
            body = String(data:data, encoding:NSUTF8StringEncoding)!
        } else {
            body = ""
        }
        

        let httpMethod = request.request!.HTTPMethod
        let httpHeader = request.request!.allHTTPHeaderFields!

        let url = request.request?.URL?.absoluteString
        log.debug("******************************************************************************************")
        log.debug("\(httpMethod!) \(url!)")
        log.debug("[HEADER] \(httpHeader)")
        log.debug("[BODY] \(body)")
        log.debug("******************************************************************************************")
    }
    
    
  private  func printResponse(request:Alamofire.Request,response:Response<AnyObject,NSError>)
    {
        let httpMethod = request.request!.HTTPMethod
        let url = request.request?.URL?.absoluteString

        log.debug("==========================================================================================")
        if let error = response.result.error {
            log.debug("[Error] \(httpMethod!) \(url!) \(response.response?.statusCode) ")
            log.debug("\(error)")
        }
        else {
            let bodyResponse = String(data: response.data!, encoding:NSUTF8StringEncoding)?.stringByRemovingPercentEncoding
            log.debug("\(request.request?.HTTPMethod!) \(request.request?.URL?.absoluteString)  \(request.request?.allHTTPHeaderFields)")
            log.debug("\(bodyResponse)")
        }
        
        log.debug("==========================================================================================")
    }
    

    
    
}