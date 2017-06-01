//
//  SaiCalculatorViewModel.swift
//  CalculatorForWoodWorker
//
//  Created by HS Song on 2017. 5. 31..
//  Copyright © 2017년 softdevstory. All rights reserved.
//

import RxSwift

class SaiCalculatorViewModel {

    private let bag = DisposeBag()

    // MARK: input
    var width = Variable(0.0)
    var height = Variable(0.0)
    var length = Variable(0.0)
    var pricePerSai = Variable(0.0)
    
    // MARK: output
    private(set) var totalSai = Variable<Double>(0.0)
    private(set) var totalPrice = Variable<Int>(0)
    
    init() {
        
        Observable.combineLatest(width.asObservable(), height.asObservable(), length.asObservable(), pricePerSai.asObservable(), resultSelector: { (width, height, length, pricePerSai) -> (Double, Int) in
            
            // 1 chi = 30.3mm, 1 ja = 3636mm
            let tempVolumn = (width * height * length) / (30.3 * 30.3 * 3636)
            let volume = round(tempVolumn * 100) / 100
            let price = Int(volume * pricePerSai)
            
            return (volume, price)
        })
        .subscribe(onNext: { (totalSai, totalPrice) in
            self.totalSai.value = totalSai
            self.totalPrice.value = totalPrice
        })
        .addDisposableTo(bag)
    }
}
