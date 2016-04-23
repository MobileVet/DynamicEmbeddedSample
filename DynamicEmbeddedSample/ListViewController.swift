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
    
    var staticData : Array<Array<[String:AnyObject]>> = Array()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        // build out some test data to swap in and out for testing the layout
        staticData.append([["type":"listCell","name":"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed d"],
                     ["type":"listCell","name":"Ut enim ad minim"],
                     ["type":"choiceCell","name":"ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in","choices":["Not Applicable","Yes","No","I don't really want to answer","Maybe","Yesterday"]],
                     ["type":"listCell","name":"reprehenderit in voluptate velit esse cillum dolore eu"]])
        
        staticData.append([["type":"listCell","name":"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."],
                     ["type":"choiceCell","name":"ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis","choices":["Yes","No","Maybe"]],
                     ["type":"listCell","name":"reprehenderit in voluptate velit esse cillum dolore eu"],
                     ["type":"listCell","name":"sunt in culpa qui officia"]])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func refreshDataPressed(sender: UIButton) {
        if let data = dataArray as Array<[String:AnyObject]>? {
            dataArray = (data == staticData[0]) ? staticData[1] : staticData[0]
        }
        else {
            dataArray = staticData[0]
        }
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

