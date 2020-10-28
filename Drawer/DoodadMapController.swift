//
//  DoodadMapController.swift
//  Drawer
//
//  Created by Kyle on 10/27/20.
//

import UIKit
import GoogleMaps
import CoreLocation

class DoodadMapController: UIViewController, UISearchControllerDelegate {
    
    var locations = [LocationResult]()
    
    @IBOutlet weak var googleMapView: GMSMapView!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var queryString: String = ""
    
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.requestLocation()
        
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        
        if let location = locationManager.location {
            setUpMap(location: location)
        }
        

        

    }
    
    func fetchLocations(_ url: URL){
        URLSession.shared.dataTask(with: url){ [weak self] data, response, error in
            
            if let error = error {
                
            }
            else if let data = data {
                let decoder = JSONDecoder()
                let response = try? decoder.decode(LocationResponse.self, from: data)
                guard let results = response?.results else {
                    return
                }
                if let self = self {
                    self.locations = results
                }
                
            }
            
        }.resume()
    }
    
    func createApiURL(queryString: String) -> URL{
        let apiString = "https://maps.googleapis.com/maps/api/place/textsearch/json?query=\(queryString)&key=AIzaSyBe9D5zAvMOxnqYwZygvLZ1USCG--IDjvU"
        return URL(string: apiString)!
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchLocations(createApiURL(queryString: queryString))
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DoodadMapController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    
    let searchBar = searchController.searchBar
//   update map markers
  }
}

extension DoodadMapController : CLLocationManagerDelegate {
    // called when the authorization status is changed for the core location permission
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager){
        
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // .requestLocation will only pass one location to the locations array
        // hence we can access it by taking the first element of the array
        
        if let location = locations.first {
            
            // Setup Map Marker with location coordinates
            setUpMap(location: location)
            

        }
    }
    
    func setUpMap(location: CLLocation){
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        self.googleMapView = mapView

        // Creates a marker for each nearby store
//        let marker = GMSMarker()
//        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
//        marker.title = "Sydney"
//        marker.snippet = "Australia"
//        marker.map = mapView
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            
            if let location = manager.location {
                setUpMap(location: location)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
