//
//  ProgramViewController.swift
//  Couples
//
//  Created by Philip Lee on 1/12/16.
//  Copyright © 2016 Philip Lee. All rights reserved.
//

import UIKit
import AVKit

class ProgramViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var introVideoView: UIView!
    @IBOutlet weak var descriptionView: UITextView!
    @IBOutlet weak var introImage: UIImageView!
    @IBOutlet weak var playIntroButton: UIButton!

    let reuseIdentifierThumbnail = "ThumbnailCell"
    let introVideoUrl = "https://s3-us-west-2.amazonaws.com/couples-workouts/strength-intro.mp4"

    var player: AVPlayer!
    var playerLayer: AVPlayerLayer!
    var programData: ProgramData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.descriptionView.textContainer.lineFragmentPadding = 0
        self.descriptionView.textContainerInset = UIEdgeInsetsZero
        playIntroButton.imageView!.adjustsImageWhenAncestorFocused = true
        playIntroButton.imageView!.clipsToBounds = false

//        initVideo()
//        player.play()
    }

    @IBAction func playButtonPressed(sender: AnyObject) {
    }
    
    @IBAction func introButtonPressed(sender: AnyObject) {
        let playerVC = VideoPlayerViewController()
        playerVC.playVideo(introVideoUrl)
        [self.presentViewController(playerVC, animated: true, completion: nil)]
    }

//    func initVideo() {
//        player = AVPlayer(URL: NSURL(string: introVideoUrl)!)
//
//        playerLayer = AVPlayerLayer(player: player)
//        playerLayer.frame = introVideoView.bounds
//        introVideoView.layer.addSublayer(playerLayer)
//    }


    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let playerVC = VideoPlayerViewController()
        let data = programData.sectionData[indexPath.item]
        playerVC.playVideo(data.videoUrl)
        [self.presentViewController(playerVC, animated: true, completion: nil)]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Collection View rendering
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 10
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 10
    }

    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAtIndex section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 0.0, left: 50.0, bottom: 0.0, right: 50.0)
    }

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if (collectionView == self.collectionView)
        {
            return programData.sectionData.count
        }

        return 0
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {

        if (collectionView == self.collectionView)
        {
            let cell : ThumbnailCell = collectionView.dequeueReusableCellWithReuseIdentifier(self.reuseIdentifierThumbnail, forIndexPath: indexPath) as! ThumbnailCell

            let data = programData.sectionData[indexPath.item]

            let imageFilename = data.image
            cell.image.image = UIImage(named: imageFilename)
            cell.label.text = data.name.uppercaseString

            return cell
        }
        
        return UICollectionViewCell()
    }
}
