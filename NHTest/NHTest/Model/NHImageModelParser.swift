//
//  NHImageModelParser.swift
//  NHTest
//
//  Created by Mohamed Marouane YOUSSEF on 07/10/2017.
//  Copyright © 2017 Mohamed Marouane YOUSSEF. All rights reserved.
//

import UIKit

extension NHImageModel {
    static func fromJson(_ data : Dictionary<String,AnyObject>)-> NHImageModel? {
        
        guard let comments = data["comments"] as? Int,
            let downloads = data["downloads"] as? Int,
            let favorites = data["favorites"] as? Int,
            let id = data["id"] as? Int,
            let imageHeight = data["imageHeight"] as? Int,
            let imageWidth = data["imageWidth"] as? Int,
            let likes = data["likes"] as? Int,
            let pageURL = data["pageURL"] as? String,
            let previewHeight = data["previewHeight"] as? Int,
            let previewURL = data["previewURL"] as? String,
            let previewWidth = data["previewWidth"] as? Int,
            let type = data["type"] as? String,
            let user = data["user"] as? String,
            let userImageURL = data["userImageURL"] as? String,
            let tags = data["tags"] as? String,
            let user_id = data["user_id"] as? Int,
            let views = data["views"] as? Int,
            let webformatHeight = data["webformatHeight"] as? Int,
            let webformatURL = data["webformatURL"] as? String,
            let webformatWidth = data["webformatWidth"] as? Int else {
                
                return nil
        }
        return NHImageModel(comments: comments, downloads: downloads, favorites: favorites, id: id, imageHeight: imageHeight, imageWidth: imageWidth, likes: likes, pageURL: pageURL, previewHeight: previewHeight, previewURL: previewURL, previewWidth: previewWidth, type: type, user: user, userImageURL: userImageURL, tags: tags, user_id: user_id, views: views, webformatHeight: webformatHeight, webformatURL: webformatURL, webformatWidth: webformatWidth)
    }
}
