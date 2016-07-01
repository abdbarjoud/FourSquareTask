//
//  ViewController.swift
//  FSquare
//
//  Created by abdullah barjoud on 6/25/16.
//  Copyright © 2016 abdullah barjoud. All rights reserved.
//

import UIKit
import CoreLocation

final class HomeViewController: UIViewController,loadingProtocol,alertProtocol {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mapViewButton: UIBarButtonItem!
    var currentLocation:CLLocation? { didSet {self.updateData() } }
    var refreshControl: UIRefreshControl!

    let locationManager = CLLocationManager()

  private var venuesList:NearbyListModel? = NearbyListModel() { didSet {tableView.reloadData() } }
    
    // MARK: - view lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initStyle()
        self.initRefreshControl()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        self.setNeedsStatusBarAppearanceUpdate();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - view Refresh control 
    func initRefreshControl() -> Void {
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(HomeViewController.refresh), forControlEvents: UIControlEvents.ValueChanged)
        tableView.addSubview(refreshControl)
    }
    
    func refresh() -> Void {
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            self.updateData()
        }
        else
        {
            let handler = { (action:UIAlertAction) -> Void  in
                UIApplication.sharedApplication().openURL(NSURL(string: UIApplicationOpenSettingsURLString)!)
            }
            self.alertErrorWithHandler("Please Activate location service", handler: handler)
        }
    }
    
    // MARK: - data control
   private func updateData() -> Void
    {
        if let location = currentLocation {
            self.startLoader()
            FSAPI.exploreNearby(location.coordinate.latitude, longtitude: location.coordinate.longitude) {  (nearbyList, error) in
                if let nearbyList = nearbyList {
                    self.venuesList = nearbyList
                    self.endLoader()
                    self.refreshControl.endRefreshing()
                }
                else
                {
                    // show error messages
                    self.alertError(error!)
                }
            }

        }
    }

// MARK: - style customization
    private func initStyle() -> Void
    {
        self.navigationController?.navigationBar.barTintColor = UIColor.fSOrange()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        let  buttonItem:UIBarButtonItem = self.navigationItem.rightBarButtonItem!
        buttonItem.setTitleTextAttributes([NSFontAttributeName:UIFont.fSIconFont(),NSForegroundColorAttributeName: UIColor.whiteColor()], forState: UIControlState.Normal)
        buttonItem.title = ""
    }
   

// MARK: - ACTIONS
    
    @IBAction func toggleMap(sender: AnyObject) {
        let mapView = self.storyboard?.instantiateViewControllerWithIdentifier("mapView") as! MapViewController
        let screenSize = UIScreen.mainScreen().bounds.size  // screen size
        let mapViewHeight = screenSize.height - 64 // height of mapview under navigation bar
        let mapViewHiddenY = screenSize.height - 2*(mapViewHeight) // y coordinate wheh map is hidden ( start of show, end of hide
        let mapViewVisibleY:CGFloat = 64.0 // y coordinate wheh map is hidden ( start of show, end of hide
        
        if self.childViewControllers.count == 0 {// show animation
            mapView.venuesList = self.venuesList!
            let mapViewStartFrame =  CGRectMake(0, mapViewHiddenY, screenSize.width, mapViewHeight)
            let mapViewEndFrame = CGRectMake(0, mapViewVisibleY, screenSize.width, mapViewHeight)
            self.addChildViewController(mapView)
            mapView.view.frame = mapViewStartFrame
            self.view.addSubview((mapView.view)!)
            let  buttonItem:UIBarButtonItem = self.navigationItem.rightBarButtonItem!
            buttonItem.title = ""
            UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                               mapView.view.frame = mapViewEndFrame
                }, completion: { (result) in

            })
        }
        else {
            let  buttonItem:UIBarButtonItem = self.navigationItem.rightBarButtonItem!
            buttonItem.title = ""
            let mapViewEndFrame = CGRectMake(0, mapViewHiddenY, screenSize.width, mapViewHeight)
            let mapView = self.childViewControllers.first!
            UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                mapView.view.frame = mapViewEndFrame
                }, completion: { (result) in
                    mapView.view.removeFromSuperview()
                    mapView.removeFromParentViewController()
            })
            
        }

    }
    
}
// MARK: - table view Delegate extention
extension HomeViewController:UITableViewDataSource {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let list = self.venuesList?.nearbyList {
            return (list.count)
        }
        return 0
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let nearbyModel:NearbyModel = venuesList!.nearbyList![indexPath.row]
        let cell: VenueCell  = tableView.dequeueReusableCellWithIdentifier(String(VenueCell), forIndexPath: indexPath) as! VenueCell
        cell.configureCellWithModel(nearbyModel)
        return cell
    }
    
    
    
}

// MARK: - Location change extention
extension HomeViewController: CLLocationManagerDelegate {
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedWhenInUse {
            if status == .AuthorizedWhenInUse || status == .AuthorizedAlways {
                locationManager.startUpdatingLocation()
                self.startLoader()
            }
        }
        if status == .Denied
        {
            self.endLoader()
            let handler = { (action:UIAlertAction) -> Void  in
                UIApplication.sharedApplication().openURL(NSURL(string: UIApplicationOpenSettingsURLString)!)
            }
            self.alertErrorWithHandler("Please Activate location service", handler: handler)
        }
        
        
    }
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let currentLocation = currentLocation {
            let newLocation = locations.first!
            let distance:CLLocationDistance = newLocation.distanceFromLocation(currentLocation)
            if distance > 300  {
                self.currentLocation = newLocation
            }
        }
        else
        {
            self.currentLocation = locations.first!
        }
    }
    
}


