//
//  TagCell.swift
//  socialMedia App
//
//  Created by Mac on 12/29/22.
//

import UIKit

class TagCell: UICollectionViewCell {
    
    
    @IBOutlet weak var tagNameLabel: UILabel!
    
    @IBOutlet weak var tagCellView: UIView!{
        didSet {
            tagCellView.layer.shadowColor = UIColor.darkGray.cgColor
            tagCellView.layer.backgroundColor = UIColor.systemIndigo.cgColor
            tagCellView.layer.shadowOpacity = 0.4
            tagCellView.layer.shadowRadius = 10
            tagCellView.layer.shadowOffset = CGSize(width: 0, height: 10)
            tagCellView.layer.cornerRadius = 7
        }
    }
}
