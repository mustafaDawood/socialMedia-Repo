//
//  ViewController.swift
//  socialMedia App
//
//  Created by Mac on 12/11/22.
//

import UIKit
import NVActivityIndicatorView

class PostVc: UIViewController {
    var posts : [Post] = []
    var tags : String?
    var PageNO = 0
    var totalPosts = 800
    // MARK: Outlets
    @IBOutlet weak var hiLabel: UILabel!
    @IBOutlet weak var feedLabel: UILabel!
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var postTableView: UITableView!
    @IBOutlet weak var loaderView: NVActivityIndicatorView!
    
    @IBOutlet weak var addPostView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        postTableView.delegate = self
        postTableView.dataSource = self
        
        if let user = UserManager.loggedInUser  {
            hiLabel.text! = " Hi , \(user.firstName)"
        } else {
            hiLabel.isHidden = true
            addPostView.isHidden = true
        }
        if tags == nil {
            exitButton.isHidden = true
        } else {
            feedLabel.text = "Results for\(tags!) "
        }
        // MARK: Notifications
        NotificationCenter.default.addObserver(self, selector: #selector(userInfoTappedRecive), name: NSNotification.Name(rawValue: "userInfoTapped"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(newPostAdded), name: NSNotification.Name(rawValue:"NewPostAdded"), object: nil)
        
        getPosts()
        
    }
    // MARK: Methods
    func getPosts () {
        loaderView.startAnimating()
        PostAPI.getPostData(page: PageNO, Tag: tags) { (PostResponse , total) in
            self.totalPosts = total
            self.posts.append(contentsOf: PostResponse)
            self.postTableView.reloadData()
            self.loaderView.stopAnimating()
         
        }
    }
    
    @objc func userInfoTappedRecive (notification : Notification) {
        if let cell = notification.userInfo?["cell"] as? UITableViewCell {
            if let indexPath = postTableView.indexPath(for: cell) {
                let post = posts[indexPath.row]
                let vc = storyboard?.instantiateViewController(identifier: "ProfileVC") as! ProfileVC
                vc.user = post.owner
                present(vc, animated: true, completion: nil)
            }
        }
    }
    @objc func newPostAdded () {
        self.posts = []
        self.PageNO = 0
        getPosts()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "logOutSegue" {
            UserManager.loggedInUser = nil
        }
    }
    // MARK: Actions
    @IBAction func exitButtonClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

    // MARK: TableView
extension PostVc : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        let post = posts[indexPath.row]
        // MARK: Filling user info into cell
        cell.userPicImageView.makeImageCircular()
        if let userImageStringUrl = post.owner.picture{
            cell.userPicImageView.convertStringUrlToImage(imageStringUrl: userImageStringUrl)
        }
        cell.userNameLabel.text = post.owner.firstName + " " + post.owner.lastName
        // MARK: Filling post info into cell
        let postImageStringUrl = post.image
        cell.postImageView.convertStringUrlToImage(imageStringUrl: postImageStringUrl)
        cell.postTextLabel.text = post.text
        cell.likesLabel.text = String(post.likes)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "PostDetailsVC") as! PostDetailsVC
        let selectedPost = posts[indexPath.row]
        vc.post = selectedPost
        present(vc, animated: true, completion: nil)
       
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == posts.count-1 && posts.count < totalPosts
        {
            PageNO = PageNO + 1
            getPosts()
        }
       
    }
    
    
    
    
}

