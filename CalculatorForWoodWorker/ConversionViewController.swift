//
//  ConversionViewController.swift
//  CalculatorForWoodWorker
//
//  Created by developer@softdevstory.net on 2016. 3. 2..
//  Copyright © 2016년 softdevstory. All rights reserved.
//

import UIKit

class ConversionViewController: UIViewController {

    // MARK: outlets
    
    @IBOutlet weak var feetTextField: UITextField!
    @IBOutlet weak var inchTextField: UITextField!
    
    @IBOutlet weak var milimeterLabel: UILabel!
    
    @IBOutlet weak var milimeterTextField: UITextField!
    
    @IBOutlet weak var feetLabel: UILabel!
    @IBOutlet weak var inchLabel: UILabel!
    
    // MARK: variables
    
    var feetInput: Double = 0
    
    
    // MARK: view controller jobs
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
