//
//  HomePageViewController.swift
//  ParkALot
//
//  Created by Umut Öztunç on 16.12.2021.
//

import UIKit

class HomePageViewController: UIViewController {
    
    //Lag temp solution
    @IBOutlet weak var districtListButton: UIButton!
    @IBOutlet weak var parkingLotListButton: UIButton!
    var dataSource = DataSource()
    //

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Home Page"
        
        //Lag temp solution
        
        let userDefaults = UserDefaults.standard
        if let cachedData = userDefaults.data(forKey: "CachedData") {
            let decoder = JSONDecoder()
            let parkingLotListLoading = try! decoder.decode([ParkingLot].self, from: cachedData)
            self.dataSource.parkingLotList = parkingLotListLoading
        } else {
            dataSource.loadParkingLots()
            sleep(10)
        }
        dataSource.loadDistricts()
        print(dataSource.parkingLotList.count)
        print(dataSource.districtList.count)
        print(dataSource.districtList)
        
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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.2
        
        //LAG TEMP SOLUTION
        let button = sender as! UIButton
        if button.tag == 0 {
            let districtListViewController = segue.destination as! DistrictListViewController
            districtListViewController.dataSource = self.dataSource.copy()
        } else if button.tag == 1 {
            let parkingLotListViewController = segue.destination as! ParkingLotListViewController
            parkingLotListViewController.dataSource = self.dataSource.copy()
        }
        //LAG TEMP SOLUTION
    }


}
