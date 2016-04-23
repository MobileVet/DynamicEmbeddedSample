//
//  ListViewController.swift
//  DynamicEmbeddedSample
//
//  Created by Rob Witman on 4/22/16.
//  Copyright © 2016 Splitmo LLC. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController {

    var dataArray : Array<[String:AnyObject]>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func refreshDataPressed(sender: UIButton) {
        dataArray = [["type":"listCell","name":"This is a short option"],
                     ["type":"listCell","name":"This is a short longer optional text about stuff"],
                     ["type":"choiceCell","name":"This is a choice cell with some header text","choices":["Not Applicable","Yes","No","I don't really want to answer","Maybe","Yesterday"]],
                     ["type":"listCell","name":"This is a short option"]]
        tableView.reloadData()
    }
    
    //// ---- TableView Datasource
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let item = dataArray?[indexPath.row] {
            if let typeString = item["type"] as? String! {
                let cell = tableView.dequeueReusableCellWithIdentifier(typeString, forIndexPath: indexPath) as! ListTableCell
                cell.bindModel(item)
                cell.contentView.backgroundColor = (indexPath.row % 2 == 1) ? UIColor.grayColor() : UIColor.whiteColor()
                return cell
            }
        }
        return UITableViewCell()
    }
}

