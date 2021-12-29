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
//    var parkingLot : ParkingLot?
    
//    var delegate : DataSourceDelegate?
    
    let baseUrl = "https://api.ibb.gov.tr/ispark/Park"
    
    init() {
    }
    
    func getNumberOfParkingLots() -> Int {
        return parkingLotList.count
    }
    
    func getNumberOfDistricts() -> Int {
        return districtList.count
    }
    
    func getNumberOfParkingLotInTheDistrict(district : String) -> Int {
        var count = 0
        
        for lot in self.parkingLotList {
            if lot.district.elementsEqual(district) {
                count += 1
            }
        }
        
        return count
    }
    
    func getListOfParkingLotsINTheDistrict(district : String) {
        var list : [ParkingLot] = []
        
        for lot in self.parkingLotList {
            if lot.district.elementsEqual(district) {
                list.append(lot)
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
//                        self.loadDistricts()
                    }
                }
            }
            dataTask.resume()
        }
    }
    
    func loadDistricts() {
        for i in self.parkingLotList {
            if self.districtList.contains(i.district) == false {
                self.districtList.append(i.district)
            }
        }
    }
    
//    func loadPharmacyDetail(pharmacyId : String) {
//        if let url = URL(string: "\(baseUrl)/pharmacy/\(pharmacyId)") {
//            var urlRequest = URLRequest(url: url)
//            urlRequest.httpMethod = "GET"
//            urlRequest.addValue("application/JSON", forHTTPHeaderField: "Content-Type")
//            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, request, error in
//                let decoder = JSONDecoder()
//                if let data = data {
//                    let pharmacyLoading = try! decoder.decode(PharmacyDetail.self, from: data)
//                    self.pharmacy = pharmacyLoading
//                    DispatchQueue.main.async {
//                        self.delegate?.detailLoaded(pharmacy: pharmacyLoading)                    }
//                }
//            }
//            dataTask.resume()
//        }
//    }
}
