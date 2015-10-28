//
//  MapViewController.swift
//  OpenHouseOneFive
//
//  Created by Bliss Wetchaye on 2015-10-20.
//  Copyright © 2015 Thinc. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController,GMSMapViewDelegate,CLLocationManagerDelegate {

    let locationManager = CLLocationManager()
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var cButton: UIButton!
    @IBOutlet weak var bButton: UIButton!
    @IBOutlet weak var landmarkButton: UIButton!
    @IBOutlet weak var inforButton: UIButton!
    @IBOutlet weak var stationButton: UIImageView!
    @IBOutlet weak var aButton: UIButton!
    @IBOutlet weak var facultyButton: UIButton!
    
    @IBOutlet weak var detailView: UIView!
    
    @IBOutlet weak var facInfoButton: UIView!
    @IBOutlet weak var facultyInfoButton: UIButton!
    @IBOutlet weak var locationButton: UIButton!
    
    var landMarkArray = [GMSMarker]()
    var stationArray = [GMSMarker]()
    var facultyArray = [GMSMarker]()
    var infomationkArray = [GMSMarker]()
    
    var aRoute:GMSPolyline?
    var bRoute:GMSPolyline?
    var cRoute:GMSPolyline?
    
    var viewInitialPosition:CGRect!
    
    var positionButtonInitialPosition:CGPoint!
    
    @IBOutlet weak var facultyNameLabel: UILabel!
    @IBOutlet weak var buildingNameEngLabel: UILabel!
    @IBOutlet weak var buildingNameLabel: UILabel!
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
        mapView.delegate = self
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        populateArray()
        
        toggleAButton()
        toggleBButton()
        toggleCButton()
        toggleFacButton()
        toggleInfoButton()
        toggleLandButton()
        toggleStationButton()
        viewInitialPosition = CGRectMake(CGRectGetMidX(self.view.frame) - detailView.frame.size.width/2, self.view.frame.size.height - (detailView.frame.origin.y - 170),detailView.frame.size.width,detailView.frame.size.height)
        // detailView.frame
        detailView.frame.origin = CGPointMake(-1000,0)
        detailView.alpha=0.0
        detailView.layer.borderWidth = 1
        
        detailView.layer.borderColor = UIColor.lightGrayColor().CGColor
        detailView.clipsToBounds = true
        
        positionButtonInitialPosition = CGPointMake(self.view.frame.size.width - locationButton.frame.size.width - 20,self.view.frame.size.height - locationButton.frame.size.width - 65)
        self.view.layoutIfNeeded()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        if(detailView.alpha == 1.0){
            self.locationButton.frame.origin = CGPointMake(self.positionButtonInitialPosition.x, self.positionButtonInitialPosition.y - self.detailView.frame.size.height - 30)
        }else{
            self.locationButton.frame.origin = positionButtonInitialPosition
        }
        self.view.layoutIfNeeded()
    }
    
    func populateArray(){
        
        var marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(-33.86, 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        
        facultyArray.append(marker)
        
        var path = GMSMutablePath()
        path.addCoordinate(CLLocationCoordinate2DMake(-33.85, 151.20))
        path.addCoordinate(CLLocationCoordinate2DMake(-33.70, 151.40))
        path.addCoordinate(CLLocationCoordinate2DMake(-33.73, 151.41))
        var polyline = GMSPolyline(path: path)
        
        aRoute = polyline
        bRoute = GMSPolyline()
        cRoute = GMSPolyline()
    }
    
    func toggleAButton(){
        aOn = !aOn
        toggleLine(aRoute!, on: aOn)
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
        toggleLine(bRoute!, on: bOn)
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
        toggleLine(cRoute!, on: cOn)
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
        toggleArray(landMarkArray, on: landOn)
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
        toggleArray(facultyArray, on: facOn)
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
        toggleArray(infomationkArray, on: infoOn)
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


// MARK: - CLLocationManagerDelegate
//1

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
    
    func toggleArray(array:[GMSMarker],on:Bool){
        print(array)
        if on{
        for marker in array{
            marker.map = mapView
        }
        }else{
            
            for marker in array{
                marker.map = nil
            }
        }
    }
    
    
    @IBAction func closeDetail(sender: AnyObject) {
        UIView.animateWithDuration(0.3, animations: {
            self.detailView.alpha = 0.0

            
            self.locationButton.frame.origin = CGPointMake(self.positionButtonInitialPosition.x, self.positionButtonInitialPosition.y)
            
            }, completion: { (SUCCESS) -> Void in
                self.detailView.frame.origin = CGPointMake(-1000, 0)
                self.view.layoutIfNeeded()
        })
    }
    
    func animateInDetail(marker:GMSMarker){
        if(detailView.alpha == 1){
            return
        }
        self.buildingNameLabel.text = marker.title
        self.buildingNameEngLabel.text = marker.description
        self.facultyNameLabel.text = marker.snippet
        self.detailView.frame = viewInitialPosition
        
        self.locationButton.frame.origin = positionButtonInitialPosition
        
        UIView.animateWithDuration(0.3, animations: {
            self.detailView.alpha = 1.0
            
            self.locationButton.frame.origin = CGPointMake(self.positionButtonInitialPosition.x, self.positionButtonInitialPosition.y - self.detailView.frame.size.height - 30)
            
            self.view.layoutIfNeeded()
            
            }, completion: { (SUCCESS) -> Void in
                
        })
    }
    
    func toggleLine(line:GMSPolyline, on:Bool){
        if on{
            line.map = mapView
        }else{
            line.map = nil
        }
    }
    
    func mapView(mapView: GMSMapView!, didTapMarker marker: GMSMarker!) -> Bool {
        animateInDetail(marker)
        return true
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    @IBAction func  facultyInfoPress(sender: AnyObject) {
    }
    @IBAction func facultyHighlightPress(sender: AnyObject) {
    }
}
