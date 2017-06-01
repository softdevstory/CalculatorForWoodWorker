//
//  InchMeterCalculatorViewModelTests.swift
//  CalculatorForWoodWorker
//
//  Created by HS Song on 2017. 6. 1..
//  Copyright © 2017년 softdevstory. All rights reserved.
//

import XCTest

import RxSwift
import RxTest

class InchMeterCalculatorViewModelTests: XCTestCase {

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

    func testInch() {
        let observer = scheduler.createObserver(Double.self)
        
        let viewModel = InchMeterCalculatorViewModel()
        
        viewModel.inch.value = 1
        viewModel.feet.value = 1

        scheduler.scheduleAt(0) {
            self.subscription = viewModel.milimeterResult.asObservable().subscribe(observer)
        }
        scheduler.start()
        
        let results = observer.events.map { $0.value.element! }
        
        XCTAssertEqual(results, [330.2])
    }
    
    /*
    func testMilimeter() {
        let observer = scheduler.createObserver(Double.self)
        
        let viewModel = InchMeterCalculatorViewModel()
        
        viewModel.milimeter.value = 330.2

        scheduler.scheduleAt(0) {
            self.subscription = viewModel.inchResult.asObservable().subscribe(observer)
        }
        scheduler.start()
        
        let results = observer.events.map { $0.value.element! }
        
        XCTAssertEqual(results, [1.0])
    }
    */
}
