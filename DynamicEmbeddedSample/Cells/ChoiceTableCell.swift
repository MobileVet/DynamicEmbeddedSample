//
//  ChoiceTableCell.swift
//  DynamicEmbeddedSample
//
//  Created by Rob Witman on 4/22/16.
//  Copyright © 2016 Splitmo LLC. All rights reserved.
//

import Foundation
import UIKit

class ChoiceTableCell : ListTableCell, UICollectionViewDataSource {
    
    var choices : Array<String>?
    
    @IBOutlet var choiceCollectionView: UICollectionView!
    @IBOutlet var collectionHeightConstraint: NSLayoutConstraint!
    
    override func bindModel(data: [String : AnyObject]) {
        super.bindModel(data)
        
        if let dictChoices = data["choices"] as! Array<String>? {
            choices = dictChoices
            
            self.contentView.setNeedsLayout()
        }
    }
    
    override func systemLayoutSizeFittingSize(targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        
        // at this point, the collection view still has frame based on the ANY size classed storyboard
        choiceCollectionView.frame.size.width = targetSize.width
        choiceCollectionView.frame.size.height = 2000 // CGRectMake(0,0,targetSize.width,2000)
        choiceCollectionView.layoutIfNeeded()
        
        let newCollectionHeight = choiceCollectionView.collectionViewLayout.collectionViewContentSize().height
        collectionHeightConstraint.constant = newCollectionHeight
        
        let s = super.systemLayoutSizeFittingSize(targetSize, withHorizontalFittingPriority: horizontalFittingPriority, verticalFittingPriority : verticalFittingPriority)
        return s
    }

    //// CollectionView Data Source
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return choices?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("choiceCollectionCell", forIndexPath: indexPath) as! ChoiceCollectionCell
        cell.choiceText.text = choices?[indexPath.row]
        return cell
    }

}