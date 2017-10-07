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
    func showReachbilityALert()
    func showDownlaodErrorAlert(error : Error)
}

class NHImagesListSearchViewController: UICollectionViewController ,imagesSearchProtocol {

    var resultRequest : NHResultImages?
    var imagesList : [NHImageModel]?
    var presenter : NHSearchImagesPresenter!
    var listVideoImages = [NHImageModel]()
    
    
    fileprivate let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    fileprivate let itemsPerRow: CGFloat = 3
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
    
    func showReachbilityALert() {
        activityIndicator.stopAnimating()
        self.reachbilityALert()
    }
    
    func showDownlaodErrorAlert(error : Error) {
         activityIndicator.stopAnimating()
        self.requestAlertError(error: error)
    }
}

extension NHImagesListSearchViewController {

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        guard let imagesList = imagesList , !imagesList.isEmpty else {
            return 0
        }
        return imagesList.count
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NHImageCell",
                                                      for: indexPath) as! NHImageCell
        
        guard let imagesList = imagesList , !imagesList.isEmpty else {
            return cell
        }
        let imageModel = imagesList[indexPath.row]
        cell.backgroundColor = UIColor.white
   
        cell.delegate = self
        cell.imageModel = imageModel
        return cell
    }
}

extension NHImagesListSearchViewController : UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}

extension NHImagesListSearchViewController : NHImageCellDelegate{
    func addImageToList(_ imageModel: NHImageModel) {
        listVideoImages.append(imageModel)
    }
    
    func removeImageFromList(_ imageModel: NHImageModel) {
        //listVideoImages.remove(object: imageModel)
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
