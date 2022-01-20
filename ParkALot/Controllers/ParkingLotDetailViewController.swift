//
//  ParkingLotDetailViewController.swift
//  ParkALot
//
//  Created by Umut Öztunç on 16.12.2021.
//

import UIKit

class ParkingLotDetailViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var districtLabel: UILabel!
    @IBOutlet weak var capacityLabel: UILabel!
    @IBOutlet weak var emptyCapacityLabel: UILabel!
    @IBOutlet weak var workingHoursLabel: UILabel!
    @IBOutlet weak var isOpenButton: UIButton!
    
    var dataSource = DataSource()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Details"
        
        print(dataSource.parkingLot!)
        
        let parkName = self.dataSource.parkingLot?.parkName
        let district = self.dataSource.parkingLot?.getDistrict()
        let capacity = self.dataSource.parkingLot?.capacity
        let emptyCapacity = self.dataSource.parkingLot?.emptyCapacity
        let workHours = self.dataSource.parkingLot?.workHours
        if self.dataSource.parkingLot?.isOpen != 1 {
            self.isOpenButton.setTitle("Closed!", for: .normal)
            self.isOpenButton.backgroundColor = UIColor.lightGray
        } else if self.dataSource.parkingLot?.isOpenNow() == false {
            let workTimes = self.dataSource.parkingLot?.convertToTime(str: self.dataSource.parkingLot!.workHours, calendar: Calendar.current)
            self.isOpenButton.setTitle("Opens at \(String(format: "%02d", workTimes!.0.hour!)):\(String(format: "%02d", workTimes!.0.minute!))", for: .normal)
            self.isOpenButton.backgroundColor = UIColor.systemPink
        } else if self.dataSource.parkingLot?.emptyCapacity == 0 {
            self.isOpenButton.setTitle("Full!", for: .normal)
            self.isOpenButton.backgroundColor = UIColor.systemOrange
        } else {
            self.isOpenButton.setTitle("Open!", for: .normal)
            self.isOpenButton.backgroundColor = UIColor.systemGreen
        }
        self.nameLabel.text = String(parkName!)
        self.districtLabel.text = String(district!)
        self.capacityLabel.text = "Capacity: \(String(capacity!))"
        self.emptyCapacityLabel.text = "Empty: \(String(emptyCapacity!))"
        if workHours == "24 Saat" {
            self.workingHoursLabel.text = "7/24"
        } else {
            self.workingHoursLabel.text = String(workHours!)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let button = sender as! UIButton
        if button.tag == 0 {
            let mapViewController = segue.destination as! MapViewController
            mapViewController.dataSource.parkingLot = self.dataSource.parkingLot
        }
    }
    
    @IBAction func reviewTapped(_ sender: UIButton) {
            
        let ReviewViewController = self.storyboard?.instantiateViewController(withIdentifier: "ReviewViewController") as! ReviewViewController
        self.navigationController?.pushViewController(ReviewViewController, animated: false)
        ReviewViewController.parkingLotName = self.dataSource.parkingLot?.parkName
    }
}
