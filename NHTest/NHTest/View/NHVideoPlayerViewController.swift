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

class NHVideoPlayerViewController: UIViewController {

    @IBOutlet weak var videoView: UIView!
    var listVideoImages :[UIImage]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       playVideo()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func playVideo(){
    
        guard let listVideoImages = listVideoImages, !listVideoImages.isEmpty else {
            return
        }
        
        let settings = CXEImagesToVideo.videoSettings(codec: AVVideoCodecH264, width: (listVideoImages[0].cgImage?.width)!, height: (listVideoImages[0].cgImage?.height)!)
        let movieMaker = CXEImagesToVideo(videoSettings: settings)
        movieMaker.createMovieFrom(images: listVideoImages){ (fileURL:URL) in
            
            let player = AVPlayer(url: fileURL)
            let playerController = AVPlayerViewController()
            playerController.player = player
            playerController.view.frame = self.videoView.bounds
            self.videoView.addSubview(playerController.view)
            player.play()
        }
    }
    
    @IBAction func dismiss() {
     self.dismiss(animated: true, completion: nil)
    }
}
