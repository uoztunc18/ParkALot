//
//  ParkingLotListViewController.swift
//  ParkALot
//
//  Created by Umut Öztunç on 16.12.2021.
//

import UIKit

class ParkingLotListViewController: UIViewController {
    
    @IBOutlet weak var parkingLotCollection: UICollectionView!
    
    var dataSource = DataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let selectedDistrict = self.dataSource.selectedDistrict {
            self.title = "Parking Lots In \(selectedDistrict)"
        } else {
            self.title = "Parking Lots"
        }
        self.dataSource.delegate = self
        self.dataSource.loadParkingLots()
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! ParkingLotCollectionViewCell
        if let indexPath = self.parkingLotCollection.indexPath(for: cell) {
            let parkingLot = self.dataSource.getParkingLotWithIndex(index : indexPath.row)
            let parkingLotListViewController = segue.destination as! ParkingLotDetailViewController
            parkingLotListViewController.dataSource.parkingLot = parkingLot
        }
    }

}

extension ParkingLotListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let selectedDistrict = self.dataSource.selectedDistrict {
            let x = self.dataSource.getNumberOfParkingLotsInTheDistrict(selectedDistrict: selectedDistrict)
            return x
        }
        return dataSource.getNumberOfParkingLots()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ParkingLotCell", for: indexPath) as! ParkingLotCollectionViewCell
        if let selectedDistrict = self.dataSource.selectedDistrict {
            self.dataSource.setListOfParkingLotsInTheDistrict(selectedDistrict: selectedDistrict)
        }
        
        let parkingLot = self.dataSource.parkingLotList[indexPath.row]

        cell.parkName.text = parkingLot.parkName
        cell.districtName.text = parkingLot.getDistrict()
        cell.freeLotNumber.text = "\(parkingLot.emptyCapacity)"

        if parkingLot.isOpen != 1 {
            cell.status.text = "Closed"
            cell.backgroundColor = UIColor.lightGray
        } else if parkingLot.isOpenNow() == false {
            let workTimes = parkingLot.convertToTime(str: parkingLot.workHours, calendar: Calendar.current)
            cell.status.text = "Opens at \(String(format: "%02d", workTimes.0.hour!)):\(String(format: "%02d", workTimes.0.minute!))"
            cell.backgroundColor = UIColor.systemPink
        } else if parkingLot.emptyCapacity == 0 {
            cell.status.text = "Full!"
            cell.backgroundColor = UIColor.systemOrange
        } else {
            cell.status.text = "Open!"
            cell.backgroundColor = UIColor.systemGreen
        }

        cell.layer.cornerRadius = 10
        let shadowPath2 = UIBezierPath(rect: cell.bounds)
        cell.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: CGFloat(1.0), height: CGFloat(3.0))
        cell.layer.shadowOpacity = 0.5
        cell.layer.shadowPath = shadowPath2.cgPath

        return cell
    }
    
    
}

extension ParkingLotListViewController : DataSourceProtocol {
    func loadData() {
        self.parkingLotCollection.reloadData()
    }
    
    func loadDistricts() {
        
    }
}
