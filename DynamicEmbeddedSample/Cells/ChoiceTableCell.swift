//
//  ChoiceTableCell.swift
//  DynamicEmbeddedSample
//
//  Created by Rob Witman on 4/22/16.
//  Copyright © 2016 Splitmo LLC. All rights reserved.
//

import Foundation
import UIKit

class ChoiceTableCell : ListTableCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var choices : Array<String>?
    let columnNum: CGFloat = 2 // use number of columns instead of a static maximum cell width
    var cellWidth: CGFloat = 0 //
    var sizingCell : ChoiceCollectionCell!
    
    @IBOutlet var choiceCollectionView: UICollectionView!
    @IBOutlet var collectionHeightConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        choiceCollectionView.scrollEnabled = false
        choiceCollectionView.allowsMultipleSelection = true
        
        if let flowLayout = choiceCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10) //could not set in storyboard, don't know why
        }
    }

    override func bindModel(data: [String : AnyObject]) {
        super.bindModel(data)
        
        if let dictChoices = data["choices"] as! Array<String>? {
            choices = dictChoices
            
            self.contentView.setNeedsLayout()
        }
        
        sizingCell = choiceCollectionView.dequeueReusableCellWithReuseIdentifier("choiceCollectionCell", forIndexPath: NSIndexPath(forItem: 0, inSection: 0)) as? ChoiceCollectionCell
        choiceCollectionView.reloadData()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        if let flowLayout = choiceCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let spaceBetweenCells = flowLayout.minimumInteritemSpacing * (columnNum - 1)
            let totalCellAvailableWidth = self.bounds.size.width - flowLayout.sectionInset.left - flowLayout.sectionInset.right - spaceBetweenCells - 20
            cellWidth = floor(totalCellAvailableWidth / columnNum);
        }
        
        //recalculate the collection view layout when the view layout changes
        choiceCollectionView.collectionViewLayout.invalidateLayout()
        
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

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        if sizingCell != nil  {
        let cellMargins = sizingCell.layoutMargins.left + sizingCell.layoutMargins.right
        sizingCell.setText(choices?[indexPath.row])
        sizingCell.choiceText.preferredMaxLayoutWidth = cellWidth - cellMargins - sizingCell.labelHorizontalOffset.constant
        sizingCell.labelWidthConstraint.constant = cellWidth - cellMargins - sizingCell.labelHorizontalOffset.constant
        return sizingCell.contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize) //apply auto layout and retrieve the size of the cell
        }
        return CGSizeZero
    }
}