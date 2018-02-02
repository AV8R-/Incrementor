//
//  ConfigViewModelSpec.swift
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

final class ConfigViewModelSpec: QuickSpec {
    
    final class MockConfig: Config {
        enum Error: Swift.Error {
            case any
        }
        
        var step: Int = 1
        var max: Int = .max
        
        var saveCalls = 0
        
        func save() throws {
            saveCalls += 1
            guard step > 0, max > 0 else {
                throw Error.any
            }
        }
        
        static var `default`: Config = MockConfig()
        static var stored: Config? = MockConfig()
        static func assertStored() throws -> Config {
            return MockConfig()
        }
        
    }
    
    override func spec() {
        let config = MockConfig()
        let viewModel = ConfigViewModel(config: config)
        
        describe("set step method") {
            beforeEach {
                config.max = .max
                config.step = 1
            }
            it("changes config value") {
                viewModel.set(step: 5)
                expect(config.step).to(equal(5))
            }
            it("calls save on config") {
                let prevCalls = config.saveCalls
                viewModel.set(step: 10)
                expect(config.saveCalls).to(equal(prevCalls+1))
            }
            it("updates relay") {
                viewModel.set(step: 15)
                expect(viewModel.step.value).to(equal(15))
            }
            it("updates relay with old value o fail") {
                let old = config.step
                viewModel.step.accept(20)
                viewModel.set(step: -10)
                expect(viewModel.step.value).to(equal(old))
            }
        }
        
        describe("set max method") {
            beforeEach {
                config.max = .max
                config.step = 1
            }
            it("changes config value") {
                viewModel.set(max: 5)
                expect(config.max).to(equal(5))
            }
            it("calls save on config") {
                let prevCalls = config.saveCalls
                viewModel.set(max: 10)
                expect(config.saveCalls).to(equal(prevCalls+1))
            }
            it("updates relay") {
                viewModel.set(max: 15)
                expect(viewModel.max.value).to(equal(15))
            }
            it("updates relay with old value o fail") {
                let old = config.max
                viewModel.max.accept(20)
                viewModel.set(max: -10)
                expect(viewModel.max.value).to(equal(old))
            }
        }
    }
    
}
