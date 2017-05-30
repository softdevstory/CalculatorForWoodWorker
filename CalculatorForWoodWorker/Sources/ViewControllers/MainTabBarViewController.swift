//
//  MainTabBarViewController.swift
//  CalculatorForWoodWorker
//
//  Created by HS Song on 2017. 5. 30..
//  Copyright © 2017년 softdevstory. All rights reserved.
//

import UIKit

enum TabBar {
    case saiCalculator
    case inchMeterCalculator
    
    var title: String {
        switch self {
        case .saiCalculator:
            return "SaiCalculatorTabBarTitle".localized
        case .inchMeterCalculator:
            return "InchMeterCalculatorTabBarTitle".localized
        }
    }
    
    var tag: Int {
        switch self {
        case .saiCalculator:
            return 100
        case .inchMeterCalculator:
            return 200
        }
    }
    
    var image: UIImage? {
        switch self {
        case .saiCalculator:
            return UIImage(named: "calculator")
        case .inchMeterCalculator:
            return UIImage(named: "conversion")
        }
    }
    
    var rootViewController: UIViewController {
        switch self {
        case .saiCalculator:
            return SaiCalculatorViewController()
        case .inchMeterCalculator:
            return InchMeterCalculatorViewController()
        }
    }
}

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc1 = UINavigationController(rootViewController: TabBar.saiCalculator.rootViewController)
        vc1.tabBarItem = UITabBarItem(
            title: TabBar.saiCalculator.title,
            image: TabBar.saiCalculator.image,
            tag: TabBar.saiCalculator.tag)
        
        let vc2 = UINavigationController(rootViewController: TabBar.inchMeterCalculator.rootViewController)
        vc2.tabBarItem = UITabBarItem(
            title: TabBar.inchMeterCalculator.title,
            image: TabBar.inchMeterCalculator.image,
            tag: TabBar.inchMeterCalculator.tag)
        
        viewControllers = [vc1, vc2]
    }
}
