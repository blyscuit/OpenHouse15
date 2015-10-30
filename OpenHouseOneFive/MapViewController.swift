//
//  MapViewController.swift
//  OpenHouseOneFive
//
//  Created by Bliss Wetchaye on 2015-10-20.
//  Copyright © 2015 Thinc. All rights reserved.
//

import UIKit
import GoogleMaps
import SwiftyJSON

@objc protocol MapControllerDelegate {
    func mapControllerDidTabWeb(text: String, controller: MapViewController)
}

class MapViewController: UIViewController,GMSMapViewDelegate,CLLocationManagerDelegate {
    
    var delegate: MapControllerDelegate?
    
    @IBOutlet weak var facultyButtonView: UIView!
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
    var aStationArray = [GMSMarker]()
    var bStationArray = [GMSMarker]()
    var cStationArray = [GMSMarker]()
    
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
    
    var bingoBoard:Bingo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bingoBoard = Bingo(random: true)
        
        var camera = GMSCameraPosition.cameraWithLatitude(13.7406223,
            longitude: 100.5307583, zoom: 15)
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
        facultyButtonView.frame.origin = CGPointMake(-1000,0)
        detailView.alpha=0.0
        facultyButtonView.alpha=0.0
        detailView.layer.borderWidth = 1
        facultyButtonView.layer.borderWidth = 1
        
        detailView.layer.borderColor = UIColor.lightGrayColor().CGColor
        detailView.clipsToBounds = true
        
        positionButtonInitialPosition = CGPointMake(self.view.frame.size.width - locationButton.frame.size.width - 20,self.view.frame.size.height - locationButton.frame.size.width - 65)
        self.view.layoutIfNeeded()
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        
        bingoBoard = Bingo(random: true)
        
        if(detailView.alpha == 1.0){
            self.locationButton.frame.origin = CGPointMake(self.positionButtonInitialPosition.x, self.positionButtonInitialPosition.y - self.detailView.frame.size.height - 30)
        }else{
            self.locationButton.frame.origin = positionButtonInitialPosition
        }
        self.view.layoutIfNeeded()
    }
    
    func populateArray(){
        var jsonObj:JSON!
        if let path = NSBundle.mainBundle().pathForResource("cuOpenHouseRouteData", ofType: "json"){
            do {
                let data = try NSData(contentsOfURL: NSURL(fileURLWithPath: path), options: NSDataReadingOptions.DataReadingMappedIfSafe)
                jsonObj = JSON(data: data)
                if jsonObj != JSON.null {
                    print("jsonData:\(jsonObj)")
                } else {
                    print("invalid JSON file")
                }
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            
            
            
        } else {
            print("Invaild filename/path!")
        }
        
        aRoute = GMSPolyline()
        bRoute = GMSPolyline()
        cRoute = GMSPolyline()
        
        for (index,subJson):(String, JSON) in jsonObj {
//            for (key,subsubJson):(String, JSON) in subJson {
                //Do something you want
            let name = subJson["name"]
            
            var path = GMSMutablePath()
            for (index2,pathJson):(String, JSON) in subJson["pathway"] {
                
                path.addCoordinate(CLLocationCoordinate2DMake(pathJson["latitude"].doubleValue, pathJson["longitude"].doubleValue))
            }
            if name == "A"{
                aRoute = GMSPolyline(path: path)
                aRoute?.strokeColor = UIColor(rgba: subJson["color"].stringValue)
                aRoute?.strokeWidth = 2.5
            }else if name == "B"{
                bRoute = GMSPolyline(path: path)
                bRoute?.strokeColor = UIColor(rgba: subJson["color"].stringValue)
                bRoute?.strokeWidth = 2.5
            }else if name == "C"{
                cRoute = GMSPolyline(path: path)
                cRoute?.strokeColor = UIColor(rgba: subJson["color"].stringValue)
                cRoute?.strokeWidth = 2.5
            }
//            }
        }
        
        var marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(13.7406223,100.5307583)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        
//        marker.userData = bingoBoard.tileWithID("21")
        
        facultyArray.append(marker)
        
    }
    
    func toggleAButton(){
        aOn = !aOn
        toggleLine(aRoute!, on: aOn)
        toggleArray(aStationArray, on: aOn)
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
        toggleArray(bStationArray, on: bOn)
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
        toggleArray(cStationArray, on: cOn)
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
            
            mapView.animateToZoom(16)
            // 7
            mapView.animateToLocation(location.coordinate)
            
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
            self.facultyButtonView.alpha=0.0
            
//            self.locationButton.frame.origin = CGPointMake(self.positionButtonInitialPosition.x, self.positionButtonInitialPosition.y)
            
            }, completion: { (SUCCESS) -> Void in
                self.detailView.frame.origin = CGPointMake(-1000, 0)
                self.view.layoutIfNeeded()
        })
    }
    
    func animateInDetail(marker:GMSMarker){
        if(detailView.alpha == 1){
            return
        }
        
        if marker.userData != nil{
        let tile:Tile? = marker.userData as! Tile
//        if(tile != nil){
        self.buildingNameLabel.text = tile!.thaiName// marker.title
        self.buildingNameEngLabel.text = tile!.name// marker.description
        self.facultyNameLabel.text = tile!.thaiName// marker.snippet
        self.detailView!.frame = viewInitialPosition
            self.facultyButtonView.frame = CGRectMake(self.detailView!.frame.origin.x, self.detailView!.frame.origin.y + self.detailView!.frame.size.height, self.detailView!.frame.size.width, self.detailView!.frame.size.height)
            
            self.facultyButtonView.hidden = false
            if(tile!.got == true){
                self.facultyInfoButton.enabled = true
                self.facultyInfoButton.imageView?.image = UIImage(named: "faculty_info_active_button")
            }else{
                self.facultyInfoButton.enabled = false
                self.facultyInfoButton.imageView?.image = UIImage(named: "faculty_info_inactive_button")
            }
        }else{
            self.facultyButtonView.hidden = true
            self.buildingNameLabel.text = marker.title
            self.buildingNameEngLabel.text = marker.description
//            self.facultyNameLabel.text = marker.snippet
        }
        
        self.locationButton.frame.origin = positionButtonInitialPosition
        
        UIView.animateWithDuration(0.3, animations: {
            self.detailView.alpha = 1.0
            self.facultyButtonView.alpha = 1.0
//            self.locationButton.frame.origin = CGPointMake(self.positionButtonInitialPosition.x, self.positionButtonInitialPosition.y - self.detailView.frame.size.height - 30)
            
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
