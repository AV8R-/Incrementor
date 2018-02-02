//
//  IncrementViewControllerSpec.swift
//  ViewsTests
//
//  Created by Богдан Маншилин on 02/02/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import Quick
import Nimble
import RxCocoa
import ViewModels
@testable import Views

final class IncrementViewControllerSpec: QuickSpec {
    
    final class MockIncrementViewModel: IncrementViewModelling {
        var value: BehaviorRelay<Int> = .init(value: 0)
        
        var callsCount = 0
        
        func increment() {
            callsCount += 1
        }
    }
    
    override func spec() {
        let viewModel = MockIncrementViewModel()
        let viewController = IncrementViewController(viewModel: viewModel)
        _=viewController.view
        describe("button") {
            it("touch triggers increment") {
                let calls = viewModel.callsCount
                viewController.button.sendActions(for: .touchUpInside)
                expect(viewModel.callsCount).to(equal(calls+1))
            }
            
            it("updates button label on value change") {
                let new = Int(arc4random_uniform(20))
                viewModel.value.accept(new)
                expect(viewController.button.titleLabel?.text).to(equal("\(new)"))
            }
        }
    }
    
}
