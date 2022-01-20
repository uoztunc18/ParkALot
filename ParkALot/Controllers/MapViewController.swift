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
    
    var dataSource = DataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Location"
        
        self.dataSource.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let parkingLot = self.dataSource.parkingLot {
            let coordinate = CLLocationCoordinate2D(latitude: Double(parkingLot.lat)!, longitude: Double(parkingLot.lng)!)
            annotate(parkingLot: parkingLot, coordinate : coordinate)
            let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 2000, longitudinalMeters: 2000)
            self.map.setRegion(region, animated: true)
        } else {
            self.dataSource.loadParkingLots()
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
    
    func annotate(parkingLot : ParkingLot, coordinate : CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = parkingLot.parkName
        self.map.addAnnotation(annotation)
    }
}

extension MapViewController : DataSourceProtocol {
    func loadData() {
        self.dataSource.parkingLotList.forEach { parkingLot in
            let coordinate = CLLocationCoordinate2D(latitude: Double(parkingLot.lat)!, longitude: Double(parkingLot.lng)!)
            annotate(parkingLot: parkingLot, coordinate: coordinate)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 41, longitude: 29), latitudinalMeters: 40000, longitudinalMeters: 40000)
            self.map.setRegion(region, animated: true)
        }
    }
    
    func loadDistricts() {
        
    }
}
