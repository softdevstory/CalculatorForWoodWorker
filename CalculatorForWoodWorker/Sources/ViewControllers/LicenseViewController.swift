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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch (indexPath as NSIndexPath).row {
        case 0:
            let webURL = URL(string: "https://icons8.com")!
            if UIApplication.shared.canOpenURL(webURL) {
                UIApplication.shared.openURL(webURL)
            }
        case 1:
            let webURL = URL(string: "https://pixabay.com/")!
            if UIApplication.shared.canOpenURL(webURL) {
                UIApplication.shared.openURL(webURL)
            }
        default:
            print("Wrong indexPath.row \((indexPath as NSIndexPath).row)")
            assert(false)
        }
    }
}
