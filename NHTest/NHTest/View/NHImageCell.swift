//
//  NHImageCell.swift
//  NHTest
//
//  Created by Mohamed Marouane YOUSSEF on 07/10/2017.
//  Copyright © 2017 Mohamed Marouane YOUSSEF. All rights reserved.
//

import UIKit
protocol NHImageCellDelegate : class {
    func addImageToList(_ image :UIImage)
    func removeImageFromList(_ image :UIImage)
}

class NHImageCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var selectBtn: UIButton!
    var imageModel :NHImageModel?{
        didSet {
         updateView()
        }
    }
    weak var  delegate: NHImageCellDelegate?
    
    func updateView() {
        guard let imageModel = imageModel, let url = URL(string:imageModel.previewURL) else {
            // add empty image
            return
        }
        imageView.vsc_setImage(withURL: url)
    }
    
    @IBAction func selectImage(_ sender: Any) {
        if let btn = sender as? UIButton {
            
            btn.isSelected = !btn.isSelected
            guard let delegate = delegate , let image = imageView.image else {
                return
            }
            
            switch btn.state.rawValue {
            case 5 :
                //notify View to add image
                delegate.addImageToList(image)
                break
            case 1 :
                //notify View to remove image
                delegate.removeImageFromList(image)
                break
            default:
                break
            }
        }
    }
}
