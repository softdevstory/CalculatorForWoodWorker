//
//  SaiCalculatorViewModelTest.swift
//  CalculatorForWoodWorker
//
//  Created by HS Song on 2017. 5. 31..
//  Copyright © 2017년 softdevstory. All rights reserved.
//

import XCTest

import RxSwift
import RxTest

class SaiCalculatorViewModelTest: XCTestCase {

    private var scheduler: TestScheduler!
    private var subscription: Disposable!
    
    override func setUp() {
        super.setUp()

        scheduler = TestScheduler(initialClock: 0)

    }

    override func tearDown() {
        scheduler.scheduleAt(1000) {
            self.subscription.dispose()
        }
        
        super.tearDown()
    }
    
    func testSai() {
        let observer = scheduler.createObserver(Double.self)
        
        let viewModel = SaiCalculatorViewModel()
        
        viewModel.width.value = 30.3
        viewModel.height.value = 30.3
        viewModel.length.value = 3636
        viewModel.pricePerSai.value = 1000

        scheduler.scheduleAt(0) {
            self.subscription = viewModel.totalSai.asObservable().subscribe(observer)
        }
        scheduler.start()
        
        let results = observer.events.map { $0.value.element! }
        
        XCTAssertEqual(results, [1.0])
    }
    
    func testPrice() {
        let observer = scheduler.createObserver(Int.self)
        
        let viewModel = SaiCalculatorViewModel()
        
        viewModel.width.value = 30.3
        viewModel.height.value = 30.3
        viewModel.length.value = 3636
        viewModel.pricePerSai.value = 1000

        scheduler.scheduleAt(0) {
            self.subscription = viewModel.totalPrice.asObservable().subscribe(observer)
        }
        scheduler.start()
        
        let results = observer.events.map { $0.value.element! }
        
        XCTAssertEqual(results, [1000])
    }
}
