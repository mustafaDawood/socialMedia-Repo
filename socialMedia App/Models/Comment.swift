//
//  Comment.swift
//  socialMedia App
//
//  Created by Mac on 12/12/22.
//

import Foundation
import UIKit
struct Comment : Decodable {
    var id : String
    var message : String
    var owner : User
}
