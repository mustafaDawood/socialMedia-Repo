//
//  TagVC.swift
//  socialMedia App
//
//  Created by Mac on 12/29/22.
//

import UIKit
import NVActivityIndicatorView

class TagVC: UIViewController {
    var tagArr :[String?] = []
    @IBOutlet weak var tagCollectionView: UICollectionView!
    @IBOutlet weak var loaderView: NVActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tagCollectionView.delegate = self
        tagCollectionView.dataSource = self
        loaderView.startAnimating()
        PostAPI.getTags { (tags) in
            self.loaderView.stopAnimating()
            self.tagArr = tags
            self.tagCollectionView.reloadData()
        }

        // Do any additional setup after loading the view.
    }
    

}

extension TagVC : UICollectionViewDelegate , UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tagArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCell", for: indexPath) as! TagCell
        let currentTag = tagArr[indexPath.row]
        cell.tagNameLabel.text = currentTag
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentTag = tagArr[indexPath.row]
        let vc = storyboard?.instantiateViewController(identifier: "PostVc") as! PostVc
        vc.tags = currentTag
        present(vc, animated: true, completion: nil)
    }
}
