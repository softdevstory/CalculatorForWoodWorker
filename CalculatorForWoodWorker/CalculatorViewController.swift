//
//  CalculatorViewController.swift
//  CalculatorForWoodWorker
//
//  Created by developer@softdevstory.net on 2016. 3. 1..
//  Copyright © 2016년 softdevstory. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    // MARK: UI outlet
    
    @IBOutlet weak var widthTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var lengthTextField: UITextField!
    @IBOutlet weak var pricePerSaiTextField: UITextField!
    
    @IBOutlet weak var volumnLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var widthTextFieldDelegate: TextFieldDelegateForNumber!
    var heightTextFieldDelegate: TextFieldDelegateForNumber!
    var lengthTextFieldDelegate: TextFieldDelegateForNumber!
    var pricePerSaiTextFieldDelegate: TextFieldDelegateForNumber!

    // MARK: variables

    var width: Double = 0 {
        didSet {
            calculateVolumn()
        }
    }
    
    var height: Double = 0 {
        didSet {
            calculateVolumn()
        }
    }
    
    var length: Double = 0 {
        didSet {
            calculateVolumn()
        }
    }
    
    var pricePerSai = 0 {
        didSet {
            calculatePrice()
        }
    }
    
    var volumn: Double = 0 {
        didSet {
            if let label = volumnLabel {
                let formatter = NSNumberFormatter()
                formatter.numberStyle = .DecimalStyle
                label.text = formatter.stringFromNumber(volumn)
            }
        }
    }
    
    var price = 0 {
        didSet {
            if let label = priceLabel {
                let formatter = NSNumberFormatter()
                formatter.numberStyle = .DecimalStyle
                label.text = formatter.stringFromNumber(price)
            }
        }
    }
    
    // MARK: view controller's jobs
    
    override func viewDidLoad() {
        super.viewDidLoad()

        widthTextFieldDelegate = TextFieldDelegateForNumber() { number in
            self.width = Double(number)
        }
        widthTextField.delegate = widthTextFieldDelegate
        
        heightTextFieldDelegate = TextFieldDelegateForNumber() { number in
            self.height = Double(number)
        }
        heightTextField.delegate = heightTextFieldDelegate
        
        lengthTextFieldDelegate = TextFieldDelegateForNumber() { number in
            self.length = Double(number)
        }
        lengthTextField.delegate = lengthTextFieldDelegate
        
        pricePerSaiTextFieldDelegate = TextFieldDelegateForNumber() { number in
            self.pricePerSai = Int(number)
        }
        pricePerSaiTextField.delegate = pricePerSaiTextFieldDelegate
    }

    // MARK: calculation

    func calculateVolumn() {
        // 1 chi = 30.3mm, 1 ja = 3636mm
        let tempVolumn = (width * height * length) / (30.3 * 30.3 * 3636)
        volumn = round(tempVolumn * 100) / 100
        
        calculatePrice()
    }
    
    func calculatePrice() {
        price = Int(volumn * Double(pricePerSai))
    }
}