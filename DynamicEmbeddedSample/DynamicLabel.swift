//
//  DynamicLabel.swift
//  DynamicEmbeddedSample
//
//  Created by Rob Witman on 4/23/16.
//  Copyright © 2016 Splitmo LLC. All rights reserved.
//

import Foundation
import UIKit

@objc class DynamicLabel: UILabel {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        preferredMaxLayoutWidth = bounds.width
        super.layoutSubviews()
    }
}
