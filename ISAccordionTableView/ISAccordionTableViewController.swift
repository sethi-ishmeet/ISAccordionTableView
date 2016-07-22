//
//  ISAccordionTableViewController.swift
//  ISAccordionTableView
//
//  Created by Ishmeet Singh Sethi on 2016-07-21.
//  Copyright © 2016 Ishmeet. All rights reserved.
//

import UIKit

class ISAccordionTableViewController: UITableViewController {
    var cellDescriptors = [NSMutableDictionary]()
    var visibleRows = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cellDescriptors = [
            [
                "cellIdentifier" : "normalCell",
                "isExpandable" : false,
                "isExpanded" : false,
                "isVisible" : true,
                "additionalRows" : 0
            ],
            [
                "cellIdentifier" : "expandableCell",
                "isExpandable" : true,
                "isExpanded" : false,
                "isVisible" : true,
                "additionalRows" : 3
            ],
            [
                "cellIdentifier" : "nestedCell",
                "isExpandable" : false,
                "isExpanded" : false,
                "isVisible" : false,
                "additionalRows" : 0
            ],
            [
                "cellIdentifier" : "nestedCell",
                "isExpandable" : false,
                "isExpanded" : false,
                "isVisible" : false,
                "additionalRows" : 0
            ],
            [
                "cellIdentifier" : "nestedCell",
                "isExpandable" : false,
                "isExpanded" : false,
                "isVisible" : false,
                "additionalRows" : 0
            ],
            [
                "cellIdentifier" : "normalCell",
                "isExpandable" : false,
                "isExpanded" : false,
                "isVisible" : true,
                "additionalRows" : 0
            ],
            [
                "cellIdentifier" : "expandableCell",
                "isExpandable" : true,
                "isExpanded" : false,
                "isVisible" : true,
                "additionalRows" : 3
            ],
            [
                "cellIdentifier" : "nestedCell",
                "isExpandable" : false,
                "isExpanded" : false,
                "isVisible" : false,
                "additionalRows" : 0
            ],
            [
                "cellIdentifier" : "nestedCell",
                "isExpandable" : false,
                "isExpanded" : false,
                "isVisible" : false,
                "additionalRows" : 0
            ],
            [
                "cellIdentifier" : "nestedCell",
                "isExpandable" : false,
                "isExpanded" : false,
                "isVisible" : false,
                "additionalRows" : 0
            ],
            [
                "cellIdentifier" : "normalCell",
                "isExpandable" : false,
                "isExpanded" : false,
                "isVisible" : true,
                "additionalRows" : 0
            ]
        ]
        
        getIndicesOfVisibleRows()
    }

    func getIndicesOfVisibleRows() -> Void {
        visibleRows.removeAll()
        for cellIndex in 0..<cellDescriptors.count {
            if (cellDescriptors[cellIndex]["isVisible"] as! Bool) == true {
                visibleRows.append(cellIndex)
            }
        }
    }
    
    func getCellDescriptorForIndexPath(indexPath: NSIndexPath) -> NSDictionary {
        return cellDescriptors[visibleRows[indexPath.row]]
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return visibleRows.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellDesc = getCellDescriptorForIndexPath(indexPath)
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellDesc["cellIdentifier"] as! String, forIndexPath: indexPath)
        return cell
    }
    
    // MARK : - Table view delegate methods
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let indexOfTappedRow = visibleRows[indexPath.row]
        var indexPaths = [NSIndexPath]()
        let cell = self.tableView.cellForRowAtIndexPath(indexPath)
        
        if cell?.reuseIdentifier == "expandableCell" {
            if cellDescriptors[indexOfTappedRow]["isExpandable"] as! Bool == true {
                var shouldExpand = false
                
                if cellDescriptors[indexOfTappedRow]["isExpanded"] as! Bool == false {
                    shouldExpand = true
                }
                
                cellDescriptors[indexOfTappedRow]["isExpanded"] = shouldExpand
                
                for i in (indexOfTappedRow + 1)...(indexOfTappedRow + (cellDescriptors[indexOfTappedRow]["additionalRows"] as! Int)) {
                    cellDescriptors[i]["isVisible"] = shouldExpand
                }
                
                for i in 1...(cellDescriptors[indexOfTappedRow]["additionalRows"] as! Int) {
                    indexPaths.append(NSIndexPath(forRow: indexPath.row + i, inSection: indexPath.section))
                }
                
                getIndicesOfVisibleRows()
                self.tableView.beginUpdates()
                if shouldExpand {
                    self.tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.Fade)
                }
                else {
                    self.tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.Fade)
                }
                self.tableView.endUpdates()
            }
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60.0
    }
   
}
