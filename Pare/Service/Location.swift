//
//  Location.swift
//  Pare
//
//  Created by Akhil Maheepathi on 4/15/23.
//

import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate{
    private let locationManager = CLLocationManager()
    private var targetLocation: CLLocation?
    var distanceInMiles: Double? = nil
    
    private var distanceCompletionHandler: ((Double?) -> Void)?

    
    override init(){
        super.init()
        locationManager.delegate = self
        
        requestLocation()
        
        //locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //locationManager.distanceFilter = kCLDistanceFilterNone
        
        calcDistance(latitude: 38.026800, longitude: -78.515980)
    }
    
    func updateLocation(){
        locationManager.startUpdatingLocation()
    }
    
    func requestLocation() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        guard let currentLocation = locations.last else {return}
        
        if let targetLocation = self.targetLocation {
            let distance = currentLocation.distance(from: targetLocation)
            distanceInMiles = distance * 0.000621371
            locationManager.stopUpdatingLocation()
            
            // Call the completion handler if set
            distanceCompletionHandler?(distanceInMiles)
            distanceCompletionHandler = nil
        }

    }
    
    func calcDistance(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        targetLocation = CLLocation(latitude: latitude, longitude: longitude)
    }
    
    func getDistance(completion: @escaping (Double?) -> Void) {
            // Set the completion handler
            distanceCompletionHandler = completion
            
            // Start updating location
            updateLocation()
    }
    
}
