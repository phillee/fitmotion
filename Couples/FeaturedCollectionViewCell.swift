//
//  FeaturedCollectionViewCell.swift
//  Couples
//
//  Created by Philip Lee on 1/11/16.
//  Copyright © 2016 Philip Lee. All rights reserved.
//

import UIKit

class FeaturedCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var featuredImage: UIImageView!

    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.commonInit()
    }

    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }

    fileprivate func commonInit()
    {
        // Initialization code

        self.layoutIfNeeded()
        self.layoutSubviews()
        self.setNeedsDisplay()
    }

    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        if (self.isFocused)
        {
            self.featuredImage.adjustsImageWhenAncestorFocused = true
        }
        else
        {
            self.featuredImage.adjustsImageWhenAncestorFocused = false
        }
    }

    override func layoutSubviews()
    {
        super.layoutSubviews()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }

}
