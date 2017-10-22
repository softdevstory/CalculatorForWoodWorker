//
//  SettingViewController.swift
//  CalculatorForWoodWorker
//
//  Created by HS Song on 2017. 5. 30..
//  Copyright © 2017년 softdevstory. All rights reserved.
//

import UIKit

import Then
import RxSwift
import RxCocoa
import SnapKit

class SettingViewController: UIViewController {

    private let bag = DisposeBag()

    private var logoImageView = UIImageView(image: UIImage(named: "applogo"))
    
    private var versionLabel = UILabel().then {
        let appName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
        let versionString = Bundle.main.infoDictionary!["CFBundleShortVersionString"]
        let buildString = Bundle.main.infoDictionary!["CFBundleVersion"]
        
        $0.text = "\(appName!) \(versionString!) (Build \(buildString!))"
        $0.textAlignment = .center
    }
    
    private var ownerLabel = UILabel().then {
        $0.text = "softdevstory.net"
        $0.textAlignment = .center
    }
    
    private var tableView: UITableView!

    override func viewDidLoad() {
        title = "settings".localized
        view.backgroundColor = UIColor.groupTableViewBackground
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: nil)
        navigationItem.rightBarButtonItem?.rx.tap
            .subscribe(onNext: { _ in
                self.dismiss(animated: true, completion: nil)
            })
            .disposed(by: bag)
        
        view.addSubview(logoImageView)
        view.addSubview(versionLabel)
        view.addSubview(ownerLabel)
        
        tableView = UITableView(frame: view.frame, style: .grouped).then {
            $0.separatorStyle = .none
            $0.keyboardDismissMode = .onDrag
            $0.dataSource = self
            
            // same works like iOS 10
            $0.estimatedRowHeight = 0

            $0.register(UITableViewCell.self, forCellReuseIdentifier: "Basic")
        }

        tableView.rx.itemSelected
            .subscribe(onNext: { indexPath in
                let urlString = cellProperties[indexPath.section][indexPath.row][1]
                if let url = URL(string: urlString) {
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.openURL(url)
                    }
                }
            })
            .disposed(by: bag)
        
        view.addSubview(tableView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        logoImageView.snp.makeConstraints { maker in
            maker.width.equalTo(76)
            maker.height.equalTo(76)
            maker.top.equalTo(self.topLayoutGuide.snp.bottom).offset(20)
            maker.centerX.equalTo(self.view.snp.centerX)
        }
        
        versionLabel.snp.makeConstraints { maker in
            maker.top.equalTo(logoImageView.snp.bottom).offset(8)
            maker.right.equalTo(self.view).offset(-20)
            maker.left.equalTo(self.view).offset(20)
            maker.centerX.equalTo(self.view.snp.centerX)
        }
        
        ownerLabel.snp.makeConstraints { maker in
            maker.top.equalTo(versionLabel.snp.bottom).offset(8)
            maker.right.equalTo(self.view).offset(-20)
            maker.left.equalTo(self.view).offset(20)
            maker.centerX.equalTo(self.view.snp.centerX)
        }
        
        tableView.snp.makeConstraints { maker in
            maker.top.equalTo(ownerLabel.snp.bottom).offset(8)
            maker.right.equalTo(self.view)
            maker.left.equalTo(self.view)
            maker.bottom.equalTo(self.view)
        }
    }
}


// MARK: Contents of table
fileprivate let titleForHeaders = [
    "About",
    "Licenses"
]

fileprivate let cellProperties = [
    [
        ["contact", "mailto:developer@softdevstory.net"],
        ["softdevstory.net", "http://www.softdevstory.net"],
    ],
    [
        ["SnapKit", "https://github.com/SnapKit/SnapKit/blob/develop/LICENSE"],
        ["RxSwift, RxCocoa", "https://github.com/ReactiveX/RxSwift/blob/master/LICENSE.md"],
        ["Then", "https://github.com/devxoul/Then/blob/master/LICENSE"],
        ["Icons from icons8", "https://icons8.com/license/"],
        ["Images from pixabay", "https://pixabay.com"],
        
    ]
]

// MARK: UITableViewDataSource
extension SettingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard section < titleForHeaders.count else { return nil }

        return titleForHeaders[section].localized
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return titleForHeaders.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard section < cellProperties[section].count else { return 0 }
        
        return cellProperties[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Basic")!
        
        cell.textLabel?.text = cellProperties[indexPath.section][indexPath.row][0].localized
        cell.accessoryType = .disclosureIndicator

        return cell
    }
}
