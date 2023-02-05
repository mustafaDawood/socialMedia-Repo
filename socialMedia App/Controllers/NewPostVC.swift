//
//  NewPostVC.swift
//  socialMedia App
//
//  Created by Mac on 1/4/23.
//

import UIKit

class NewPostVC: UIViewController {
    // MARK: Outlets
    @IBOutlet weak var postTextFiled: UITextField!
    @IBOutlet weak var postImageTextFiled: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    // MARK: Actions
    
    @IBAction func addPostButton(_ sender: Any) {
        if let user = UserManager.loggedInUser{
            PostAPI.addNewPost(postText: postTextFiled.text!, userId: user.id , postPhoto : postImageTextFiled.text!) {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue:"NewPostAdded"), object: nil, userInfo: nil)
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func cnacelAddingButton(_ sender: Any) {
        let alert = UIAlertController.init(title: "Cancel", message: "Are you sure you want to cancel", preferredStyle: .alert)
        let cancelAction = UIAlertAction.init(title: "Discard", style: .destructive) { (UIAlertAction) in
            self.dismiss(animated: true, completion: nil)
        }
        let noAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alert.addAction(cancelAction)
        alert.addAction(noAction)
        present(alert, animated: true, completion: nil)
    }
    
    
}
