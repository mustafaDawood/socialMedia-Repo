//
//  User.swift
//  socialMedia App
//
//  Created by Mac on 12/11/22.
//

import Foundation
import UIKit

struct User : Decodable {
    var id : String
    var firstName : String
    var lastName : String
    var picture : String?
    var email : String?
    var phone : String?
    var gender : String?
    var location :Location?
    
}
