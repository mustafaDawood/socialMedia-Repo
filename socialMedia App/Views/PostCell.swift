//
//  PostCell.swift
//  socialMedia App
//
//  Created by Mac on 12/11/22.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet weak var postView: UIView! {
        didSet {
            postView.layer.shadowColor = UIColor.gray.cgColor
            postView.layer.shadowOpacity = 0.4
            postView.layer.shadowRadius = 10
            postView.layer.shadowOffset = CGSize(width: 0, height: 10)
            postView.layer.cornerRadius = 7
        }
    }
    @IBOutlet weak var userInfoStackView: UIStackView! {
        didSet{
            userInfoStackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(userStackViewTapped)))
        }
    }
    @IBOutlet weak var userPicImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var postTextLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var likesLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func userStackViewTapped () {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "userInfoTapped"), object: nil, userInfo: ["cell":self])
    }

}
