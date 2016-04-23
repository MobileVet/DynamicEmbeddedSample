//
//  ListViewController.swift
//  DynamicEmbeddedSample
//
//  Created by Rob Witman on 4/22/16.
//  Copyright © 2016 Splitmo LLC. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController {

    var dataArray : Array<[String:String]>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //// ---- TableView Datasource
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if let item = dataArray?[indexPath.row] {
            let typeString = item["type"] as String!
            cell = tableView.dequeueReusableCellWithIdentifier(typeString, forIndexPath: indexPath)
        }
        return cell
    }
}

