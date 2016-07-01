//
//  VenueAnnotation.swift
//  FSquare
//
//  Created by abdullah barjoud on 6/27/16.
//  Copyright © 2016 abdullah barjoud. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit


class VenueAnnotation: NSObject {
    
    let name: String
    let location: CLLocation
    let order:Int
    
    init(name: String, order:Int, latitude: Double, longitude: Double) {
        self.name = name
        self.order = order
        self.location = CLLocation(latitude: latitude, longitude: longitude)
    }
} 
    
    extension VenueAnnotation: MKAnnotation {
        var coordinate: CLLocationCoordinate2D {
            get {
                return location.coordinate
            }
        }
        var title: String? {
            get {
                return name
            }
        }
        var subtitle: String? {
            get {
                return name
            }
        }
        
        
    }
    


