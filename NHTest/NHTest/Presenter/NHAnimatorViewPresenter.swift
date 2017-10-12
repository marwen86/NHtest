//
//  NHAnimatorViewPresenter.swift
//  NHTest
//
//  Created by Mohamed Marouane YOUSSEF on 13/10/2017.
//  Copyright © 2017 Mohamed Marouane YOUSSEF. All rights reserved.
//

import UIKit

class NHAnimatorViewPresenter {
    
    weak private var view : NHAnimatorViewProtocol?
    init(view : NHAnimatorViewProtocol) {
           self.view = view
    }
    
    func prepareImage(_ listVideoImages: [NHImageModel]?) {
        guard let listVideoImages = listVideoImages else {
            return
        }
        var images = [UIImage]()
        images = listVideoImages.map { (model) -> UIImage in
            guard let url = URL(string:model.webformatURL) , let image = UIImage(data: try! Data(contentsOf:url)) else {
                return UIImage()
            }
            return image
        }
        
        self.view?.startAnimation(images)
    }
    
    
    func updateAnimationState() {
        guard let videoState = self.view?.videoState else{
            return
        }
        switch videoState {
        case .play:
             self.view?.videoState = .stop
            break
        default:
             self.view?.videoState = .play
            self.view?.animateImageView()
            
            break
        }
    }

    
}
