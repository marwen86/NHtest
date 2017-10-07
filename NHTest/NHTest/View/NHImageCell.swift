//
//  NHImageCell.swift
//  NHTest
//
//  Created by Mohamed Marouane YOUSSEF on 07/10/2017.
//  Copyright © 2017 Mohamed Marouane YOUSSEF. All rights reserved.
//

import UIKit
protocol NHImageCellDelegate : class {
    func addImageToList(_ imageModel :NHImageModel)
    func removeImageFromList(_ imageModel :NHImageModel)
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
    
    
    override func awakeFromNib() {
    
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.init(red:222/255.0, green:225/255.0, blue:227/255.0, alpha: 1.0).cgColor
    }
    
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
            guard let delegate = delegate , let imageModel = imageModel else {
                return
            }
            
            switch btn.state.rawValue {
            case 5 :
                //notify View to add image
                delegate.addImageToList(imageModel)
                break
            case 1 :
                //notify View to remove image
                delegate.removeImageFromList(imageModel)
                break
            default:
                break
            }
        }
    }
}
