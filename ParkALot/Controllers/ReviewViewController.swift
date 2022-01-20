//
//  ReviewViewController.swift
//  ParkALot
//
//  Created by Umut Öztunç on 16.12.2021.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class ReviewViewController: UIViewController {

    @IBOutlet weak var reviewTable: UITableView!
    @IBOutlet weak var reviewLogBox: UITextField!
    @IBOutlet weak var sendReviewButton: UIButton!
    
    var db: Firestore!
    var dataSource = ReviewDataSource()
    var user: User?
    var parkingLotName : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource.delegate = self
        self.dataSource.loadReviewsByParkingLot(parkingLot: self.parkingLotName!)
        self.title = "Reviews"
        
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
    }
    
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        let user = Auth.auth().currentUser
        if let user = user {
            var ref: DocumentReference? = nil
            ref = db.collection("reviews").addDocument(data: [
                "email": user.email,
                "review": reviewLogBox.text!,
                "parkingLot": self.parkingLotName
            ]) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Document added with ID: \(ref!.documentID)")
                }
            }
        }
        reviewLogBox.text = ""

        reviewTable.reloadData()
        
    }
}


extension ReviewViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(dataSource.getNumberOfReviews())
        return dataSource.getNumberOfReviews()
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell", for: indexPath) as! ReviewTableCell
        let review = dataSource.getReviewWithIndex(index: indexPath.row.quotientAndRemainder(dividingBy: dataSource.getNumberOfReviews()).remainder)
        if review.parkingLot == self.parkingLotName{
            cell.userName.text = review.email
            cell.reviewBox.text = review.review
            return cell
        }
        return cell
    }
        

}

extension ReviewViewController : ReviewDataSourceProtocol{
    func loadData() {
        self.reviewTable.reloadData()
    }
    
    func loadReviews() {
    }
}
