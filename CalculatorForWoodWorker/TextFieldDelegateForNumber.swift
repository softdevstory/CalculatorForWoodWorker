//
//  TextFieldDelegateForNumber.swift
//  CalculatorForWoodWorker
//
//  Created by developer@softdevstory.net on 2016. 3. 2..
//  Copyright © 2016년 softdevstory. All rights reserved.
//

import UIKit

class TextFieldDelegateForNumber: NSObject, UITextFieldDelegate {
    
    var updateNumber: (number: NSNumber) -> Void
    
    init(updateNumber: (number: NSNumber) -> Void) {
        self.updateNumber = updateNumber
        
        super.init()
    }
    
    func checkValidNumber(string: String) -> Bool {
        if let _ = Double(string) {
            return true
        }

        return false;
    }
    
    // MARK: UITextFieldDelegate
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        var newString = (textField.text! as NSString).stringByReplacingCharactersInRange(range, withString: string)
        if newString == "" {
            newString = "0"
        }
        let numberString = newString.stringByReplacingOccurrencesOfString(",", withString: "")

        guard checkValidNumber(numberString) else {
            return false
        }

        let number = Double(numberString) ?? 0
        
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .DecimalStyle
        
        if numberString.hasSuffix(".") {
            formatter.positiveFormat = "#,##0.###"
            textField.text = formatter.stringFromNumber(number)! + "."
        } else {
            if numberString.containsString(".") {
                formatter.positiveFormat = "#,##0.0##"
            } else {
                formatter.positiveFormat = "#,##0.###"
            }
            textField.text = formatter.stringFromNumber(number)
        }
        
        updateNumber(number: number)

        return false
    }
}