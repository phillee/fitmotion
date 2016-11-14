//
//  ProgramViewController.swift
//  Couples
//
//  Created by Philip Lee on 1/12/16.
//  Copyright © 2016 Philip Lee. All rights reserved.
//

import UIKit
import AVKit
import SwiftyStoreKit

class ProgramViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    struct CellsID {
        
        static let sectionCell = "SectionCell"
    }
    
    /* UI Elements */
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var programImageView: UIImageView!
    @IBOutlet weak var descriptionView: UITextView!
    @IBOutlet weak var playIntroButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    
    /* Data */
    var isPurchased: Bool = false

    var playerVC = VideoPlayerViewController()
    var program: Program!
    
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    
    // MARK: Private
    private func setup() {
        
        /* Get purchased local status */
        isPurchased = UserDefaults.standard.bool(forKey: program.appleProductId!)
        
        /* Get detail info */
        SwiftyStoreKit.retrieveProductsInfo([program.appleProductId!]) { result in
            
            if let product = result.retrievedProducts.first {
                let priceString = product.localizedPrice!
                
                self.setupPlayButton(pricaString: priceString)
            }
        }
        
        RequestManager.defaultManager.getImageWithURL(imageURL: program.introImage!) { (resultImage) in
            
             self.playIntroButton.setImage(resultImage, for: .normal)
        }
        
        programImageView.image = UIImage(named: program.coverImage!)
        
        descriptionView.textContainer.lineFragmentPadding = 0
        descriptionView.textContainerInset = UIEdgeInsets.zero
        descriptionView.text = program.description
        
        playIntroButton.imageView!.adjustsImageWhenAncestorFocused = true
        playIntroButton.imageView!.clipsToBounds = false
    }
    
    private func setupPlayButton(pricaString: String) {
        
        if isPurchased {
            playButton.setTitle("Play", for: UIControlState.normal)
        }
        else {
            playButton.setTitle(pricaString, for: UIControlState.normal)
        }
    }
    
    private func tryToPlay(section: Section) {
        
        var canPlaySection = section.free
        
        if canPlaySection == false {
            
            canPlaySection = isPurchased
        }
        
        
        if canPlaySection! {
            playerVC.playVideo(section.videoUrl!, seekTime: section.time!)
            present(playerVC, animated: true, completion: nil)
        }
        else {
            
            SwiftyStoreKit.purchaseProduct(program.appleProductId!) { result in
                switch result {
                case .success( _):
                    self.didPurchased()
                case .error(let error):
                    print("Purchase Failed: \(error)")
                }
            }
        }
    }
    
    private func didPurchased() {
        
        setupPlayButton(pricaString: "Play")
        isPurchased = true
        collectionView.reloadData()
        
        UserDefaults.standard.set(true, forKey: program.appleProductId!)
        UserDefaults.standard.synchronize()
    }

    
    // MARK: Actions
    @IBAction func playButtonPressed(_ sender: AnyObject) {
        
        if (isPurchased) {
            
            let section:Section = program.sections.firstObject as! Section
            
            tryToPlay(section: section)
        }
        else {
            
            SwiftyStoreKit.purchaseProduct(program.appleProductId!) { result in
                switch result {
                case .success( _):
                    self.didPurchased()
                case .error(let error):
                    print("Purchase Failed: \(error)")
                }
            }
        }
    }
    
    @IBAction func introButtonPressed(_ sender: AnyObject) {
        
        playerVC.playVideo(program.introUrl!)
        present(playerVC, animated: true, completion: nil)
    }


    // MARK: UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let section:Section = program.sections.object(at: indexPath.row) as! Section
        
        tryToPlay(section: section)
    }


    // MARK: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAtIndex section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 0.0, left: 50.0, bottom: 0.0, right: 50.0)
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return program.sections.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let section:Section     = program.sections.object(at: indexPath.row) as! Section
        let cell:SectionCell    = collectionView.dequeueReusableCell(withReuseIdentifier: CellsID.sectionCell, for: indexPath) as! SectionCell

        
        var isPurchasedProgram = section.free
         
        if isPurchased {
            
            isPurchasedProgram = true
        }
        
        
        cell.setupWithSectionContent(section: section, isPurchased: isPurchasedProgram!)
        

        return cell
    }
}
