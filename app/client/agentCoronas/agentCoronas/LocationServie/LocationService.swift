//
//  LocationService.swift
//  agentCoronas
//
//  Created by Artem Stratienko on 30.11.2020.
//

import Foundation
import CoreLocation
import NMAKit

extension SceneMapsController  {
    // MARK 1
    func initLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        //locationManager.startUpdatingLocation()
    }
    // MARK 2
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        guard let lastLocation = locations.last else {
            print("Warning: No last location found")
            return
        }
        tempPositin = lastLocation.coordinate
        
       // viewMap.set(geoCenter: NMAGeoCoordinates(latitude: tempPositin.latitude, longitude: tempPositin.longitude), animation: .linear)
        if viewMap.zoomLevel != 17 {
        //   viewMap.set(zoomLevel: 17, animation: .bow)
        }
        //viewMap.set(zoomLevel: 7, animation: .linear)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(10)) {
        //    self.post(url: "https://droneservice.herokuapp.com/location/", parametrs: ["lon":tempPositin.longitude,"lat":tempPositin.latitude])
        }
        print(lastLocation)
    }
    // MARK 3
    func locationManager(_ manager: CLLocationManager,
                         didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        //if model != nil {
         //   model.yaw = Float(newHeading.magneticHeading)
         //   viewMap.set(orientation: Float(newHeading.magneticHeading), animation: .linear)
        //}
  //      print("magneticHeading \(newHeading.magneticHeading)")
    }
    // MARK 4
    func startLocation() {
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()
    }
    // MARK 5
    func stopLocation() {
        locationManager.stopUpdatingLocation()
    }
}
