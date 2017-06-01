//
//  String+Localized.swift
//  CalculatorForWoodWorker
//
//  Created by HS Song on 2017. 5. 30..
//  Copyright © 2017년 softdevstory. All rights reserved.
//

import Foundation

extension String {
  var localized: String {
    return NSLocalizedString(self, comment: "")
  }
}
