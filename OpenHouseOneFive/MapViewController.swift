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
    func mapControllerDidAppear(controller: MapViewController)
}

class MapViewController: UIViewController,GMSMapViewDelegate,CLLocationManagerDelegate,HighlightViewDelegate {
    
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
    
    var selectingTile:Tile!
    
    var landMarkArray = [GMSMarker]()
    var stationArray = [GMSMarker]()
    var facultyArray = [GMSMarker]()
    var infomationkArray = [GMSMarker]()
    var aStationArray = [GMSMarker]()
    var bStationArray = [GMSMarker]()
    var cStationArray = [GMSMarker]()
    var facultyAreaArray = [GMSPolygon]()
    
    var aRoute:GMSPolyline?
    var bRoute:GMSPolyline?
    var cRoute:GMSPolyline?
    
    var viewInitialPosition:CGRect!
    
    var positionButtonInitialPosition:CGPoint!
    
    @IBOutlet var pinInfo: UIImageView!
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
    
    @IBOutlet weak var lowButtonView: UIView!
    @IBOutlet weak var topButtonView: UIView!
    var bingoBoard:Bingo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(self.view.frame.size.width<=320){
//            self.topButtonView.layer.anchorPoint = CGPointMake(0.5, 0.0)
            self.topButtonView.transform = CGAffineTransformMakeScale(0.85, 0.85);
            self.lowButtonView.layer.anchorPoint = CGPointMake(0.5, 0.7)
            self.topButtonView.layer.borderWidth = 1.0
            self.topButtonView.layer.borderColor = UIColor.lightGrayColor().CGColor
            self.lowButtonView.transform = CGAffineTransformMakeScale(0.85, 0.85);
            self.facultyButtonView.layer.anchorPoint = CGPointMake(0.5, 0.7)
            self.facultyButtonView.transform = CGAffineTransformMakeScale(0.85, 0.85);
//            self.detailView.layer.anchorPoint = CGPointMake(0.5, 0.0)
            self.detailView.transform = CGAffineTransformMakeScale(0.85, 0.85);
        }
        
        bingoBoard = Bingo(random: true)
        
        var camera = GMSCameraPosition.cameraWithLatitude(13.7406223,
            longitude: 100.5307583, zoom: 15)
        mapView.camera = camera
        mapView.myLocationEnabled = true
        mapView.settings.myLocationButton = false
        mapView.delegate = self
        mapView.indoorEnabled = false
        
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
        facultyButtonView.layer.borderColor = UIColor.lightGrayColor().CGColor
        
        detailView.clipsToBounds = true
        
        positionButtonInitialPosition = CGPointMake(self.view.frame.size.width - locationButton.frame.size.width - 20,self.view.frame.size.height - locationButton.frame.size.width - 65)
        self.view.layoutIfNeeded()
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        delegate?.mapControllerDidAppear(self)
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
        var jsonFacObj:JSON!
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
        
        if let path = NSBundle.mainBundle().pathForResource("OpenHouseFacultyAreaDetail", ofType: "json"){
            do {
                let data = try NSData(contentsOfURL: NSURL(fileURLWithPath: path), options: NSDataReadingOptions.DataReadingMappedIfSafe)
                jsonFacObj = JSON(data: data)
                if jsonFacObj != JSON.null {
                    print("jsonData:\(jsonFacObj)")
                } else {
                    print("invalid JSON file")
                }
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        } else {
            print("Invaild filename/path!")
        }
        
        //If json is .Array
        //The `index` is 0..<json.count's string value
        for (index,subJson):(String, JSON) in jsonFacObj["faculty"] {
            //Do something you want
            var marker = GMSMarker()
            let center = subJson["centerPoint"] as! JSON
            marker.position = CLLocationCoordinate2DMake(center["lat"].doubleValue,center["lng"].doubleValue)
            marker.title = subJson["name"].stringValue
            marker.snippet = "Faculty"
            
            let pinFac = subJson["faculty_id"].stringValue
            let imageName = UIImage(named: "pin_\(pinFac)")
            
            //let image = RBResizeImage(imageName!, targetSize: CGSizeMake(24.25,34))
            
            marker.icon = imageName//UIImage(named: "pin_\(subJson["faculty_id"].stringValue)")
            
            marker.userData = bingoBoard.tileWithID(subJson["faculty_id"].stringValue)
            
            if let poly:JSON? = subJson["pathway"] {
                // Create a rectangular path
                var rect = GMSMutablePath()
                for (index,subJson):(String, JSON) in poly! {
                    
                rect.addCoordinate(CLLocationCoordinate2DMake(subJson["lat"].doubleValue,subJson["lng"].doubleValue));
                
            }
                
                // Create the polygon, and assign it to the map.
                var polygon = GMSPolygon(path: rect)
                let fac_id = subJson["faculty_id"].intValue
    
            switch fac_id {
                case 21:
                    polygon.fillColor = UIColor(red:155/255.0 , green:0/255.0, blue:0/255.0, alpha:0.5);
                case 22:
                    polygon.fillColor = UIColor(red:132/255.0 , green:130/255.0, blue:133/255.0, alpha:0.5);
                case 23:
                    polygon.fillColor = UIColor(red:255/255.0 , green:199/255.0, blue:21/255.0, alpha:0.5);
                case 24:
                    polygon.fillColor = UIColor(red:0/255.0 , green:0/255.0, blue:0/255.0, alpha:0.5);
                case 25:
                    polygon.fillColor = UIColor(red:108/255.0 , green:69/255.0, blue:30/255.0, alpha:0.5);
                case 26:
                    polygon.fillColor = UIColor(red:112/255.0 , green:144/255.0, blue:200/255.0, alpha:0.5);
                case 27:
                    polygon.fillColor = UIColor(red:242/255.0 , green:101/255.0, blue:34/255.0, alpha:0.5);
                case 28:
                    polygon.fillColor = UIColor(red:34/255.0 , green:35/255.0, blue:111/255.0, alpha:0.5);
                case 29:
                    polygon.fillColor = UIColor(red:204/255.0 , green:174/255.0, blue:93/255.0, alpha:0.5);
                case 30:
                    polygon.fillColor = UIColor(red:0/255.0 , green:102/255.0, blue:0/255.0, alpha:0.5);
                case 31:
                    polygon.fillColor = UIColor(red:51/255.0 , green:153/255.0, blue:204/255.0, alpha:0.5);
                case 32:
                    polygon.fillColor = UIColor(red:124/255.0 , green:78/255.0, blue:150/255.0, alpha:0.5);
                case 33:
                    polygon.fillColor = UIColor(red:96/255.0 , green:100/255.0, blue:39/255.0, alpha:0.5);
                case 34:
                    polygon.fillColor = UIColor(red:255/255.0 , green:255/255.0, blue:255/255.0, alpha:0.7);
                case 35:
                    polygon.fillColor = UIColor(red:142/255.0 , green:4/255.0, blue:1/255.0, alpha:0.5);
                case 37:
                    polygon.fillColor = UIColor(red:72/255.0 , green:49/255.0, blue:136/255.0, alpha:0.5);
                case 38:
                    polygon.fillColor = UIColor(red:72/255.0 , green:49/255.0, blue:136/255.0, alpha:0.5);
                case 39:
                    polygon.fillColor = UIColor(red:255/255.0 , green:165/255.0, blue:0/255.0, alpha:0.5);
                case 40:
                    polygon.fillColor = UIColor(red:153/255.0 , green:28/255.0, blue:26/255.0, alpha:0.5);
                
                default:
                    
                    polygon.fillColor = UIColor(red:251/255.0 , green:90/255.0, blue:134/255.0, alpha:0.5);
                }
                
                //        polygon.strokeColor = UIColor.blackColor()
                polygon.strokeWidth = 0
                polygon.map = self.mapView
                self.facultyAreaArray.append(polygon)
            }
            
           
            
            facultyArray.append(marker)
        }
        
        for (index,subJson):(String, JSON) in jsonFacObj["landmark"] {
            //Do something you want
            var marker = GMSMarker()
            marker.position = CLLocationCoordinate2DMake(subJson["lat"].doubleValue,subJson["lng"].doubleValue)
            marker.title = subJson["name"].stringValue
            marker.snippet = " "
            
            let imageName = UIImage(named: "pin_landmark")
            //let image = RBResizeImage(imageName!, targetSize: CGSizeMake(24.25,34))
            
            marker.icon = imageName
            
            
            landMarkArray.append(marker)
        }
        
        
        for (index,subJson):(String, JSON) in jsonFacObj["station"] {
            //Do something you want
            var marker = GMSMarker()
            marker.position = CLLocationCoordinate2DMake(subJson["lat"].doubleValue,subJson["lng"].doubleValue)
            marker.title = subJson["name"].stringValue
            marker.snippet = " "
            
            let imageName = UIImage(named: "pin_cutour")
            //let image = RBResizeImage(imageName!, targetSize: CGSizeMake(24.25,34))
            
            marker.icon = imageName
            
            
            stationArray.append(marker)
        }
        
        for (index,subJson):(String, JSON) in jsonFacObj["information"] {
            //Do something you want
            var marker = GMSMarker()
            marker.position = CLLocationCoordinate2DMake(subJson["lat"].doubleValue,subJson["lng"].doubleValue)
            marker.title = subJson["name"].stringValue
            marker.snippet = " "
            
            let imageName = UIImage(named: "pin_information")
            //let image = RBResizeImage(imageName!, targetSize: CGSizeMake(24.25,34))
            
            marker.icon = imageName
            
            
            infomationkArray.append(marker)
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
            if let image = UIImage(named: "landmark_button_inactive.png") {
                landmarkButton.setImage(image, forState: .Normal)
            }
        }else{
            if let image = UIImage(named: "landmark_button_active.png") {
                landmarkButton.setImage(image, forState: .Normal)
            }
        }
    }
    func toggleFacButton(){
        facOn = !facOn
        toggleArray(facultyArray, on: facOn)
        toggleAreaArray(facultyAreaArray, on: facOn)
        if(facOn == false){
            if let image = UIImage(named: "faculty_button_inactive.png") {
                facultyButton.setImage(image, forState: .Normal)
            }
        }else{
            if let image = UIImage(named: "faculty_button_active.png") {
                facultyButton.setImage(image, forState: .Normal)
            }
        }
    }
    func toggleInfoButton(){
        infoOn = !infoOn
        toggleArray(infomationkArray, on: infoOn)
        if(infoOn == false){
            if let image = UIImage(named: "information_button_inactive.png") {
                inforButton.setImage(image, forState: .Normal)
            }
        }else{
            if let image = UIImage(named: "information_button_active.png") {
                inforButton.setImage(image, forState: .Normal)
            }
        }
    }
    func toggleStationButton(){
        stationOn = !stationOn
        toggleArray(stationArray, on: stationOn)
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
    
    func toggleAreaArray(array:[GMSPolygon],on:Bool){
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
        
        if marker.userData != nil{
        let tile:Tile? = marker.userData as! Tile
//        if(tile != nil){
            selectingTile = tile
            self.buildingNameLabel.text = tile!.thaiName // marker.title
        self.buildingNameEngLabel.text = tile!.name // marker.description
            print("\(tile!.id)")
            if tile!.id >= 21 && tile!.id <= 40  {
                self.pinInfo.image = UIImage(named: "pin_\(tile!.id).jpg")
            } else {
                self.pinInfo.image = UIImage(named: "pin-info-icon.png")
            }
//        self.facultyNameLabel.text = tile!.thaiName // marker.snippet
        self.detailView!.frame = viewInitialPosition
            self.facultyButtonView.frame = CGRectMake(self.detailView!.frame.origin.x, self.detailView!.frame.origin.y + self.detailView!.frame.size.height, self.detailView!.frame.size.width, self.detailView!.frame.size.height)
            
            self.facultyButtonView.hidden = false
            if(tile!.got == true){
                self.facultyInfoButton.enabled = true
                self.facultyInfoButton.imageView?.image = UIImage(named: "faculty-info-active-button")
            }else{
                self.facultyInfoButton.enabled = false
                self.facultyInfoButton.imageView?.image = UIImage(named: "faculty-info-inactive-button")
            }
        }else{
            self.facultyButtonView.hidden = true
            self.buildingNameLabel.text = marker.title
            self.buildingNameEngLabel.text = marker.snippet
            self.pinInfo.image = UIImage(named: "pin-info-icon")
            if(marker.title == "จุดปฏิคม (Information)") {
                self.pinInfo.image = UIImage(named: "pin_information")
            } else if (marker.title == "CU Tour") {
                self.pinInfo.image = UIImage(named: "pin_cutour")
            } else {
                self.pinInfo.image = UIImage(named:"pin_landmark")
            }
//            self.facultyNameLabel.text = marker.snippet
        }
        
        if(detailView.alpha == 1){
            return
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
        if(selectingTile != nil){
            delegate?.mapControllerDidTabWeb("\(selectingTile!.id)", controller: self)
        }
    }
    @IBAction func facultyHighlightPress(sender: AnyObject) {
        if(selectingTile != nil){
            
            let hlJsonParser = HighLightJsonParser()
            let arrayMain = hlJsonParser.serializeJSON()
            for array in arrayMain{
                if array[2] == "\(selectingTile!.id)"{
                self.performSegueWithIdentifier("hightlight_m", sender: array)
                }
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "hightlight_m"){
            let hDVC = segue.destinationViewController as! HighlightDetail
            hDVC.delegate = self
            hDVC.arrDetail = sender as! [String]
        }
    }
    
    func highlightViewClose(controller: HighlightDetail!) {
        self.dismissViewControllerAnimated(true) { () -> Void in
            
        }
    }
}
