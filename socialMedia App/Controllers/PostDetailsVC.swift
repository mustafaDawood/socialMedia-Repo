//
//  PostDetailsVC.swift
//  socialMedia App
//
//  Created by Mac on 12/12/22.
//

import UIKit

class PostDetailsVC: UIViewController {
// MARK: outlets
    var post :Post!
    var commentsArray : [Comment] = []
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var postView: UIView! {
        didSet {
            postView.layer.shadowColor = UIColor.gray.cgColor
            postView.layer.shadowOpacity = 0.4
            postView.layer.shadowRadius = 10
            postView.layer.shadowOffset = CGSize(width: 0, height: 10)
            postView.layer.cornerRadius = 7
        }
    }
    @IBOutlet weak var postDetailsLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var exitPostButton: UIButton!
    @IBOutlet weak var commentTableView: UITableView!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var addCommentSV: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserManager.loggedInUser == nil {
            addCommentSV.isHidden = true
        }
        userNameLabel.text = post.owner.firstName + " " + post.owner.lastName
        postDetailsLabel.text = post.text
        likesLabel.text = String(post.likes)
        if let image = post.owner.picture {
            userImageView.convertStringUrlToImage(imageStringUrl: image )
        }
        userImageView.makeImageCircular()
        postImageView.convertStringUrlToImage(imageStringUrl: post.image)
        exitPostButton.layer.cornerRadius = exitPostButton.frame.width/2
        commentTableView.delegate = self
        commentTableView.dataSource = self
        // Do any additional setup after loading the view.
       getComments()
    }
    
    func getComments () {
        PostAPI.getCommentData(id: post.id) { (commentResponse) in
            self.commentsArray = commentResponse
            self.commentTableView.reloadData()
        }
    }
    
    @IBAction func exitPost(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func addCommentButton(_ sender: Any) {
        let message = commentTextField.text!
        if let user = UserManager.loggedInUser {
            PostAPI.addNewComment(postId: post.id, userId: user.id , message: message) {
                self.getComments()
                self.commentTextField.text! = ""
            }
        }
      
    }
}
extension PostDetailsVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell") as! CommentCell
        let comment = commentsArray[indexPath.row]
        cell.commentMessageLabel.text = comment.message
        cell.userNameLabel.text = comment.owner.firstName + " " + comment.owner.lastName
        if  let userImageStringUrl = comment.owner.picture {
            cell.userImageView.convertStringUrlToImage(imageStringUrl: userImageStringUrl)
        }
        cell.userImageView.makeImageCircular()
        return cell
    }
}

