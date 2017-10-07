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
    var listVideoImages :[NHImageModel]?
    
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
        
        var listURl = [URL]()
        for imageModel in listVideoImages {
            guard let url = URL(string:imageModel.webformatURL) else {
                break
            }
            
            listURl.append(url)
        }
        
        let settings = CXEImagesToVideo.videoSettings(codec: AVVideoCodecH264, width:640, height:640)
        let movieMaker = CXEImagesToVideo(videoSettings: settings)
        movieMaker.createMovieFrom(urls: listURl) { (fileURL) in
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
