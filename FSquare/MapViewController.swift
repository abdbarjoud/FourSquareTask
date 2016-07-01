//
//  MapViewController.swift
//  FSquare
//
//  Created by abdullah barjoud on 6/27/16.
//  Copyright © 2016 abdullah barjoud. All rights reserved.
//

import Foundation
import UIKit
import MapKit
class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var venuesCollectionView: UICollectionView!
    var venuesList:NearbyListModel = NearbyListModel() { didSet {
//        venuesCollectionView.reloadData()
        
        } }
    
     var venuesAnnotations:Array<VenueAnnotation> = []
    
    // MARK: - view lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureMap()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    // MARK: - Map Control
    func configureMap() -> Void {
        self.loadAnnotations()
        
        mapView.mapType = .Standard
        mapView.rotateEnabled = false
        
        mapView.addAnnotations(venuesAnnotations)
        
        let regionRadius: CLLocationDistance = 3000
        
        let hq = venuesAnnotations.first
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(hq!.location.coordinate, regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    
    func loadAnnotations() -> Void {

        if let nearbyList = venuesList.nearbyList {
        
        for (index,nearby) in nearbyList.enumerate() {
            if let venue = nearby.venue,location = nearby.venue?.location {
                let lat = location.lat!
                let lon = location.lon!
                
                let venueAnnotation = VenueAnnotation(name:venue.name!, order:index, latitude:Double(lat), longitude:Double(lon))
                venuesAnnotations.append(venueAnnotation)
            }
        }
        }
    }
    
    // MARK: - ACTIONS
    
    @IBAction func goList(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
// MARK: - Map Delegate Extention

extension MapViewController: MKMapViewDelegate {
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier("techHQ") //as? MKAnnotationView
        if annotationView == nil {
            
            annotationView = VenueAnnotationView(annotation: annotation, reuseIdentifier: "techHQ")
        } else {
            annotationView?.annotation = annotation
        }
        
        return annotationView
    }
    
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        let annotation = view.annotation as! VenueAnnotation
        let path:NSIndexPath = NSIndexPath(forRow: annotation.order, inSection: 0)
        view.superview?.bringSubviewToFront(view)
        self.venuesCollectionView.scrollToItemAtIndexPath(path, atScrollPosition: .CenteredHorizontally, animated: true)
    }

}
// MARK: - Collection view Delegate

extension MapViewController:UICollectionViewDataSource {
 
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let list = venuesList.nearbyList {
            return list.count
        }
        return 0
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let nearbyModel:NearbyModel = venuesList.nearbyList![indexPath.row]
        let cell: VenueCollectionViewCell  = collectionView.dequeueReusableCellWithReuseIdentifier(String(VenueCollectionViewCell), forIndexPath: indexPath) as! VenueCollectionViewCell
        cell.configureCellWithModel(nearbyModel)
        return cell
    }
    
     func collectionView(collectionView: UICollectionView,
                                   layout collectionViewLayout: UICollectionViewLayout,
                                          sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize{
        let size = CGSizeMake(collectionView.frame.width - 10,collectionView.frame.height)
        return size
    }
}
   
    
    
    
