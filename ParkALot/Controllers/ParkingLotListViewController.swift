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
    var selectedDistrict : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Parking Lots"
        if let selectedDistrict = selectedDistrict {
            self.title = "Parking Lots In \(selectedDistrict)"
        }
        //LAG TEMP SOLUTION
//        dataSource.loadParkingLots()
//        sleep(10)
//        dataSource.loadDistricts()
        //LAG TEMP SOLUTION
    }
    
//    override func viewDidDisappear(_ animated: Bool) {
//        self.selectedDistrict = nil
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let button = sender as! UIButton
        let parkingLot = self.dataSource.getParkingLotWithIndex(index: button.tag)
        let parkingLotListViewController = segue.destination as! ParkingLotDetailViewController
        parkingLotListViewController.parkingLot = parkingLot
    }

}

extension ParkingLotListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let selectedDistrict = self.selectedDistrict {
            return self.dataSource.getNumberOfParkingLotInTheDistrict(district: selectedDistrict)
        }
        return dataSource.getNumberOfParkingLots()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ParkingLotCell", for: indexPath) as! ParkingLotCollectionViewCell
        
        if let selectedDistrict = self.selectedDistrict {
            self.dataSource.getListOfParkingLotsINTheDistrict(district: selectedDistrict)
            
            let parkingLot = self.dataSource.parkingLotList[indexPath.row]
            
            cell.parkName.text = parkingLot.parkName
            cell.districtName.text = parkingLot.district
            cell.freeLotNumber.text = "\(parkingLot.emptyCapacity)"
            cell.status.text = "\(parkingLot.isOpen)"
    
            cell.detailButton.tag = indexPath.row
            if parkingLot.isOpen != 1 {
                cell.detailButton.isEnabled = false
            }
            
        } else {
            let parkingLot = self.dataSource.parkingLotList[indexPath.row]
            
            cell.parkName.text = parkingLot.parkName
            cell.districtName.text = parkingLot.district
            cell.freeLotNumber.text = "\(parkingLot.emptyCapacity)"
            cell.status.text = "\(parkingLot.isOpen)"
            
            cell.detailButton.setTitle("Detail", for: .normal)
            cell.detailButton.tag = indexPath.row
            if parkingLot.isOpen != 1 {
                cell.detailButton.isEnabled = false
            }
        }
        
        return cell
    }
    
    
}
