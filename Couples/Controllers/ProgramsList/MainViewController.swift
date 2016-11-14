//
//  MainViewController.swift
//  Couples
//
//  Created by Philip Lee on 1/11/16.
//  Copyright © 2016 Philip Lee. All rights reserved.
//

import UIKit
import AVKit
import SwiftyStoreKit

class MainViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {

    struct CellsID {
        
        static let programCell = "ProgramCell"
    }
    
    /* UI Elements */
    @IBOutlet var collectionView1 : UICollectionView!
    
    /* Data */
    var content: NSArray = []
    
    var playerVC = VideoPlayerViewController()


    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadAllPrograms()
    }
    
    
    // MARK: - Actions
    @IBAction func playIntro(_ sender: AnyObject) {
        
        playerVC.playVideo("https://s3-us-west-2.amazonaws.com/couples-workouts/promo.mp4")
        present(playerVC, animated: true, completion: nil)
    }
    
    @IBAction func restoreAvtion(_ sender: AnyObject) {
        
        SwiftyStoreKit.restorePurchases() { results in

            if results.restoredProductIds.count > 0 {
                
                for productId in results.restoredProductIds{
                    
                    UserDefaults.standard.set(true, forKey: productId)
                    UserDefaults.standard.synchronize()
                }
            }
        }
    }
    
    
    // MARK: - Private
    private func loadAllPrograms() {
        
        RequestManager.defaultManager.getAllPrograms { (programs) in
            
            self.content = programs as NSArray
            self.collectionView1.reloadData()
        }
    }

    
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let programViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProgramViewController") as! ProgramViewController
        programViewController.program = content.object(at: indexPath.row) as! Program

        self.present(programViewController, animated: true, completion: nil)
    }

    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 50
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 50
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0.0, left: 50.0, bottom: 0.0, right: 50.0)
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return content.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let program:Program = content.object(at: indexPath.row) as! Program
        let cell:ProgramCell = collectionView.dequeueReusableCell(withReuseIdentifier: CellsID.programCell, for: indexPath) as! ProgramCell

        cell.featuredImage.image = UIImage(named: program.coverImage!)

        return cell
    }
}
