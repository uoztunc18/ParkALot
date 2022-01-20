//
//  DataSource.swift
//  ParkALot
//
//  Created by Umut Öztunç on 16.12.2021.
//

import Foundation

class DataSource {
    var parkingLotList : [ParkingLot] = []
    var districtList : [String] = []
    var parkingLot : ParkingLot?
    var selectedDistrict : String?
    
    var delegate : DataSourceProtocol?
    
    let baseUrl = "https://api.ibb.gov.tr/ispark/Park"
    
    init() {
    }
    
    func getNumberOfParkingLots() -> Int {
        return parkingLotList.count
    }
    
    func getNumberOfDistricts() -> Int {
        return districtList.count
    }
    
    func getNumberOfParkingLotsInTheDistrict(selectedDistrict : String) -> Int {
        var count = 0
        for parkingLot in self.parkingLotList {
            let district = parkingLot.getDistrict()
            if district.elementsEqual(selectedDistrict) {
                count += 1
            }
        }
        return count
    }
    
    func setListOfParkingLotsInTheDistrict(selectedDistrict : String) {
        var list : [ParkingLot] = []
        
        for parkingLot in self.parkingLotList {
            let district = parkingLot.getDistrict()
            if district.elementsEqual(selectedDistrict) {
                list.append(parkingLot)
            }
        }
        
        self.parkingLotList = list
    }
    
    func getParkingLotWithIndex(index : Int) -> ParkingLot {
        return parkingLotList[index]
    }
    
    func getDistrictWithIndex(index : Int) -> String {
        return districtList[index]
    }
    
    func loadParkingLots() {
        if let url = URL(string: baseUrl) {
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "GET"
            urlRequest.addValue("application/JSON", forHTTPHeaderField: "Content-Type")
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, request, error in
                let decoder = JSONDecoder()
                if let data = data {
                    let parkingLotListLoading = try! decoder.decode([ParkingLot].self, from: data)
                    self.parkingLotList = parkingLotListLoading
                    DispatchQueue.main.async {
                        self.delegate?.loadData()
                    }
                }
            }
            dataTask.resume()
        }
    }
    
    func loadDistricts() {
        for parkingLot in self.parkingLotList {
            let district = parkingLot.getDistrict()
            if self.districtList.contains(district) == false {
                self.districtList.append(district)
            }
        }
        self.districtList = self.districtList.sorted()
        let userDefaults = UserDefaults.standard
        userDefaults.setValue(self.districtList, forKey: "Districts8")
        
        self.delegate?.loadDistricts()
    }
    
    func copy() -> DataSource {
        
        let copy = DataSource()
        copy.districtList = self.districtList
        copy.parkingLotList = self.parkingLotList
        
        return copy
    }
}
