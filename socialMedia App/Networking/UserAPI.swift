//
//  UserAPI.swift
//  socialMedia App
//
//  Created by Mac on 12/15/22.
//

import Foundation
import Alamofire
import SwiftyJSON

class UserAPI: API {
    static func getUserData (id : String ,  Handler : @escaping (User)->()) {
        
        let url = "\(baseURL)/user/\(id)"
        
        AF.request(url , headers: headers).responseJSON { (response) in
            let JsonData = JSON(response.value)
            let decodable = JSONDecoder()
            do {
                let user = try decodable.decode(User.self, from: JsonData.rawData())
                Handler(user)
            } catch let error {
                print(error)
            }
            
        }
        
    }
    
    static func registerRequest (firstName : String? , lastName : String? , email : String?, Handler : @escaping (User? , String?)->()) {
        
        let url = "\(baseURL)user/create"
         let params = [
            "firstName" : firstName ,
            "lastName" : lastName ,
            "email" : email
        ]
        AF.request(url , method: .post,parameters: params,encoder: JSONParameterEncoder.default, headers: headers).validate().responseData(completionHandler: { (response) in
            switch response.result {
            case .success:
                let JsonData = JSON(response.data)
                let decodable = JSONDecoder()
                do {
                    let user = try decodable.decode(User.self, from: JsonData.rawData())
                    Handler(user , nil)
                } catch let error {
                    print(error)
                }
            case .failure(let error):
                let jsonData = JSON(response.data)
                let data = jsonData["data"]
                let firstNameError = data ["firstName"].stringValue
                let lastNameError = data ["lastName"].stringValue
                let emailError = data ["email"].stringValue
                let errorMessage = firstNameError + " " + lastNameError + " " + emailError
                Handler(nil , errorMessage)
            
            }
        })
        
    }
    
    
    static func signInUser (firstName : String , lastName : String , Handler : @escaping (User? , String?)->()) {
        
        let url = "\(baseURL)user"
         let params = [
            "created" : "1"
        ]
        
        AF.request(url , method: .get,parameters: params,encoder: URLEncodedFormParameterEncoder.default, headers: headers).validate().responseData(completionHandler: { (response) in
            switch response.result {
            case .success:
                let JsonData = JSON(response.value)
                let data = JsonData["data"]
                let decodable = JSONDecoder()
                do {
                    let users = try decodable.decode([User].self, from: data.rawData())
                    print(users)
                    var foundUser : User?
                    for user in users {
                        if user.firstName == firstName && user.lastName == lastName {
                            foundUser = user
                            break
                        }
                    }
                    if let signedUser = foundUser {
                        Handler(signedUser , nil)
                    } else {
                        Handler(nil, "user not found")
                    }
                    
                } catch let error {
                    print(error)
                }
            case .failure(let error):
                let jsonData = JSON(response.data)
                let data = jsonData["data"]
                let firstNameError = data ["firstName"].stringValue
                let lastNameError = data ["lastName"].stringValue
                let emailError = data ["email"].stringValue
                let errorMessage = firstNameError + " " + lastNameError + " " + emailError
                Handler(nil , errorMessage)
            print(error)
            }
        })
        
    }
    
    static func UpdateUserInfo (id : String ,firstName : String , phone : String, imageUrl : String , Handler : @escaping (User? , String?)->()) {
        
        let url = "\(baseURL)user/\(id)"
         let params = [
            "firstName" : firstName ,
            "phone" : phone ,
            "picture" : imageUrl
        ]
        
        AF.request(url , method: .put,parameters: params,encoder: JSONParameterEncoder.default, headers: headers).validate().responseData(completionHandler: { (response) in
            switch response.result {
            case .success:
                let JsonData = JSON(response.value)
                let decodable = JSONDecoder()
                do {
                    let user = try decodable.decode(User.self, from: JsonData.rawData())
                   Handler(user,nil)
                    
                } catch let error {
                    print(error)
                }
            case .failure(let error):
                let jsonData = JSON(response.data)
                let data = jsonData["data"]
                let firstNameError = data ["firstName"].stringValue
                let lastNameError = data ["lastName"].stringValue
                let emailError = data ["email"].stringValue
                let errorMessage = firstNameError + " " + lastNameError + " " + emailError
                Handler(nil , errorMessage)
            print(error)
            }
        })
        
    }
        
    
    }

