//
//  NHVideoPlayerViewController.swift
//  NHTest
//
//  Created by Mohamed Marouane YOUSSEF on 07/10/2017.
//  Copyright © 2017 Mohamed Marouane YOUSSEF. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

enum videoState {
  case play
  case stop
}

protocol NHAnimatorViewProtocol : class {
    var videoState : videoState {get set}
    func startAnimation(_ listImages : [UIImage]?)
    func animateImageView()
}

class NHVideoPlayerViewController: UIViewController {

    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    var listVideoImages :[NHImageModel]?
    let animationDuration: TimeInterval = 0.35
    let switchingInterval: TimeInterval = 3
    var index = 0
    var images = [UIImage]()
    var presenter : NHAnimatorViewPresenter!
    var videoState : videoState = .play
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = NHAnimatorViewPresenter(view: self)
        self.presenter.prepareImage(listVideoImages)
        playBtn.titleLabel?.text = "Pause"
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    func playVideo(){
    
        guard let listVideoImages = listVideoImages, !listVideoImages.isEmpty else {
            return
        }
        
        let listurl = listVideoImages.map { (model) -> URL in
            return URL(string:model.webformatURL)!
        }
        
        let settings = CXEImagesToVideo.videoSettings(codec: AVVideoCodecH264, width:640, height:640)
        let movieMaker = CXEImagesToVideo(videoSettings: settings)
        movieMaker.createMovieFrom(urls: listurl) { (fileURL) in
            let player = AVPlayer(url: fileURL)
            let playerController = AVPlayerViewController()
            playerController.player = player
            playerController.view.frame = self.videoView.bounds
            self.videoView.addSubview(playerController.view)
            player.play()
        }
    }
}

extension NHVideoPlayerViewController {
    
    func animateImageView() {
        
        let animationOptions = [UIViewAnimationOptions.curveEaseInOut,
         UIViewAnimationOptions.curveEaseIn,
         UIViewAnimationOptions.curveEaseOut,
         UIViewAnimationOptions.curveLinear,
         UIViewAnimationOptions.transitionFlipFromLeft,
         UIViewAnimationOptions.transitionFlipFromRight,
         UIViewAnimationOptions.transitionCurlUp,
         UIViewAnimationOptions.transitionCurlDown,
         UIViewAnimationOptions.transitionCrossDissolve,
         UIViewAnimationOptions.transitionFlipFromTop,
         UIViewAnimationOptions.transitionFlipFromBottom]
        
        let typeRandomIndex = Int(arc4random_uniform(UInt32(animationOptions.count)))
        let animationType = animationOptions[typeRandomIndex]
        
        UIView.transition(with: self.imageView, duration: 2.0, options: animationType, animations: {
            self.imageView.image = self.images[self.index]
            
        }, completion: {(bool) in
            guard self.videoState == .play else {
             return
            }
            self.animateImageView()
        })
        
        index = index < images.count - 1 ? index + 1 : 0
    }
    
    @IBAction func playStopAnimation(_ sender: Any) {
        self.presenter.updateAnimationState()
        switch self.videoState {
        case .play:
            playBtn.setTitle("Play", for: .normal)
            break
        default:
            playBtn.setTitle("Pause", for: .normal)
            break
        }
    }
    
    @IBAction func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension NHVideoPlayerViewController : NHAnimatorViewProtocol {
   

    func startAnimation(_ listImages : [UIImage]?){
        
        guard let listImages = listImages , !listImages.isEmpty else{
         return
        }
        
        self.images = listImages
        imageView.image = images[0]
        animateImageView()
    }
}
