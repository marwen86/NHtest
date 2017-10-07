//
//  NHImagesLIstSearchViewController.swift
//  NHTest
//
//  Created by Mohamed Marouane YOUSSEF on 07/10/2017.
//  Copyright © 2017 Mohamed Marouane YOUSSEF. All rights reserved.
//
import Foundation
import AVFoundation
import UIKit
import AVKit
protocol imagesSearchProtocol : class {
    
    func refreshView(_ resultList: NHResultImages?)
}

class NHImagesListSearchViewController: UICollectionViewController ,imagesSearchProtocol {

    var resultRequest : NHResultImages?
    var imagesList : [NHImageModel]?
    var presenter : NHSearchImagesPresenter!
    var listVideoImages = [UIImage]()
    var activityIndicator : UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = NHSearchImagesPresenter(view: self)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "VideoPlayerSegue") {
            // pass data to next view
            let videoVC = segue.destination as! NHVideoPlayerViewController
            videoVC.listVideoImages = self.listVideoImages
        }
    }

}

extension NHImagesListSearchViewController {
    func refreshView(_ resultRequest: NHResultImages?) {
        
        guard let resultRequest = resultRequest else {
            return
        }
        activityIndicator.stopAnimating()
        self.resultRequest = resultRequest
        self.imagesList = resultRequest.hits
        self.collectionView?.reloadData()

    }
}


extension NHImagesListSearchViewController {

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        guard let imagesList = imagesList else {
            return 0
        }
        return imagesList.count
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NHImageCell",
                                                      for: indexPath) as! NHImageCell
        
        guard let imagesList = imagesList else {
            return cell
        }
        let imageModel = imagesList[indexPath.row]
        cell.backgroundColor = UIColor.white
   
        cell.delegate = self
        cell.imageModel = imageModel
        return cell
    }
}
extension NHImagesListSearchViewController : NHImageCellDelegate{
    func addImageToList(_ image :UIImage) {
        listVideoImages.append(image)
    }
    
    func removeImageFromList(_ image :UIImage) {
        listVideoImages.remove(object: image)
    }
}
extension NHImagesListSearchViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        
        textField.addSubview(activityIndicator)
        activityIndicator.frame = textField.bounds
        activityIndicator.startAnimating()
        guard let query = textField.text else {
          //message empty text
            return true
        }
       
        self.presenter.loadImages(query)
        
        textField.text = nil
        textField.resignFirstResponder()
   
        return true
    }
}
