//
//  DoodadMapController.swift
//  Drawer
//
//  Created by Kyle on 10/27/20.
//

import UIKit
import GoogleMaps

class DoodadMapController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        self.view.addSubview(mapView)

        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView

    }
    
    func fetchWithSearchTerm(_ url: URL){
        URLSession.shared.dataTask(with: url){ data, response, error in
            if let error = error {
                
            }
            else if let data = data {
                let decoder = JSONDecoder()
                
                do {
                    let location = try decoder.decode(Location.self, from: data)
                }
                catch {
                    
                }
            }
            
        }.resume()
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
