//
//  DoodadMapController.swift
//  Drawer
//
//  Created by Kyle on 10/27/20.
//

import UIKit
import GoogleMaps
import CoreLocation

class DoodadMapController: UIViewController, UISearchControllerDelegate, GMSMapViewDelegate, UISearchBarDelegate {
    
    var locations = [LocationResult]() {
        didSet {
            DispatchQueue.main.async {
                self.googleMapView.clear()
                self.createMapMarkers()
            }
        }
    }
    
    @IBOutlet weak var googleMapView: GMSMapView!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
          locationManager.requestLocation()

          googleMapView.isMyLocationEnabled = true
          googleMapView.settings.myLocationButton = true
          googleMapView.delegate = self
            
        } else {
            
          locationManager.requestWhenInUseAuthorization()
        }
        
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        definesPresentationContext = true
        

    }
    
    func fetchLocations(_ url: URL){
        
        URLSession.shared.dataTask(with: url){ [weak self] data, response, error in
            
            if let error = error {
                print(error)
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
    
    func createMapMarkers() {
        
        for resultLocation in locations {
            guard let lat = resultLocation.geometry?.location?.lat, let long = resultLocation.geometry?.location?.lng else { return }
            
            let marker = GMSMarker()
            
            marker.position = CLLocationCoordinate2D(latitude: lat, longitude: long)
            marker.title = resultLocation.name
            marker.snippet = resultLocation.formattedAddress
            marker.appearAnimation = GMSMarkerAnimation.pop
            marker.icon = GMSMarker.markerImage(with: .systemYellow)
            marker.map = googleMapView
            
            var priceString = ""
            if let priceLevel = resultLocation.priceLevel {
                for n in 0...4 {
                    if n < priceLevel {
                        priceString += "$"
                    }
                    else {
                        priceString += "O"
                    }
                }
            }
            marker.snippet! += " \(priceString)"
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchTerm = searchBar.text else {
            locations = []
            return
        }
        
        let apiURL = createApiURL(queryString: searchTerm)
        fetchLocations(apiURL)
    }
    
    func createApiURL(queryString: String) -> URL{
        let newString = queryString.replacingOccurrences(of: " ", with: "+")
        let apiString = "https://maps.googleapis.com/maps/api/place/textsearch/json?query=\(newString)&key=AIzaSyBe9D5zAvMOxnqYwZygvLZ1USCG--IDjvU"
        
        return URL(string: apiString)!
        
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

//extension DoodadMapController: UISearchResultsUpdating {
//  func updateSearchResults(for searchController: UISearchController) {
//
//    let searchBar = searchController.searchBar
//    createMapMarkers()
//  }
//}

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
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: 15)
        googleMapView.camera = camera
        createMapMarkers()

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
