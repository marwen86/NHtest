//
//  NHImagesLIstSearchViewController.swift
//  NHTest
//
//  Created by Mohamed Marouane YOUSSEF on 07/10/2017.
//  Copyright © 2017 Mohamed Marouane YOUSSEF. All rights reserved.
//

import UIKit
protocol imagesSearchProtocol : class {
    
    func refreshView(_ resultList: NHResultImages?)
}

class NHImagesListSearchViewController: UICollectionViewController ,imagesSearchProtocol {

    var resultRequest : NHResultImages?
    var imagesList : [NHImageModel]?
    var presenter : NHSearchImagesPresenter!
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension NHImagesListSearchViewController {
    func refreshView(_ resultRequest: NHResultImages?) {
        
        guard let resultRequest = resultRequest else {
            return
        }
        activityIndicator.stopAnimating()
        self.resultRequest = resultRequest
        self.imagesList = resultRequest.hits
        //reload View
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
        guard  let url = URL(string:imageModel.previewURL) else {
             // add empty image
            return cell
        }
        cell.imageView.vsc_setImage(withURL: url)
        
        return cell
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
