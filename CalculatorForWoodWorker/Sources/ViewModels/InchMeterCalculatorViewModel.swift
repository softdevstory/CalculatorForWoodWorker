//
//  InchMeterCalculatorViewModel.swift
//  CalculatorForWoodWorker
//
//  Created by HS Song on 2017. 6. 1..
//  Copyright © 2017년 softdevstory. All rights reserved.
//

import RxSwift

class InchMeterCalculatorViewModel {
    private let bag = DisposeBag()
    
    // MARK: input
    var feet = Variable<Double>(0.0)
    var inch = Variable<Double>(0.0)
    var milimeter = Variable<Double>(0.0)
    
    // MARK: output
    private(set) var milimeterResult = Variable<Double>(0.0)
    private(set) var feetResult = Variable<Double>(0.0)
    private(set) var inchResult = Variable<Double>(0.0)

    init() {
    
        // feet, inch -> milimeter
        Observable.combineLatest(feet.asObservable(), inch.asObservable(), resultSelector: { (feet, inch) -> Double in
            // 1 feet = 304.8mm, 1 inch = 25.4mm
            return (feet * 304.8) + (inch * 25.4)
        })
        .subscribe(onNext: { milimeter in
            self.milimeterResult.value = milimeter
        })
        .disposed(by: bag)
        
        // milimeter -> feet, inch
        milimeter.asObservable()
            .subscribe(onNext: { milimeter in
                // 1 feet = 304.8mm, 1 inch = 25.4mm
                self.feetResult.value = floor(milimeter / 304.8)
                self.inchResult.value = (milimeter - (self.feetResult.value * 304.8)) / 25.4
            })
            .disposed(by: bag)
    }
}
