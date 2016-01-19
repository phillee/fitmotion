//
//  MainViewController.swift
//  Couples
//
//  Created by Philip Lee on 1/11/16.
//  Copyright © 2016 Philip Lee. All rights reserved.
//

import UIKit
import AVKit
import StoreKit

class MainViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UIScrollViewDelegate {

    @IBOutlet var scrollView : UIScrollView!
    @IBOutlet var collectionView1 : UICollectionView!
    @IBOutlet var introVideoView : UIView!

    let reuseIdentifierFeatured = "FeaturedCell"
    let introVideoUrl = "https://s3-us-west-2.amazonaws.com/couples-workouts/promo.mp4"

    var player = AVPlayer()
    var playerLayer = AVPlayerLayer()

    override func viewDidLoad() {
        super.viewDidLoad()
//        initVideo()

       let productIdentifiers: Set<ProductIdentifier>
        var purchasedProductIdentifiers = Set<ProductIdentifier>()

        // Used by SKProductsRequestDelegate
        var productsRequest: SKProductsRequest?
        var completionHandler: RequestProductsCompletionHandler?

    }

    @IBAction func playIntro(sender: AnyObject) {
        let playerVC = VideoPlayerViewController()
        playerVC.playVideo(introVideoUrl)
        [self.presentViewController(playerVC, animated: true, completion: nil)]
    }

    func initVideo() {
        player = AVPlayer(URL: NSURL(string: introVideoUrl)!)

        playerLayer = AVPlayerLayer(player: player)
        introVideoView.layer.addSublayer(playerLayer)
        playerLayer.frame = introVideoView.bounds
    }

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let programVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ProgramViewController") as! ProgramViewController
        programVC.programData = ProgramData.CouplesWorkouts[indexPath.item]

        [self.presentViewController(programVC, animated: true, completion: nil)]
    }

    // Collection View rendering
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 50
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 50
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
        if (collectionView == self.collectionView1)
        {
            return ProgramData.CouplesWorkouts.count
        }

        return 0
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {

        if (collectionView == self.collectionView1)
        {
            let cell : FeaturedCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(self.reuseIdentifierFeatured, forIndexPath: indexPath) as! FeaturedCollectionViewCell

            let programData = ProgramData.CouplesWorkouts[indexPath.item]
            cell.featuredImage.image = UIImage(named: programData.coverImage)

            return cell
        }

        return UICollectionViewCell()
    }
}