//
//  DistrictListViewController.swift
//  ParkALot
//
//  Created by Umut Öztunç on 16.12.2021.
//

import UIKit

class DistrictListViewController: UIViewController {

    @IBOutlet weak var districtTable: UITableView!
    
    var dataSource = DataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = "Districts"
        //LAG TEMP SOLUTION
//        dataSource.loadParkingLots()
//        sleep(10)
//        dataSource.loadDistricts()
//        print(dataSource.parkingLotList.count)
//        print(dataSource.districtList.count)
//        print(dataSource.districtList)
        //LAG TEMP SOLUTION
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
        let cell = sender as! DistrictTableViewCell
        if let indexPath = self.districtTable.indexPath(for: cell) {
            let selectedDistrict = self.dataSource.districtList[indexPath.row]
            let parkingLotListViewController = segue.destination as! ParkingLotListViewController
//            parkingLotListViewController.dataSource = self.dataSource @@@@@
            //LAG TEMP SOLUTION
            parkingLotListViewController.dataSource = self.dataSource.copy()
            parkingLotListViewController.selectedDistrict = selectedDistrict
            //LAG TEMP SOLUTION
        }
    }

}

extension DistrictListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.getNumberOfDistricts()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DistrictCell", for: indexPath) as! DistrictTableViewCell
        let district = dataSource.getDistrictWithIndex(index: indexPath.row.quotientAndRemainder(dividingBy: dataSource.getNumberOfDistricts()).remainder)
        
        cell.districtLabel.text = district
        
        return cell
    }
}
