//
//  NHImageModel.swift
//  NHTest
//
//  Created by Mohamed Marouane YOUSSEF on 07/10/2017.
//  Copyright © 2017 Mohamed Marouane YOUSSEF. All rights reserved.
//

import UIKit


public struct  NHImageModel {
    
    var comments : Int
    var downloads : Int
    var favorites : Int
    var id : Int
    var imageHeight : Int
    var imageWidth : Int
    var likes : Int
    var pageURL : String
    var previewHeight : Int
    var previewURL : String
    var previewWidth : Int
    var type : String
    var user : String
    var userImageURL : String
    var tags : String
    var user_id : Int
    var views : Int
    var webformatHeight : Int
    var webformatURL : String
    var webformatWidth : Int

}

extension NHImageModel: Equatable {
    public /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    static func ==(lhs: NHImageModel, rhs: NHImageModel) -> Bool {
        return true
    }
}

