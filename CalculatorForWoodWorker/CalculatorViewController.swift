//
//  CalculatorViewController.swift
//  CalculatorForWoodWorker
//
//  Created by developer@softdevstory.net on 2016. 3. 1..
//  Copyright © 2016년 softdevstory. All rights reserved.
//

import UIKit

class CalculatorViewController: UITableViewController {

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
                let formatter = NumberFormatter()
                formatter.numberStyle = .decimal
                label.text = formatter.string(from: NSNumber(value: volumn))
            }
        }
    }
    
    var price = 0 {
        didSet {
            if let label = priceLabel {
                let formatter = NumberFormatter()
                formatter.numberStyle = .decimal
                label.text = formatter.string(from: NSNumber(value: price))
            }
        }
    }
    
    // MARK: view controller's jobs
    
    override func viewDidLoad() {
        super.viewDidLoad()

        widthTextField.accessibilityIdentifier = "woodWidth"
        widthTextFieldDelegate = TextFieldDelegateForNumber() { number in
            self.width = Double(number)
        }
        widthTextField.delegate = widthTextFieldDelegate
        
        heightTextField.accessibilityIdentifier = "woodHeight"
        heightTextFieldDelegate = TextFieldDelegateForNumber() { number in
            self.height = Double(number)
        }
        heightTextField.delegate = heightTextFieldDelegate
        
        lengthTextField.accessibilityIdentifier = "woodLength"
        lengthTextFieldDelegate = TextFieldDelegateForNumber() { number in
            self.length = Double(number)
        }
        lengthTextField.delegate = lengthTextFieldDelegate

        pricePerSaiTextField.accessibilityIdentifier = "woodPrice"
        pricePerSaiTextFieldDelegate = TextFieldDelegateForNumber() { number in
            self.pricePerSai = Int(number)
        }
        pricePerSaiTextField.delegate = pricePerSaiTextFieldDelegate
        
        title = "나무 가격 계산기"
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
    
    @IBAction func done(_ segue: UIStoryboardSegue) {
        
    }
}
