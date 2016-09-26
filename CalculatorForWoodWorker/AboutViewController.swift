//
//  AboutViewController.swift
//  CalculatorForWoodWorker
//
//  Created by developer@softdevstory.net on 2016. 3. 3..
//  Copyright © 2016년 softdevstory. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    @IBOutlet weak var versionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "About"

        let versionString = Bundle.main.infoDictionary!["CFBundleShortVersionString"]
        let buildString = Bundle.main.infoDictionary!["CFBundleVersion"]
        
        versionLabel.text = "목공 계산기 \(versionString!) (Build \(buildString!))"
    }
}

extension AboutViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch (indexPath as NSIndexPath).row {
        case 0:
            return tableView.dequeueReusableCell(withIdentifier: "support")!
        case 1:
            return tableView.dequeueReusableCell(withIdentifier: "softdevstory")!
        default:
            print("wrong indexPath.row \((indexPath as NSIndexPath).row)")
            assert(false)
        }
        
        return tableView.dequeueReusableCell(withIdentifier: "support")!
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension AboutViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch (indexPath as NSIndexPath).row {
        case 0:
            let mailURL = URL(string: "mailto:developer@softdevstory.net")!
            if UIApplication.shared.canOpenURL(mailURL) {
                UIApplication.shared.openURL(mailURL)
            }
        case 1:
            let webURL = URL(string: "http://www.softdevstory.net")!
            if UIApplication.shared.canOpenURL(webURL) {
                UIApplication.shared.openURL(webURL)
            }
        default:
            print("wrong indexPath.row \((indexPath as NSIndexPath).row)")
            assert(false)
        }
    }
}
