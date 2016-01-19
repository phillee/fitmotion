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

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func playVideo(videoUrl: String) {
        if player != nil {
            // kill it?
        }

        player = AVPlayer(URL: NSURL(string: videoUrl)!)

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "itemDidFinishPlaying:", name: AVPlayerItemDidPlayToEndTimeNotification, object: nil)

        player?.play()
    }


    func itemDidFinishPlaying(notification: NSNotification) {
        self.dismissViewControllerAnimated(false, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
