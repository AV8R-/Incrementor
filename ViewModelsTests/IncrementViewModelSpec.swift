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
import RxCocoa
@testable import ViewModels

final class IncrementViewModelSpec: QuickSpec {
    
    final class MockIncrementor: Incrementing {
        var value: Int = 0
        
        var incrementCalls = 0
        
        func increment() {
            incrementCalls += 1
            value = Int(arc4random_uniform(20))
        }
        
        func set(maximum: Int) throws {
        }
    }
    
    override func spec() {
        let incrementor = MockIncrementor()
        let viewModel = IncrementViewModel(incrementor: incrementor)
        describe("increment") {
            it("calls increment on model") {
                let prevCalls = incrementor.incrementCalls
                viewModel.increment()
                expect(incrementor.incrementCalls).to(equal(prevCalls+1))
            }
            
            it("updates relay with model value") {
                viewModel.increment()
                expect(viewModel.value.value).to(equal(incrementor.value))
            }
        }
    }
    
}
