//
//  ConversionViewController.swift
//  CalculatorForWoodWorker
//
//  Created by developer@softdevstory.net on 2016. 3. 2..
//  Copyright © 2016년 softdevstory. All rights reserved.
//

import UIKit

class ConversionViewController: UITableViewController {

    // MARK: outlets
    
    @IBOutlet weak var feetTextField: UITextField!
    @IBOutlet weak var inchTextField: UITextField!
    
    @IBOutlet weak var milimeterLabel: UILabel!
    
    @IBOutlet weak var milimeterTextField: UITextField!
    
    @IBOutlet weak var feetLabel: UILabel!
    @IBOutlet weak var inchLabel: UILabel!
    
    var feetTextFieldDelegate: TextFieldDelegateForNumber!
    var inchTextFieldDelegate: TextFieldDelegateForNumber!
    var milimeterTextFieldDelegate: TextFieldDelegateForNumber!

    // MARK: variables
    
    var feetInput: Double = 0 {
        didSet {
            convertToMilimeter()
        }
    }
    
    var inchInput: Double = 0 {
        didSet {
            convertToMilimeter()
        }
    }
    
    var milimeterOutput: Double = 0 {
        didSet {
            if let label = milimeterLabel {
                let formatter = NSNumberFormatter()
                formatter.numberStyle = .DecimalStyle
                label.text = formatter.stringFromNumber(milimeterOutput)
            }
        }
    }
    
    var milimeterInput: Double = 0 {
        didSet {
            convertToFeetAndInch()
        }
    }
    
    var feetOutput: Double = 0 {
        didSet {
            if let label = feetLabel {
                let formatter = NSNumberFormatter()
                formatter.numberStyle = .DecimalStyle
                label.text = formatter.stringFromNumber(feetOutput)
            }
        }
    }
    
    var inchOutput: Double = 0 {
        didSet {
            if let label = inchLabel {
                let formatter = NSNumberFormatter()
                formatter.numberStyle = .DecimalStyle
                label.text = formatter.stringFromNumber(inchOutput)
            }
        }
    }
    
    // MARK: view controller jobs
    
    override func viewDidLoad() {
        super.viewDidLoad()

        feetTextFieldDelegate = TextFieldDelegateForNumber() { number in
            self.feetInput = Double(number)
        }
        feetTextField.delegate = feetTextFieldDelegate

        inchTextFieldDelegate = TextFieldDelegateForNumber() { number in
            self.inchInput = Double(number)
        }
        inchTextField.delegate = inchTextFieldDelegate
        
        milimeterTextFieldDelegate = TextFieldDelegateForNumber() { number in
            self.milimeterInput = Double(number)
        }
        milimeterTextField.delegate = milimeterTextFieldDelegate
        
        title = "치수 변환"
    }

    // MARK: convert unit
    
    func convertToMilimeter() {
        // 1 feet = 304.8mm, 1 inch = 25.4mm
        milimeterOutput = (feetInput * 304.8) + (inchInput * 25.4)
    }
    
    func convertToFeetAndInch() {
        // 1 feet = 304.8mm, 1 inch = 25.4mm
        feetOutput = round(milimeterInput / 304.8)
        inchOutput = (milimeterInput - round(milimeterInput / 304.8)) / 25.4
    }
}
