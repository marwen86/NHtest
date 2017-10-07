//
//  NHSearchImagesPresenter.swift
//  NHTest
//
//  Created by Mohamed Marouane YOUSSEF on 07/10/2017.
//  Copyright © 2017 Mohamed Marouane YOUSSEF. All rights reserved.
//

import UIKit

class NHSearchImagesPresenter: NSObject {

    weak private var view : imagesSearchProtocol?
    
    init(view : imagesSearchProtocol) {
        self.view = view
    }
    
    func loadImages(_ query :String) {
        
        guard Connectivity.isConnectedToInternet() else {
            self.view?.showReachbilityALert()
            return
        }
        
        NHRequestManager.sharedInstance.loadImageByQuery(query, success: {[weak self] (result) in
            //
            self?.view?.refreshView(result)
        }) { [weak self] (error) in
            //
            self?.view?.showDownlaodErrorAlert(error: error)
        }
    }
}
