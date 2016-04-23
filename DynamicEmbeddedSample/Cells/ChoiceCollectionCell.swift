//
//  ChoiceCollectionCell.swift
//  DynamicEmbeddedSample
//
//  Created by Rob Witman on 4/22/16.
//  Copyright © 2016 Splitmo LLC. All rights reserved.
//

import Foundation
import UIKit

class ChoiceCollectionCell : UICollectionViewCell {
    var isHeightCalculated = false
    @IBOutlet var choiceText : DynamicLabel!
    @IBOutlet var labelHorizontalOffset: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.autoresizingMask = [UIViewAutoresizing.FlexibleHeight]
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        isHeightCalculated = false
    }

    override func preferredLayoutAttributesFittingAttributes(layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        // We need to cache our calculation to prevent a crash.
        if !isHeightCalculated {
            setNeedsLayout()
            layoutIfNeeded()
            let width = self.bounds.size.width / 2
            layoutAttributes.size.width = width
            choiceText.preferredMaxLayoutWidth = width - labelHorizontalOffset.constant
            layoutAttributes.size.height = choiceText.intrinsicContentSize().height
            isHeightCalculated = true
        }
        return layoutAttributes
    }
    
    func setText(text : String?) {
        choiceText.text = text ?? ""
    }

}