//
//  RegisterViewController.swift
//  ParkALot
//
//  Created by Umut Öztunç on 16.12.2021.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class RegisterViewController: UIViewController {
    
    var db: Firestore!

    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var registerButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let settings = FirestoreSettings()
        
        Firestore.firestore().settings = settings
        
        db = Firestore.firestore()
    }
    
    
    // Check the fields and validate that the data is correct. If everything is correct, this method returns nil. Otherwise, it returns the error message
    func validateFields() -> String? {
        
        // Check that all fields are filled in
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields."
        }
        
        // Check if the password is secure
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        return nil
    }
    
    @IBAction func registerTapped(_ sender: Any) {
            
            // Validate the fields
            let error = validateFields()
            
            if error != nil {
                
                // There's something wrong with the fields, show error message
                showError(error!)
            }
            else {
                
                // Create cleaned versions of the data
                let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                
                // Create the user
                Auth.auth().createUser(withEmail: email, password: password) { result, err in
                    
                    // Check for errors
                    if let err = err {
                        
                        self.showError("Error creating user")
                    }
                    else {
                        
                        var ref: DocumentReference? = nil
                        
                        ref = self.db.collection("users").addDocument(data: [
                            "firstname":firstName,
                            "lastname":lastName,
                            "uid": result!.user.uid
                        ]) { err1 in
                            
                            if let err1 = err1 {
                                // Show error message
                                self.showError("Error saving user data")
                            }
                            else {
                                // Transition to the home screen
                                let HomePageViewController = self.storyboard?.instantiateViewController(withIdentifier: "HomePageViewController") as! HomePageViewController
                                self.navigationController?.pushViewController(HomePageViewController, animated: false)
                            }
                        }
                        
                        
                    }
                    
                }
                
                
                
            }
        }
    
        func showError(_ message:String) {
            let refreshAlert: UIAlertController
            refreshAlert = UIAlertController(title: "Error", message: "\(message)", preferredStyle: .alert)

            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in}))
            present(refreshAlert, animated: true, completion: nil)
        }
        
        override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
            
            return false
        }
        
    }
