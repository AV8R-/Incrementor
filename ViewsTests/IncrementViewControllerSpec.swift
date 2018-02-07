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
import RxSwift
import ViewModels
import UIKit
@testable import Views

final class IncrementViewControllerSpec: QuickSpec {
    
    final class MockIncrementViewModel: IncrementViewModelling {
        var increment: ControlEvent<()>? {
            didSet {
                _=increment?.bind { [weak self] in
                    self?.value.accept(Int(arc4random_uniform(20)))
                    self?.incrementCallsCount += 1
                }
            }
        }
        
        var reset: ControlEvent<()>? {
            didSet {
                _=reset?.bind { [weak self] in
                    self?.value.accept(0)
                    self?.resetCallsCount += 1
                }
            }
        }
        var value: BehaviorRelay<Int> = .init(value: 0)
        
        var incrementCallsCount = 0
        var resetCallsCount = 0
    }
    
    override func spec() {
        let viewModel = MockIncrementViewModel()
        let viewController = IncrementViewController(viewModel: viewModel)
        _=viewController.view
        describe("value button") {
            it("touch triggers increment") {
                let calls = viewModel.incrementCallsCount
                viewController.incrementButton.sendActions(for: .touchUpInside)
                expect(viewModel.incrementCallsCount).to(equal(calls+1))
            }
            
            it("updates button label on value change") {
                expect(viewController.incrementButton.titleLabel?.text)
                    .to(equal("\(viewModel.value.value)"))
            }
        }
        
        describe("reset button") {
            it("touch triggers rest on view model") {
                let calls = viewModel.resetCallsCount
                let button = viewController.resetButton!
                UIApplication.shared.sendAction(
                    button.action!,
                    to: button.target!,
                    from: nil,
                    for: nil
                )
                expect(viewModel.resetCallsCount).to(equal(calls+1))
            }
            
            it("updates button label on reset") {
                expect(viewController.incrementButton.titleLabel?.text)
                    .to(equal("\(viewModel.value.value)"))
            }
        }
    }
    
}
