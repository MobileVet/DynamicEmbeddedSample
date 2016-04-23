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
    var layoutAgain = true
    
    @IBOutlet var choiceCollectionView: UICollectionView!
    @IBOutlet var collectionHeightConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        choiceCollectionView.scrollEnabled = false
        choiceCollectionView.allowsMultipleSelection = true
    }

    override func bindModel(data: [String : AnyObject]) {
        super.bindModel(data)
        
        if let dictChoices = data["choices"] as! Array<String>? {
            choices = dictChoices
            
            self.contentView.setNeedsLayout()
        }
        choiceCollectionView.reloadData()
    }
    
    override func layoutSubviews() {
        layoutAgain = true
        recursiveLayout()
    }
    
    func recursiveLayout() {
        super.layoutSubviews()
        
        // make sure the collection view updates its cells appropriately
        let flow = choiceCollectionView.collectionViewLayout as! UICollectionViewFlowLayout;
        let width = self.bounds.size.width / 2 - 20
        flow.estimatedItemSize = CGSizeMake(width, 21);
        choiceCollectionView.collectionViewLayout.invalidateLayout()
        
        if layoutAgain {
            layoutAgain = false
            NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(ChoiceTableCell.recursiveLayout), userInfo: nil, repeats: false)
        }
    }
    
    override func systemLayoutSizeFittingSize(targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        
        // at this point, the collection view still has frame based on the ANY size classed storyboard
        choiceCollectionView.frame.size.width = targetSize.width
        choiceCollectionView.frame.size.height = 2000
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
        cell.setText(choices?[indexPath.row])
        return cell
    }

}