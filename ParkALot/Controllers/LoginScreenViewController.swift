//
//  ViewController.swift
//  ParkALot
//
//  Created by Umut Öztunç on 16.12.2021.
//

import UIKit
import FirebaseAuth

class LoginScreenViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signinButton: UIButton!
    
    var handle: AuthStateDidChangeListenerHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        handle = Auth.auth().addStateDidChangeListener { auth, user in
            if user != nil {
                let HomePageViewController = self.storyboard?.instantiateViewController(withIdentifier: "HomePageViewController") as! HomePageViewController
                self.navigationController?.pushViewController(HomePageViewController, animated: false)
            }
        }
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(handle!)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }


    @IBAction func registerTapped(_ sender: Any) {
            self.performSegue(withIdentifier: "goRegister", sender: self)
        }
        
    @IBAction func loginTapped(_ sender: UIButton) {
            
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            

        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                
            if error != nil {
                    // Couldn't sign in
                self.showAlert(msg: error!.localizedDescription)
                
            } else {
                let HomePageViewController = self.storyboard?.instantiateViewController(withIdentifier: "HomePageViewController") as! HomePageViewController
                self.navigationController?.pushViewController(HomePageViewController, animated: false)
            }
        }
    }
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
            
        return false
    }
    
    func showAlert(msg: String?) {
        let refreshAlert: UIAlertController
        if(msg != nil) {
            refreshAlert = UIAlertController(title: "Error", message: "\(msg!)", preferredStyle: .alert)
            
        }else {
            refreshAlert = UIAlertController(title: "Error", message: "Make sure you enter a valid email address and If you don't have account register one", preferredStyle: .alert)
            
        }
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in}))
        present(refreshAlert, animated: true, completion: nil)
        
    }
}
