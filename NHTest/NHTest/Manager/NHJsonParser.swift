//
//  NHJsonParser.swift
//  NHTest
//
//  Created by Mohamed Marouane YOUSSEF on 07/10/2017.
//  Copyright © 2017 Mohamed Marouane YOUSSEF. All rights reserved.
//

import UIKit

class NHJsonParser {
    
    class func parseJSONLsitImagesResponse(_ response: Any?)-> NHResultImages? {
        
        guard let response = response as? Dictionary<String, AnyObject> else {
            return nil
        }
        return  NHResultImages.fromJson(response)
    }
}
