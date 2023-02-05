//
//  PostAPI.swift
//  socialMedia App
//
//  Created by Mac on 12/15/22.
//

import Foundation
import Alamofire
import SwiftyJSON

class PostAPI: API {
    static func getPostData (page: Int , Tag : String? , Handler : @escaping ([Post] , Int) -> ()) {
        var url = "\(baseURL)/post"
        if var requestedTag = Tag {
            requestedTag = requestedTag.trimmingCharacters(in: .whitespaces)
             url = "\(baseURL)/tag/\(requestedTag)/post"
        }
        var Params = [
            "page" : "\(page)" ,
            "limit" : "20"
        ]
        AF.request(url ,parameters: Params , encoder: URLEncodedFormParameterEncoder.default, headers: headers).responseJSON { (response) in
            let JsonData = JSON(response.value)
            let data = JsonData["data"]
            let total = JsonData["total"].intValue
            
            let decodable = JSONDecoder()
            do {
                let posts = try decodable.decode([Post].self, from: data.rawData())
                Handler(posts, total)
            } catch let error {
                print(error)
            }
        
        }
    }
    
    static func addNewPost (postText : String , userId : String , postPhoto : String , handler : @escaping ()->() ){
        let url = "\(baseURL)post/create"
        let params = [
            "text":postText ,
            "owner": userId,
            "image" : postPhoto
        ]
        AF.request(url, method: .post, parameters: params, encoder: JSONParameterEncoder.default, headers: headers).validate().responseData { (response) in
            switch response.result {
            case .success  :
                handler()
            case .failure(let error) :
                print(error)
            }
        }
        
    }
    // MARK: tags request
    static func getTags ( Handler : @escaping ([String?]) -> ()) {
        var url = "\(baseURL)/tag"
        AF.request(url , headers: headers).responseJSON { (response) in
            let JsonData = JSON(response.data)
            let data = JsonData["data"]
            let decodable = JSONDecoder()
            do {
                let tags = try decodable.decode([String?].self, from: data.rawData())
                Handler(tags)
            } catch let error {
                print(error)
            }
        
        }
    }
    
    
    
    // MARK: comments request
    static func getCommentData (id : String , Handler : @escaping ([Comment])->()) {
        let url = "\(baseURL)/post/\(id)/comment"
        AF.request(url , headers: headers).responseJSON { (response) in
            let JsonData = JSON(response.value)
            let data = JsonData["data"]
            let decodeable = JSONDecoder()
            do {
                let comments = try decodeable.decode([Comment].self, from: data.rawData())
                Handler(comments)
            } catch let error {
                print(error)
            }
        }
    }
    
    static func addNewComment (postId : String , userId : String , message : String , handler : @escaping ()->() ){
        let url = "\(baseURL)comment/create"
        let params = [
            "post":postId ,
            "owner": userId ,
            "message": message
        ]
        AF.request(url, method: .post, parameters: params, encoder: JSONParameterEncoder.default, headers: headers).validate().responseData { (response) in
            switch response.result {
            case .success  :
                handler() 
            case .failure(let error) :
                print(error)
            }
        }
        
    }
}
