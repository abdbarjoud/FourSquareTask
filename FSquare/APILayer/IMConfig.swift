//
//  IMConfig.swift
//  CarRental
//
//  Created by abdullah barjoud on 4/6/16.
//  Copyright © 2016 IMENA. All rights reserved.
//

import UIKit
protocol configsProtocol {
    
}
class IMConfig {
    static let sharedInstance = IMConfig()
    private var configList:Array<AnyObject>
    private init() {
        configList = Array()
    } //T

private enum Config:String {
        case IsLogin
    }


    private func saveConfig(configType:Config, value:AnyObject)
    {
        if let saveResult:Bool = NSKeyedArchiver.archiveRootObject(value, toFile: self.getFilePath()) {
            
        }
        
    }
    
    
    func getFilePath()->String
    {
        let paths:Array = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true)
        let documentDirectory:String = paths[0]
        let result:String = String(format: "%@/settings.plist",documentDirectory)
        return result
    }

}


//-(void)saveConfig:(IMConfig)configType withValue:(NSString*)value;
//-(NSString*)getConfig:(IMConfig)config;
//-(BOOL)checkConfigExist:(IMConfig)config;
//-(void)removeConfig:(IMConfig)config ;



