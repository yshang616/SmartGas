//
//  DetailPageController.swift
//  YellowPageTest
//
//  Created by 商语童 on 2020/10/22.
//

import UIKit
import MapKit
import CoreLocation

class DetailPageController: UIViewController, CLLocationManagerDelegate {
    
//    let targetURL = NSURL(string: "http://maps.apple.com/?q=cupertino")!
    var address = ""
    var stationName = ""
    var latitude = 0.0
    var longitude = 0.0
    var locationManager = CLLocationManager()
    var span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    
    
    @IBOutlet weak var DetailStationName: UILabel!
    @IBOutlet weak var DetailStationAddress: UILabel!
    @IBOutlet weak var MapDisplay: MKMapView!
    
    @IBAction func DirectMapTapped(_ sender: Any) {
//
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        let regionDistance:CLLocationDistance = 1000;
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        
        let regionSpan = MKCoordinateRegion(center: coordinates,latitudinalMeters: regionDistance,longitudinalMeters: regionDistance)
        let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),MKLaunchOptionsMapSpanKey:NSValue(mkCoordinateSpan: regionSpan.span)]
        let placemark = MKPlacemark(coordinate: coordinates)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = stationName
        mapItem.openInMaps(launchOptions: options)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        DetailStationName.text = stationName
        DetailStationAddress.text = address
        
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(address) {
            placemarks, error in
            let placemark = placemarks?.first
            let lat = placemark?.location?.coordinate.latitude
            let lon = placemark?.location?.coordinate.longitude
            if (lat != nil) && (lon != nil){
                self.latitude = lat!
                self.longitude = lon!
            }
            
            let region = MKCoordinateRegion(center: CLLocationCoordinate2DMake(self.latitude,self.longitude), span: self.span)
            self.MapDisplay.setRegion(region, animated: true)
            
        }
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            let locValue:CLLocationCoordinate2D = manager.location!.coordinate
            print("locations = \(locValue.latitude) \(locValue.longitude)")
        }
        // Do any additional setup after loading the view.
    }
    
    
    
//    let address = "1 Infinite Loop, Cupertino, CA 95014"


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


}
