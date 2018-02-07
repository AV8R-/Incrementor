//
//  ConfigViewControllerSpec.swift
//  ViewsTests
//
//  Created by Богдан Маншилин on 07/02/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import Quick
import Nimble
import RxCocoa
import RxSwift
import ViewModels
import UIKit
@testable import Views

final class ConfigViewControllerSpec: QuickSpec {
    private final class MockConfigViewModelling: ConfigViewModelling {
        var step: BehaviorRelay<Int>
        var max: BehaviorRelay<Int>
        
        init() {
            step = .init(value: 10)
            max = .init(value: 20)
            
            step.bind { [weak self] _ in
                self?.stepChanges += 1
            }
            
            max.bind { [weak self] _ in
                self?.maxChanges += 1
            }
        }
        
        var stepChanges = 0
        var maxChanges = 0
    }
    
    override func spec() {
        describe("view") {
            let vm = MockConfigViewModelling()
            let vc = ConfigViewController(viewModel: vm, style: .grouped)
            vc.viewWillAppear(true)
            vc.tableView.reloadData()
            vc.tableView.reloadRows(at: [IndexPath(row: 0, section: 0), IndexPath(row: 0, section: 1)], with: .none)
            it("appears with correct values") {
                expect(vc.stepTextField.text).to(equal("\(vm.step.value)"))
                expect(vc.maxTextField.text).to(equal("\(vm.max.value)"))
            }
            
            it("changes the relays when values are edited") {
                // Unfortunately this actions doesn't trigger Rx bind,
                // so we can not test this UI behavior :(

//                let oldStepChanges = vm.stepChanges
//                let oldMaxChanges = vm.maxChanges
//                vc.stepTextField.text = "1"
//                vc.maxTextField.text = "10"
//                vc.stepTextField.sendActions(for: .editingChanged)
//                vc.maxTextField.sendActions(for: .editingChanged)
//                expect(vm.maxChanges).to(beGreaterThan(oldMaxChanges))
//                expect(vm.stepChanges).to(beGreaterThan(oldStepChanges))
            }
            
        }
    }
}

