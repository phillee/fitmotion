//
//  ThumbnailCell.swift
//  Couples
//
//  Created by Philip Lee on 1/15/16.
//  Copyright © 2016 Philip Lee. All rights reserved.
//

import UIKit

class SectionCell: UICollectionViewCell {
    
    /* UI Elements */
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    
    // MARK: Lifecycle
    override func awakeFromNib() {
        
        self.image.alpha = 0.6
    }
    
    override func prepareForReuse() {
        
        self.image.alpha = 0.6
        self.image.image = nil
    }
    
    
    // MARK: Public
    func setupWithSectionContent(section: Section, isPurchased: Bool) {
        
        self.label.text = section.name
        
        if isPurchased {
            
            self.image.alpha = 1
        }
        
        RequestManager.defaultManager.getImageWithURL(imageURL: section.thumbnail!) { (resultImage) in
            
            self.image.image = resultImage
        }
    }
}
