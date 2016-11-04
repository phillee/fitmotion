//
//  VideoPlayerViewController.swift
//  Couples
//
//  Created by Philip Lee on 1/12/16.
//  Copyright © 2016 Philip Lee. All rights reserved.
//

import UIKit
import AVKit

class VideoPlayerViewController: AVPlayerViewController {

    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func itemDidFinishPlaying(_ notification: Notification) {
        
        self.dismiss(animated: false, completion: nil)
    }
    
    
    // MARK: Public
    public func playVideo(_ videoUrl: String, seekTime:Double) {

        player = AVPlayer(url: URL(string: videoUrl)!)

        NotificationCenter.default.addObserver(self, selector: #selector(VideoPlayerViewController.itemDidFinishPlaying(_:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)

        player?.seek(to: CMTimeMake(Int64(seekTime), 1))
        player?.play()
    }
    
    public func playVideo(_ videoUrl: String) {
        
        player = AVPlayer(url: URL(string: videoUrl)!)
        
        NotificationCenter.default.addObserver(self, selector: #selector(VideoPlayerViewController.itemDidFinishPlaying(_:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
        
        player?.play()
    }
}
