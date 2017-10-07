//
//  VSCRequestManager.swift
//  VSCWeatherMap
//
//  Created by Mohamed Marouane YOUSSEF on 07/10/2017.
//  Copyright © 2017 Mohamed Marouane YOUSSEF. All rights reserved.
//


let API_KEY = "5511001-7691b591d9508e60ec89b63c4"
let API_DOWNLOAD_IMAGES_LIST_URL  = "https://pixabay.com/api/?"

public typealias imagesDownloadError  = (_ error : Error) -> ()
public typealias imagesListDownloadSuccess  = (_ imagesList : NHResultImages?) -> ()


import UIKit
import Alamofire
import AlamofireImage

class NHRequestManager {
    
    static internal let sharedInstance = NHRequestManager()
    
    func loadImageByQuery(_ query: String, success : imagesListDownloadSuccess?, error : imagesDownloadError?) {
       
        
        guard let requstUrl = NHRequestManager.generateLoadImagesListRequestURL(query) else {
            return
        }
        Alamofire.request(requstUrl).responseJSON { response in
            
            switch response.result {
            case .success :
                if let json = response.result.value {
                    let imagesList = NHJsonParser.parseJSONLsitImagesResponse(json)
                    if let succes = success {
                        succes(imagesList)
                    }
                }
                break
            case .failure:
                if let json = response.result.error {
                    if let error = error {
                        error(json)
                    }
                }
                break
            }
        }
    }
    
   
    
    class func generateLoadImagesListRequestURL(_ query: String) -> URL? {
        guard var components = URLComponents(string:API_DOWNLOAD_IMAGES_LIST_URL) else {
            return nil
        }
    
        components.queryItems = [URLQueryItem(name:"key", value:API_KEY),
                                 URLQueryItem(name:"q", value:query),
                                 URLQueryItem(name:"image_type", value:"photo")]
        
        return components.url
    }

}


class Connectivity {
    class func isConnectedToInternet() ->Bool {       
        #if os(iOS)
            guard let manager = NetworkReachabilityManager() else{
                return false
            }
            return manager.isReachable
        #else
            return true
        #endif
    }
}
