//
//  IncrementViewModelSpec.swift
//  ViewModelsTests
//
//  Created by Богдан Маншилин on 02/02/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import Quick
import Nimble
import Services
import RxSwift
import RxCocoa
import UIKit
@testable import ViewModels

final class IncrementViewModelSpec: QuickSpec {
    
    final class MockIncrementor: Incrementing {
        var value: Int = 0
        
        var incrementCalls = 0
        var resetCalls = 0
        
        func increment() {
            incrementCalls += 1
            value = Int(arc4random_uniform(20))
        }
        
        func set(maximum: Int) throws {
        }
        
        func reset() {
            value = 0
            resetCalls += 1
        }
    }
    
    override func spec() {
        let incrementor = MockIncrementor()
        let viewModel = IncrementViewModel(incrementor: incrementor)
        describe("increment") {
            it("calls increment on the model layer") {
                let prevCalls = incrementor.incrementCalls
                let taps = Observable.just(())
                viewModel.increment = ControlEvent(events: taps)
                expect(incrementor.incrementCalls).to(equal(prevCalls+1))
            }
            
            it("updates relay with model value") {
                let taps = Observable.just(())
                viewModel.increment = ControlEvent(events: taps)
                expect(viewModel.value.value).to(equal(incrementor.value))
            }
        }
        
        describe("reset") {
            it("calls increment on the model layer") {
                let prevCalls = incrementor.resetCalls
                let taps = Observable.just(())
                viewModel.reset = ControlEvent(events: taps)
                expect(incrementor.resetCalls).to(equal(prevCalls+1))
            }
            
            it("updates relay with model value") {
                let taps = Observable.just(())
                viewModel.increment = ControlEvent(events: taps)
                expect(viewModel.value.value).to(equal(incrementor.value))
            }
        }
    }
    
}
