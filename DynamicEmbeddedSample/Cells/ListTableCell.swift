//
//  ListTableCell.swift
//  DynamicEmbeddedSample
//
//  Created by Rob Witman on 4/22/16.
//  Copyright © 2016 Splitmo LLC. All rights reserved.
//

import Foundation
import UIKit

class ListTableCell : UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    func bindModel(data : [String:AnyObject]) {
        if let name = data["name"] as! String? {
            nameLabel.text = name
        }
    }
}