//
//  DataManager.swift
//  DropBy
//
//  Created by abdullah barjoud on 2/13/16.
//  Copyright © 2016 DropBy. All rights reserved.
//

import Foundation
import ObjectMapper

/*
 protocol for all required functionalities from Data manager
 **/
protocol DataManagerProtocol {
    // dictionary with all loaded data
    var cachedData:Dictionary<String,Mappable> { get }// save all cached requests data
    // save object (to memory or to disk)
    func saveObject<Model:Mappable>(object:Model, forRequest request:RequestObject,completion:(Model?,String?) -> Void)
    // load all disk information to cached data dictionary
    func loadAllCachedObjects() -> Void // when application launch, load data needed from dist
    // get object model for certain request
    func getObjectForRequest(request:RequestName) -> Mappable? // get object for request Type
}

class DataManager:DataManagerProtocol {
    static let sharedInstance = DataManager()
    var cachedData = Dictionary<String,Mappable>();
    
    let  queue = dispatch_queue_create("file.management.thread", DISPATCH_QUEUE_CONCURRENT)
    private init() {
        
    }

    // MARK: - save and load objects
    func saveObject<Model:Mappable>(object:Model, forRequest request:RequestObject,completion:(Model?,String?) -> Void)
    {
        guard request.properties.cachLevel == CachLevel.None else {
            
            if request.properties.cachLevel == CachLevel.Temporary
            {
                cachedData[request.name.rawValue] = object;
                log.info("Save Data temporary for reqeust [\(request.name)]")
            }
            else
                if  request.properties.cachLevel == CachLevel.Permanent
                {
                    dispatch_sync(queue, { [unowned self] in
                        let objectString:String = Mapper().toJSONString(object)!
                        let path:String = self.getFilePath(request.name.rawValue)
                        let saveResult:Bool = NSKeyedArchiver.archiveRootObject(objectString, toFile:path)
                        if saveResult {
                            assert(saveResult,"Error saving object to the memory")
                            self.loadObjectForRequest(request)
                            log.info("Save Data To file for reqeust [\(request.name)]")
                        }
                        else {
                            completion(nil,"save object Error")
                            log.error("Error saving object for request [\(request.name)]")
                            return
                        }
                    })
                    
            }
            log.info("Save Data To file for reqeust [\(request.name)]")
            completion(object,nil)
            return
        }
        log.info("Save Data To file for reqeust [\(request.name)]")
        completion(object,nil)
    }

    func loadAllCachedObjects() -> Void {

        for requestName in RequestName.allValues{
            let object = NSKeyedUnarchiver.unarchiveObjectWithFile(self.getFilePath(requestName.rawValue))
            if let object2 = object {
            self.setCachedObject(requestName, object: object2)
            }
        }
    }

    func loadObjectForRequest(request:RequestObject)
    {
        if request.properties.cachLevel == CachLevel.Permanent {
            let object = NSKeyedUnarchiver.unarchiveObjectWithFile(self.getFilePath(request.name.rawValue))
            if let object2 = object {
                self.setCachedObject(request.name, object: object2)
                log.info("Loading data for request \(request.name)")
                log.info("\(object)")
            }
        }
        
    }

    func getObjectForRequest(request:RequestName) -> Mappable?
    {
        assert(cachedData[request.rawValue] == nil, "loading nil object for request \(request)")
        
        guard cachedData[request.rawValue] != nil else {
            log.error("Can't load data for request \(request)")
            return nil;
        }
        
        return cachedData[request.rawValue]
    }
    
  private  func getFilePath(requestName:String)->String
    {
        let paths:Array = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true)
        let documentDirectory:String = paths[0]
        let result:String = String(format: "%@/%@",documentDirectory,requestName.stringByReplacingOccurrencesOfString("/", withString: ""))
        return result
    }

  private  func setCachedObject(requestName:RequestName, object:AnyObject?)
    {
        switch requestName {
        case .VenueExplore:
            cachedData[requestName.rawValue] = Mapper<NearbyListModel>().map(object)
        }
        
    }
    
}
