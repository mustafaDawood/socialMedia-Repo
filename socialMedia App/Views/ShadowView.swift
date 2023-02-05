//
//  ShadowView.swift
//  socialMedia App
//
//  Created by Mac on 12/29/22.
//

import UIKit

class ShadowView: UIView {

    self.layer.shadowColor = UIColor.gray.cgColor
    postView.layer.shadowOpacity = 0.4
    postView.layer.shadowRadius = 10
    postView.layer.shadowOffset = CGSize(width: 0, height: 10)
    postView.layer.cornerRadius = 7

}
