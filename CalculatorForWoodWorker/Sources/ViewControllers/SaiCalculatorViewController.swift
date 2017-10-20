//
//  SaiCalculatorViewController.swift
//  CalculatorForWoodWorker
//
//  Created by HS Song on 2017. 5. 30..
//  Copyright © 2017년 softdevstory. All rights reserved.
//

import UIKit

import Then
import SnapKit
import RxSwift
import RxCocoa

class SaiCalculatorViewController: UIViewController {

    fileprivate let bag = DisposeBag()
    
    private var tableView: UITableView!
    
    fileprivate let viewModel = SaiCalculatorViewModel()

    override func viewDidLoad() {
        title = "SaiCalculatorNavigationTitle".localized

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "settings"), style: .plain, target: nil, action: nil)

        navigationItem.rightBarButtonItem?.rx.tap
            .subscribe(onNext: { _ in
                let vc = UINavigationController(rootViewController: SettingViewController())
                self.present(vc, animated: true, completion: nil)
            })
            .disposed(by: bag)
        
        tableView = UITableView(frame: view.frame, style: .grouped).then {
            $0.separatorStyle = .none
            $0.keyboardDismissMode = .onDrag
            $0.allowsSelection = false
            $0.dataSource = self
            
            $0.register(NumberInputCell.self, forCellReuseIdentifier: "NumberInputCell")
            $0.register(CalculationResultCell.self, forCellReuseIdentifier: "CalculationResultCell")
        }
        
        view.addSubview(tableView)
    }

    }

// MARK: Contents of table
fileprivate let titleForHeaders = [
    "WoodDimension",
    "CalculationResult"
]

fileprivate let cellIdentifiers = [
    [
        "NumberInputCell",
        "NumberInputCell",
        "NumberInputCell",
        "NumberInputCell"
    ],
    [
        "CalculationResultCell",
        "CalculationResultCell"
    ]
]

fileprivate let cellProperties = [
    [
        ["width", "mm"],
        ["height", "mm"],
        ["length", "mm"],
        ["pricePerSai", "won"]
    ],
    [
        ["totalVolume", "sai"],
        ["totalPrice", "won"]
    ]
]

// MARK: UITableViewDataSource
extension SaiCalculatorViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard section < titleForHeaders.count else { return nil }

        return titleForHeaders[section].localized
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return titleForHeaders.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard section < cellIdentifiers[section].count else { return 0 }
        
        return cellIdentifiers[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifiers[indexPath.section][indexPath.row])!

        var labels = cell as! LabelCellProtocol
        
        labels.name = cellProperties[indexPath.section][indexPath.row][0].localized
        labels.unit = cellProperties[indexPath.section][indexPath.row][1].localized
        
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            (cell as! NumberInputCell).number
                .asObservable()
                .bind(to: viewModel.width)
                .disposed(by: bag)
        case (0, 1):
            (cell as! NumberInputCell).number
                .asObservable()
                .bind(to: viewModel.height)
                .disposed(by: bag)
        case (0, 2):
            (cell as! NumberInputCell).number
                .asObservable()
                .bind(to: viewModel.length)
                .disposed(by: bag)
        case (0, 3):
            (cell as! NumberInputCell).number
                .asObservable()
                .bind(to: viewModel.pricePerSai)
                .disposed(by: bag)
        case (1, 0):
            viewModel.totalSai.asObservable()
                .subscribe(onNext: { value in
                    (cell as! CalculationResultCell).number = value
                })
                .disposed(by: bag)
        case (1, 1):
            viewModel.totalPrice.asObservable()
                .subscribe(onNext: { value in
                    (cell as! CalculationResultCell).number = Double(value)
                })
                .disposed(by: bag)
        default: break
        }
        
        return cell
    }
}
