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
    @IBOutlet var choiceText : UILabel!
    @IBOutlet var labelHorizontalOffset: NSLayoutConstraint!
    @IBOutlet var labelWidthConstraint: NSLayoutConstraint!
    
    func setText(text : String?) {
        choiceText.text = text ?? ""
    }

}