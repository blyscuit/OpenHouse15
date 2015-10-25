//
//  MapViewController.swift
//  OpenHouseOneFive
//
//  Created by Bliss Wetchaye on 2015-10-20.
//  Copyright © 2015 Thinc. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController {

    let locationManager = CLLocationManager()
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var cButton: UIButton!
    @IBOutlet weak var bButton: UIButton!
    @IBOutlet weak var landmarkButton: UIButton!
    @IBOutlet weak var inforButton: UIButton!
    @IBOutlet weak var stationButton: UIImageView!
    @IBOutlet weak var aButton: UIButton!
    @IBOutlet weak var facultyButton: UIButton!
    
    var stationOn:Bool = false
    var facOn:Bool = false
    var landOn:Bool = false
    var infoOn:Bool = false
    var aOn:Bool = false
    var bOn:Bool = false
    var cOn:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        var camera = GMSCameraPosition.cameraWithLatitude(-33.86,
            longitude: 151.20, zoom: 6)
        mapView.camera = camera
        mapView.myLocationEnabled = true
        mapView.settings.myLocationButton = false
        
        var marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(-33.86, 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
        // Do any additional setup after loading the view.
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        toggleAButton()
        toggleBButton()
        toggleCButton()
        toggleFacButton()
        toggleInfoButton()
        toggleLandButton()
        toggleStationButton()
    }
    
    func toggleAButton(){
        aOn = !aOn
        if(aOn == false){
            if let image = UIImage(named: "route-a-inactive.png") {
                aButton.setImage(image, forState: .Normal)
            }
        }else{
            if let image = UIImage(named: "route-a-active.png") {
                aButton.setImage(image, forState: .Normal)
            }
        }
    }
    func toggleBButton(){
        bOn = !bOn
        if(bOn == false){
            if let image = UIImage(named: "route-b-inactive.png") {
                bButton.setImage(image, forState: .Normal)
            }
        }else{
            if let image = UIImage(named: "route-b-active.png") {
                bButton.setImage(image, forState: .Normal)
            }
        }
    }
    func toggleCButton(){
        cOn = !cOn
        if(cOn == false){
            if let image = UIImage(named: "route-c-inactive.png") {
                cButton.setImage(image, forState: .Normal)
            }
        }else{
            if let image = UIImage(named: "route-c-active.png") {
                cButton.setImage(image, forState: .Normal)
            }
        }
    }
    func toggleLandButton(){
        landOn = !landOn
        if(landOn == false){
            if let image = UIImage(named: "landmark-button-inactive.png") {
                landmarkButton.setImage(image, forState: .Normal)
            }
        }else{
            if let image = UIImage(named: "landmark-button-active.png") {
                landmarkButton.setImage(image, forState: .Normal)
            }
        }
    }
    func toggleFacButton(){
        facOn = !facOn
        if(facOn == false){
            if let image = UIImage(named: "faculty-button-inactive.png") {
                facultyButton.setImage(image, forState: .Normal)
            }
        }else{
            if let image = UIImage(named: "faculty-button-active.png") {
                facultyButton.setImage(image, forState: .Normal)
            }
        }
    }
    func toggleInfoButton(){
        infoOn = !infoOn
        if(infoOn == false){
            if let image = UIImage(named: "information-button-inactive.png") {
                inforButton.setImage(image, forState: .Normal)
            }
        }else{
            if let image = UIImage(named: "information-button-active.png") {
                inforButton.setImage(image, forState: .Normal)
            }
        }
    }
    func toggleStationButton(){
        stationOn = !stationOn
        if(stationOn == false){
            if let image = UIImage(named: "popbus-station-inactive.png") {
                stationButton.image = image
            }
        }else{
            if let image = UIImage(named: "popbus-station-active.png") {
                stationButton.image = image
            }
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func moveHere(sender: AnyObject) {
        locationManager.startUpdatingLocation()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func stationPress(sender: AnyObject) {
        toggleStationButton()
    }
    
    @IBAction func aRoutePress(sender: AnyObject) {
        toggleAButton()
    }
    @IBAction func bRoutePress(sender: AnyObject) {
        toggleBButton()
    }
    @IBAction func cRoutePress(sender: AnyObject) {
        toggleCButton()
    }
    @IBAction func facPress(sender: AnyObject) {
        toggleFacButton()
    }
    @IBAction func landPress(sender: AnyObject) {
        toggleLandButton()
    }
    @IBAction func infoPress(sender: AnyObject) {
        toggleInfoButton()
    }
}

// MARK: - CLLocationManagerDelegate
//1
extension MapViewController: CLLocationManagerDelegate {
    // 2
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        // 3
        if status == .AuthorizedWhenInUse {
            
            // 4
            locationManager.startUpdatingLocation()
            
            //5
            mapView.myLocationEnabled = true
            mapView.settings.myLocationButton = true
        }
    }
    
    // 6
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            
            // 7
            mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
            
            // 8
            locationManager.stopUpdatingLocation()
        }
    }
}
