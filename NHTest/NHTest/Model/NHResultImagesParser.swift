//
//  NHResultImagesParser.swift
//  NHTest
//
//  Created by Mohamed Marouane YOUSSEF on 07/10/2017.
//  Copyright © 2017 Mohamed Marouane YOUSSEF. All rights reserved.
//

import UIKit

extension NHResultImages {
    static func fromJson(_ data : Dictionary<String,AnyObject>)-> NHResultImages? {
        
        
        guard let total = data["total"] as? Int,
            let totalHits = data["totalHits"] as? Int,
            let hitsArray =  data["hits"] as? Array<AnyObject> else {
                
                return nil
        }
        
        var hits = [NHImageModel]()
        for item in hitsArray {
            guard let item = item as? Dictionary<String,AnyObject> , let hit =  NHImageModel.fromJson(item) else {
                break
            }
            hits.append(hit)
        }
        
        return NHResultImages(total: total, totalHits: totalHits, hits: hits)
    }
}

