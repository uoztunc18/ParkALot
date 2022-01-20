//
//  ReviewDataSource.swift
//  ParkALot
//
//  Created by Lab on 20.01.2022.
//

import Foundation
import FirebaseFirestore

class ReviewDataSource {
    
    var db: Firestore!
    
    var reviewList : [Review] = []
    
    var delegate : ReviewDataSourceProtocol?
    
    
    func getNumberOfReviews() -> Int {
        return reviewList.count
    }
    
    func getReviewWithIndex(index : Int) -> Review {
        return reviewList[index]
    }
    
    func loadReviewsByParkingLot(parkingLot: String){
        let settings = FirestoreSettings()
        
        Firestore.firestore().settings = settings
        
        db = Firestore.firestore()
        db.collection("reviews").getDocuments() { (querySnapshot, err) in
                if let err = err {
                        print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        let data = document.data()
                        if data["parkingLot"] as! String == parkingLot{
                            let review = Review(email: data["email"] as! String, review: data["review"] as! String, parkingLot: data["parkingLot"] as! String)
                            self.reviewList.append(review)
                        }
                    }
                    DispatchQueue.main.async {
                        self.delegate?.loadData()
                        print(self.reviewList)
                    }
                }
        }
    }
}
