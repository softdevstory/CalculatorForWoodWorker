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

class NumberInputCell: UITableViewCell, LabelCellProtocol {

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
    }
    
    private let postLabel = UILabel().then {
        $0.textAlignment = .left
    }
    
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
        
        textField.text = "0"
        stackView.addArrangedSubview(textField)

        stackView.addArrangedSubview(postLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
