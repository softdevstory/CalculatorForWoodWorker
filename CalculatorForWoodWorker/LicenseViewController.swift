//
//  LicenseViewController.swift
//  CalculatorForWoodWorker
//
//  Created by developer@softdevstory.net on 2016. 3. 3..
//  Copyright © 2016년 softdevstory. All rights reserved.
//

import UIKit

class LicenseViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "라이센스"
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.row {
        case 0:
            let webURL = NSURL(string: "https://icons8.com")!
            if UIApplication.sharedApplication().canOpenURL(webURL) {
                UIApplication.sharedApplication().openURL(webURL)
            }
        case 1:
            let webURL = NSURL(string: "https://pixabay.com/")!
            if UIApplication.sharedApplication().canOpenURL(webURL) {
                UIApplication.sharedApplication().openURL(webURL)
            }
        default:
            print("Wrong indexPath.row \(indexPath.row)")
            assert(false)
        }
    }
}