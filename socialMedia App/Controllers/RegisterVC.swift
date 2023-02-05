//
//  RegisterVC.swift
//  socialMedia App
//
//  Created by Mac on 12/15/22.
//

import UIKit

class RegisterVC: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    var user : User!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func registerBurron(_ sender: Any) {
        UserAPI.registerRequest(firstName: firstNameTextField.text!, lastName: lastNameTextField.text!, email: emailTextField.text!) { (user, errorMessage) in
            if errorMessage != nil {
                let alert = UIAlertController(title: "ERROR", message: errorMessage, preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            } else {
                let vc = self.storyboard?.instantiateViewController(identifier: "PostVc") as! PostVc
                UserManager.loggedInUser = user
                self.present(vc, animated: true, completion: nil)
            
            
        }
    
}
    
}
}
