//
//  MyProfileVC.swift
//  socialMedia App
//
//  Created by Mac on 2/3/23.
//

import UIKit

class MyProfileVC: UIViewController {

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var imageUrlTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        uiSetUp()

        // Do any additional setup after loading the view.
    }
//    MARK: UI SETUP
    func uiSetUp (){
        userImageView.makeImageCircular()
        if let user = UserManager.loggedInUser{
        if let image = user.picture {
            userImageView.convertStringUrlToImage(imageStringUrl: image)
        }
        userNameLabel.text = user.firstName + " " + user.lastName
            firstNameTextField.text = user.firstName
            phoneTextField.text = user.phone
            imageUrlTextField.text = user.picture
    }
    }
    

    @IBAction func updateInfoButton(_ sender: Any) {
        guard let loggedInuser = UserManager.loggedInUser else {return}
            UserAPI.UpdateUserInfo(id: loggedInuser.id, firstName: firstNameTextField.text!, phone: phoneTextField.text!, imageUrl: imageUrlTextField.text!) { (user, message) in
                if let responseUser = user {
                    if let image = responseUser.picture {
                        self.userImageView.convertStringUrlToImage(imageStringUrl: image)
                        self.userNameLabel.text = responseUser.firstName + " " + responseUser.lastName
                        
                        
                    }
                }
            }
    }
}
