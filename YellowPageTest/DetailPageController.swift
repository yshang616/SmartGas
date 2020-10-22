//
//  DetailPageController.swift
//
//  A ViewController responsible for the detail page that is shown after the
//  user selects a station in the search result list.
//

import UIKit
import MapKit
import CoreLocation

class DetailPageController: UIViewController, CLLocationManagerDelegate {
    
//  Variables for this class
    var address = ""
    var stationName = ""
    var latitude = 0.0
    var longitude = 0.0
    var locationManager = CLLocationManager()
    var span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    
//  Links to the UI elements on the detail page:
//  the station name label, the address label, and the map image
    @IBOutlet weak var DetailStationName: UILabel!
    @IBOutlet weak var DetailStationAddress: UILabel!
    @IBOutlet weak var MapDisplay: MKMapView!
    
    @IBAction func DirectMapTapped(_ sender: Any) {
//  DirectMapTapped is performed after the map directing button is tapped.
//  It requests user's authorization first, and then send user's and gas station's
//  location to the Apple Map application and opens it.
        
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
//  Sets the center and size of the region displayed in Apple Map.
        let regionDistance:CLLocationDistance = 1000;
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        
//  Setting the Apple Map with user and gas station coordinates.
        let regionSpan = MKCoordinateRegion(center: coordinates,latitudinalMeters: regionDistance,longitudinalMeters: regionDistance)
        let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),MKLaunchOptionsMapSpanKey:NSValue(mkCoordinateSpan: regionSpan.span)]
        let placemark = MKPlacemark(coordinate: coordinates)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = stationName
        mapItem.openInMaps(launchOptions: options)
    }
    

    override func viewDidLoad() {
//  viewDidLoad runs when the page is shown.
        super.viewDidLoad()
        
//  set the station name and address labels.
        DetailStationName.text = stationName
        DetailStationAddress.text = address
        
//  set the delegate of the location manager.
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
//  create a geoCoder object
        let geoCoder = CLGeocoder()

//  converts the address (string) into latitude and longitude format with geoCoder
        geoCoder.geocodeAddressString(address) {
            placemarks, error in
            let placemark = placemarks?.first
            let lat = placemark?.location?.coordinate.latitude
            let lon = placemark?.location?.coordinate.longitude
            if (lat != nil) && (lon != nil){
                self.latitude = lat!
                self.longitude = lon!}
            
            let region = MKCoordinateRegion(center: CLLocationCoordinate2DMake(self.latitude,self.longitude), span: self.span)
            let stationPointer = MKPointAnnotation()
            stationPointer.title = self.stationName
            self.MapDisplay.setRegion(region, animated: true)
            stationPointer.coordinate=CLLocationCoordinate2DMake(self.latitude,self.longitude)
            self.MapDisplay.addAnnotation(stationPointer)
            
        }
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        }
    }



}
