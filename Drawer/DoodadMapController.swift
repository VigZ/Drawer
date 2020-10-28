//
//  DoodadMapController.swift
//  Drawer
//
//  Created by Kyle on 10/27/20.
//

import UIKit
import GoogleMaps

class DoodadMapController: UIViewController, UISearchControllerDelegate {
    
    var locations = [LocationResult]()
    
    @IBOutlet weak var googleMapView: GMSMapView!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var queryString: String = ""
    
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        self.googleMapView = mapView

        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
        

    }
    
    func fetchLocations(_ url: URL){
        URLSession.shared.dataTask(with: url){ [weak self] data, response, error in
            
            if let error = error {
                
            }
            else if let data = data {
//                if let json = try? JSONSerialization.jsonObject(with: data, options: []) {
//                    print(json)
//                }
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
//    filterContentForSearchText(searchBar.text!)
  }
}
