//
//  MapViewController.swift
//  ParkALot
//
//  Created by Umut Öztunç on 16.12.2021.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var map: MKMapView!
    
    var parkingLot : ParkingLot?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = "Location"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let parkingLot = self.parkingLot {
            let coordinate = CLLocationCoordinate2D(latitude: Double(parkingLot.lat)!, longitude: Double(parkingLot.lng)!)
            let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 2000, longitudinalMeters: 2000)
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = parkingLot.parkName
            self.map.setRegion(region, animated: true)
            self.map.addAnnotation(annotation)
        }
        
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
