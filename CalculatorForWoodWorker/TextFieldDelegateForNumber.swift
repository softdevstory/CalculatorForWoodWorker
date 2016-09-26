//
//  TextFieldDelegateForNumber.swift
//  CalculatorForWoodWorker
//
//  Created by developer@softdevstory.net on 2016. 3. 2..
//  Copyright © 2016년 softdevstory. All rights reserved.
//

import UIKit

class TextFieldDelegateForNumber: NSObject, UITextFieldDelegate {
    
    var updateNumber: (_ number: NSNumber) -> Void
    
    init(updateNumber: @escaping (_ number: NSNumber) -> Void) {
        self.updateNumber = updateNumber
        
        super.init()
    }
    
    func checkValidNumber(_ string: String) -> Bool {
        if let _ = Double(string) {
            return true
        }

        return false;
    }
    
    // MARK: UITextFieldDelegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        var newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        if newString == "" {
            newString = "0"
        }
        let numberString = newString.replacingOccurrences(of: ",", with: "")

        guard checkValidNumber(numberString) else {
            return false
        }

        let number = Double(numberString) ?? 0
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        if numberString.hasSuffix(".") {
            formatter.positiveFormat = "#,##0.###"
            textField.text = formatter.string(from: NSNumber(value: number))! + "."
        } else {
            if numberString.contains(".") {
                formatter.positiveFormat = "#,##0.0##"
            } else {
                formatter.positiveFormat = "#,##0.###"
            }
            textField.text = formatter.string(from: NSNumber(value: number))
        }
        
        updateNumber(NSNumber(value: number))

        return false
    }
}
