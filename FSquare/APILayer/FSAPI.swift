//
//  IMAPI.swift
//  CarRental
//
//  Created by abdullah barjoud on 4/6/16.
//  Copyright © 2016 IMENA. All rights reserved.
//

import UIKit

enum FSAPI {

    // MARK: - Explore nearby control
    static  func exploreNearby(latitude:Double,longtitude:Double, completion:(NearbyListModel?,String?)-> Void)-> Void
    {
        let location:String = String(format: "%0.6f,%0.6f", latitude,longtitude)
        
        let parameters:Dictionary<Parameter,AnyObject> = [.ClientId:Constants.ClientKeys.clientId,
                                                          .ClientSecret:Constants.ClientKeys.clientSecret,
                                                          .Coordinates:location,.CoordinatesAccuracy:(10000),
                                                          .Altitude:(0),
                                                          .Accuracy:(10000),
                                                          .Radius:(2500),
                                                          .Section:"food",
                                                          .Limit:(10),
                                                          .Offset:(0),
                                                          .Time:"any",
                                                          .Day:"any",
                                                          .Photos:(1),
                                                          .IsOpen:(1),
                                                          .Sort:(1),
                                                          .Price:"1,2,3,4",
                                                          .Saved:(0),
                                                          .Specials:(0),
                                                          .Version:"20160601"]
        
        ConnectionManager.sharedInstance.sendRequest(.VenueExplore, withParameters:parameters, completion: completion)
    }
    
    
    
}
