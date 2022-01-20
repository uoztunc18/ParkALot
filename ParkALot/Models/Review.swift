//
//  Review.swift
//  ParkALot
//
//  Created by Lab on 20.01.2022.
//

import Foundation

struct Review : Codable {
    let email : String
    let review : String?
    let parkingLot: String
}
