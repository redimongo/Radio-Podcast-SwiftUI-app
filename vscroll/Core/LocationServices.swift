//
//  LocationManager.swift
//  CoreLocationDemo
//
//  Created by Sheikh Bayazid on 7/18/20.
//  Copyright © 2020 Sheikh Bayazid. All rights reserved.
//
import Foundation
import CoreLocation
import Combine

class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    private let manager: CLLocationManager
    static var LMlat = 0.0
    static var LMlong = 0.0
    @Published var lastKnownLocation: CLLocation?

    
//    var getLat: String {
//        return "\(lastKnownLocation?.coordinate.latitude)"
//    }
//    var getLon: String {
//        return "\(lastKnownLocation?.coordinate.longitude)"
//    }
    
    
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .denied{
            print("denied")
        }
        else{
            print("athorized")
            manager.requestLocation()
        }
    }
    
    func start() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    init(manager: CLLocationManager = CLLocationManager()) {
        self.manager = manager
        super.init()
    }
    

    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    
    func startUpdating() {
        self.manager.delegate = self
        self.manager.requestWhenInUseAuthorization()
        self.manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        lastKnownLocation = locations.last
       // print(lastKnownLocation!.coordinate.latitude)
        
        if(lastKnownLocation!.coordinate.latitude != LocationManager.LMlat && lastKnownLocation!.coordinate.longitude != LocationManager.LMlong)
        {
            LocationManager.LMlat = lastKnownLocation!.coordinate.latitude
            LocationManager.LMlong = lastKnownLocation!.coordinate.longitude
            
            updateServerLocation(latitude: LocationManager.LMlat, longitude:  LocationManager.LMlong)
        }
        
        /* Maybe Use in Future Version
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: lastKnownLocation!.coordinate.latitude, longitude: lastKnownLocation!.coordinate.longitude)
        geoCoder.reverseGeocodeLocation(location, completionHandler:
            {
                placemarks, error -> Void in

                // Place details
                guard let placeMark = placemarks?.first else { return }

                // Location name
                if let locationName = placeMark.location {
                    print(locationName)
                }
                // Street address
                if let street = placeMark.thoroughfare {
                    print(street)
                }
                // City
                if let city = placeMark.subAdministrativeArea {
                    print(city)
                }
                // Zip code
                if let zip = placeMark.isoCountryCode {
                    print(zip)
                }
                // Country
                if let country = placeMark.country {
                    print(country)
                }
                
        })
        */
        
        
        //showLocation()
    }
    
    func updateServerLocation(latitude:Double,longitude:Double)
    {
        let locationurl = URL(string: "https://api.drn1.com.au:9000/listener?uuid=\(MusicPlayer.uuid ?? "")&lat=\(latitude)&long=\(longitude)")!
          
         print("location: \(MusicPlayer.uuid ?? "") lat: \(latitude), long: \(longitude)")
              
          URLSession.shared.dataTask(with: locationurl) { (data, res, err) in

         // guard let data = data else { return }
          }
    }
    

//    func showLocation(){
//        print("From showLocation method")
//        print("Latitude: \(getLat)")
//        print("Longitude: \(getLon)")
//    }
    
    
}

