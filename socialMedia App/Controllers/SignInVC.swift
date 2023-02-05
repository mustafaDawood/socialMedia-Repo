//
//  SignInVC.swift
//  socialMedia App
//
//  Created by Mac on 12/22/22.
//

import UIKit
import Spring
class SignInVC: UIViewController {

    
    @IBOutlet weak var siginInView: SpringView!
    @IBOutlet weak var firstNameTextField: SpringTextField!
    @IBOutlet weak var lastNameTextField: SpringTextField!
    @IBOutlet weak var signInButton: SpringButton!
    @IBOutlet weak var registerButton: SpringButton!
    @IBOutlet weak var SkipButton: SpringButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        animationSetUp()
    }
    func animationSetUp () {
        firstNameTextField.animation = "fadeInLeft"
        firstNameTextField.delay = 0.7
        firstNameTextField.duration = 1
        firstNameTextField.animate()
        
        lastNameTextField.animation = "fadeInRight"
        lastNameTextField.delay = 1
        lastNameTextField.duration = 1
        lastNameTextField.animate()
        
        signInButton.animation = "zoomIn"
        signInButton.delay = 1.3
        signInButton.duration = 1.3
        signInButton.animate()
        
        registerButton.animation = "fadeInUp"
        registerButton.delay = 1.5
        registerButton.duration = 1.3
        registerButton.animate()
        
        siginInView.animation = "zoomIn"
        siginInView.delay = 0.3
        siginInView.duration = 1.3
        siginInView.animate()
        
    }

    @IBAction func signInButton(_ sender: Any) {
        UserAPI.signInUser(firstName: firstNameTextField.text! , lastName: lastNameTextField.text! ) { (user, errorMessage) in
            
            if let message = errorMessage {
                let alert = UIAlertController(title: "ERROR", message: message, preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(alertAction)
                self.present(alert, animated: true, completion: nil)
            } else {
                if let signedUser = user {
                    let vc = self.storyboard?.instantiateViewController(identifier: "MainTabBarController")
                    UserManager.loggedInUser = signedUser
                    self.present(vc!, animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func skipButton(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "PostVc") as! PostVc
        present(vc, animated: true, completion: nil)
    }
}
