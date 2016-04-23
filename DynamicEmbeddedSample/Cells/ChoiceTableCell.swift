//
//  ChoiceTableCell.swift
//  DynamicEmbeddedSample
//
//  Created by Rob Witman on 4/22/16.
//  Copyright © 2016 Splitmo LLC. All rights reserved.
//

import Foundation
import UIKit

class ChoiceTableCell : ListTableCell {
    
    var choices : Array<String>?
    
    @IBOutlet var ChoiceCollectionView: UICollectionView!
    
    override func bindModel(data: [String : AnyObject]) {
        super.bindModel(data)
        
        if let dictChoices = data["choices"] as! Array<String>? {
            choices = dictChoices
        }
    }
}