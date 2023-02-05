//
//  Post.swift
//  socialMedia App
//
//  Created by Mac on 12/11/22.
//

import Foundation
import UIKit

struct Post : Decodable {
    var id : String
    var image : String
    var likes : Int
    var text : String
    var owner : User
}
