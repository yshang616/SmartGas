//
//  LocationService.swift
//  SmartGas
//
//  Created by 商语童 on 2020/9/28.
//

import Foundation
import CoreLocation

enum Result<T> {
    case success(T)
    case failure(Error)
}

final class LocationService: NSObject{
    private let manager: CLLocationManager
    
    init(manager: CLLocationManager = .init()) {
        self.manager = manager
        super.init()
        manager.delegate = self
    }
    
    var newLocation: ((Result<CLLocation>)->Void)?
    var didChangeStatus: ((Bool)->Void)?
    
    var status: CLAuthorizationStatus{
        return CLLocationManager.authorizationStatus()
    }
    
//    Require an authorization to get user current location
    func requestLocationAuthorization(){
        manager.requestWhenInUseAuthorization()
    }
    
    func getLocation(){
        manager.requestLocation()
    }
    
    
}

extension LocationService: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        newLocation?(.failure(error))
    }
    
//    Returns the user's location after request of authorization successful:
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.sorted(by:{$0.timestamp>$1.timestamp}).first{
            newLocation?(.success(location))
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            switch status {
            case .notDetermined, .restricted, .denied:
                didChangeStatus?(false)
            default:
                didChangeStatus?(true)
            }
                
    }
}
