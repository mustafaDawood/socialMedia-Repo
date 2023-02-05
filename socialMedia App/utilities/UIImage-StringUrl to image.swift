//
//  UIImage-StringUrl to image.swift
//  socialMedia App
//
//  Created by Mac on 12/13/22.
//

import Foundation
import UIKit

extension UIImageView {
    func convertStringUrlToImage ( imageStringUrl : String){
        if let ImageUrl = URL(string: imageStringUrl) {
            if let ImageData = try? Data(contentsOf: ImageUrl) {
                self.image = UIImage(data: ImageData)
            }
        }
    }
    
    func makeImageCircular () {
        self.layer.cornerRadius = self.frame.width/2
    }
}
