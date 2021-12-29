//
//  ParkingLot.swift
//  ParkALot
//
//  Created by Umut Öztunç on 16.12.2021.
//

import Foundation

struct ParkingLot : Decodable {
    let parkID : Int
    let parkName : String
    let lat : String
    let lng : String
    let capacity : Int
    let emptyCapacity : Int
    let workHours : String
    let parkType : String
    let freeTime : Int
    let district : String
    let isOpen : Int
}
