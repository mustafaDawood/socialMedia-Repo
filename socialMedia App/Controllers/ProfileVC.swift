//
//  ProfileVC.swift
//  socialMedia App
//
//  Created by Mac on 12/14/22.
//

import UIKit

class ProfileVC: UIViewController {

    @IBOutlet weak var profileImageview: UIImageView! {
        didSet {
            profileImageview.makeImageCircular()
        }
    }
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    var user : User!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        UserAPI.getUserData(id: user.id) { (userResponse) in
            self.user = userResponse
            self.setupUI()
        }
        
        }
    func setupUI () {
        profileImageview.convertStringUrlToImage(imageStringUrl: user.picture!)
        userNameLabel.text = user.firstName + " " + user.lastName
        emailLabel.text = user.email
        phoneLabel.text = user.phone
        genderLabel.text = user.gender
        if let location = user.location {
            countryLabel.text = location.country + "-" + location.city
        }
        

        // Do any additional setup after loading the view.
    }
    

    

}
