//
//  NumberInputCell.swift
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

class NumberInputCell: UITableViewCell, LabelCellProtocol {

    private let bag = DisposeBag()
    
    private let stackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .center
        $0.distribution = .fillEqually
        $0.spacing = 10
    }
    
    private let prevLabel = UILabel().then {
        $0.textAlignment = .right
    }
    
    private let textField = UITextField().then {
        $0.textAlignment = .right
        $0.borderStyle = .roundedRect
        $0.keyboardType = .decimalPad
    }
    
    private let postLabel = UILabel().then {
        $0.textAlignment = .left
    }
    
    // MARK: input
    var name: String = "" {
        didSet {
            prevLabel.text = name
        }
    }
    
    var unit: String = "" {
        didSet {
            postLabel.text = unit
        }
    }

    // MARK: output
    var number = Variable<Double>(0.0)
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(stackView)
        stackView.snp.makeConstraints { maker -> Void in
            maker.top.equalTo(self.contentView).offset(0)
            maker.bottom.equalTo(self.contentView).offset(0)
            maker.right.equalTo(self.contentView).offset(0)
            maker.left.equalTo(self.contentView).offset(0)
        }
        
        stackView.addArrangedSubview(prevLabel)
        stackView.addArrangedSubview(textField)
        stackView.addArrangedSubview(postLabel)
        
        textField.text = "0"
        textField.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: UITextFieldDelegate
extension NumberInputCell: UITextFieldDelegate {
    
    func checkValidNumber(_ string: String) -> Bool {
        if let _ = Double(string) {
            return true
        }

        return false;
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        var newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        if newString == "" {
            newString = "0"
        }
        let numberString = newString.replacingOccurrences(of: ",", with: "")

        guard checkValidNumber(numberString) else {
            return false
        }

        number.value = Double(numberString) ?? 0
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        if numberString.hasSuffix(".") {
            formatter.positiveFormat = "#,##0.###"
            textField.text = formatter.string(from: NSNumber(value: number.value))! + "."
        } else {
            if numberString.contains(".") {
                formatter.positiveFormat = "#,##0.0##"
            } else {
                formatter.positiveFormat = "#,##0.###"
            }
            textField.text = formatter.string(from: NSNumber(value: number.value))
        }

        return false
    }
}
