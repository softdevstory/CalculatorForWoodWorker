//
//  AboutViewController.swift
//  CalculatorForWoodWorker
//
//  Created by developer@softdevstory.net on 2016. 3. 3..
//  Copyright © 2016년 softdevstory. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "About"
    }
}

extension AboutViewController: UITableViewDataSource {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            return tableView.dequeueReusableCellWithIdentifier("support")!
        case 1:
            return tableView.dequeueReusableCellWithIdentifier("softdevstory")!
        default:
            print("wrong indexPath.row \(indexPath.row)")
            assert(false)
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
}

extension AboutViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.row {
        case 0:
            let mailURL = NSURL(string: "mailto:developer@softdevstory.net")!
            if UIApplication.sharedApplication().canOpenURL(mailURL) {
                UIApplication.sharedApplication().openURL(mailURL)
            }
        case 1:
            let webURL = NSURL(string: "http://www.softdevstory.net")!
            if UIApplication.sharedApplication().canOpenURL(webURL) {
                UIApplication.sharedApplication().openURL(webURL)
            }
        default:
            print("wrong indexPath.row \(indexPath.row)")
            assert(false)
        }
    }
}