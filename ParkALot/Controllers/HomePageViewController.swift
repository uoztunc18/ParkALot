//
//  HomePageViewController.swift
//  ParkALot
//
//  Created by Umut Öztunç on 16.12.2021.
//

import UIKit
import FirebaseAuth

class HomePageViewController: UIViewController {
    
    //Lag temp solution
//    @IBOutlet weak var districtListButton: UIButton!
//    
//    @IBOutlet weak var parkingLotListButton: UIButton!
    
    @IBOutlet weak var logoutButton: UIButton!
    
    @IBOutlet weak var car: UIImageView!
    @IBOutlet weak var sign: UIImageView!
    
    var dataSource = DataSource()
    
    var handle: AuthStateDidChangeListenerHandle?
    //

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.car.alpha = 0
        self.sign.alpha = 0
        self.car.transform = self.car.transform.translatedBy(x: -110, y: 0)
        self.title = "Home Page"
        
//        let userDefaults = UserDefaults.standard
//        if let cachedData = userDefaults.data(forKey: "CachedData") {
//            let decoder = JSONDecoder()
//            let parkingLotListLoading = try! decoder.decode([ParkingLot].self, from: cachedData)
//            self.dataSource.parkingLotList = parkingLotListLoading
//        } else {
//            dataSource.loadParkingLots()
//            sleep(10)
//        }
//        dataSource.loadDistricts()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 2) {
            self.signAppears()
            self.carAppears()
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 20, options: []) {
                self.signMovesDown()
//            } completion : { animated in
//                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1.2, initialSpringVelocity: 8, options: []) {
//                    self.signMovesRight()
//                }
            }
            UIView.animate(withDuration: 0.5, delay: 0.75, usingSpringWithDamping: 1.2, initialSpringVelocity: 8, options: []) {
                self.carMoves()
                self.signMovesRight()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        handle = Auth.auth().addStateDidChangeListener { auth, user in
        }
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(handle!)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        UIView.animate(withDuration: 0.25) {
            self.carMovesBack()
            self.signMovesBack()
            self.carDisappears()
            self.signDisppears()
        }
        
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//    }

    @IBAction func logoutTapped(_ sender: UIButton) {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
        let LoginScreenViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginScreenViewController") as! LoginScreenViewController
        self.navigationController?.pushViewController(LoginScreenViewController, animated: false)
        
    }
    
    func carAppears() {
        self.car.alpha = 1
    }
    
    func carDisappears() {
        self.car.alpha = 0
    }
    
    func signAppears() {
        self.sign.alpha = 1
    }
    
    func signDisppears() {
        self.sign.alpha = 0
    }
    
    func carMoves() {
        self.car.transform = self.car.transform.translatedBy(x: 95, y: 0)
    }
    
    func signMovesDown() {
        self.sign.transform = self.sign.transform.translatedBy(x: 0, y: 150)
    }
    
    func signMovesRight() {
        self.sign.transform = self.sign.transform.translatedBy(x: 60, y: 0)
    }
    
    func carMovesBack() {
        self.car.transform = self.car.transform.translatedBy(x: -95, y: 0)
    }
    
    func signMovesBack() {
        self.sign.transform = self.sign.transform.translatedBy(x: 0, y: -150)
        self.sign.transform = self.sign.transform.translatedBy(x: -60, y: 0)
    }
}
