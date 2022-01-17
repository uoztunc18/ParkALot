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
    @IBOutlet weak var isOpenLabel: UILabel!
    
    
    var parkingLot : ParkingLot?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Details"
        
        print(parkingLot!)
        
        let parkName = self.parkingLot?.parkName
        let district = self.parkingLot?.district
        let capacity = self.parkingLot?.capacity
        let emptyCapacity = self.parkingLot?.emptyCapacity
        let workHours = self.parkingLot?.workHours
        let isOpen = self.parkingLot?.isOpen
        self.nameLabel.text = String(parkName!)
        self.districtLabel.text = String(district!)
        self.capacityLabel.text = String(capacity!)
        self.emptyCapacityLabel.text = String(emptyCapacity!)
        self.workingHoursLabel.text = String(workHours!)
        self.isOpenLabel.text = String(isOpen!)
        
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
            mapViewController.parkingLot = self.parkingLot
        }
    }
}
