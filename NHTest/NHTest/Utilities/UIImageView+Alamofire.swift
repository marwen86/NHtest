//
//  UIImageView+Alamofire.swift
//  NHTest
//
//  Created by Mohamed Marouane YOUSSEF on 07/10/2017.
//  Copyright © 2017 Mohamed Marouane YOUSSEF. All rights reserved.
//

import UIKit

import Foundation
import AlamofireImage

typealias imageLoadCompletion = ((Error?) -> Void)?

extension UIImageView{
    func vsc_setImage(withURL url: URL,placeHolder: UIImage? = nil, imageTransition: ImageTransition = .noTransition, completion: imageLoadCompletion = nil) {
        
        self.af_setImage(withURL: url, placeholderImage: placeHolder, filter: nil, progress: nil, imageTransition: imageTransition, runImageTransitionIfCached: false) { (DataResponse) in
            DispatchQueue.main.async(execute: {
                completion?(DataResponse.error)
            });
        }
    }
}
