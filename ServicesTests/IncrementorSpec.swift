//
//  IncrementorSpec.swift
//  ServicesTests
//
//  Created by Богдан Маншилин on 02/02/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import Quick
import Nimble
@testable import Services

final class IncrementorSpec: QuickSpec {
    override func spec() {
        describe("incrementor") {
            let config = MockConfig(step: 2, max: 3)
            let startValue = 0
            var incrementor: Incrementing!
                
            beforeEach {
                incrementor = Incrementor(config: config, storage: MockStorage())
            }
            
            it("initializes with start value") {
                expect(incrementor.value).to(equal(startValue))
            }
            
            it("increments by step from config") {
                incrementor.increment()
                expect(incrementor.value).to(equal(startValue+config.step))
            }
            
            it("frop value after reaching max") {
                incrementor.increment()
                incrementor.increment()
                expect(incrementor.value).to(equal(startValue))
            }
        }
    }
}

// MARK: - MOCKS

enum MockError: Error {
    case unimplemented
}

struct MockConfig: Config {
    var step: Int
    var max: Int
    
    func save() throws {
    }
    
    static func `default`(store: Storing) -> Config {
        return MockConfig(step: 1, max: .max)
    }
    
    static func stored(store: Storing) throws -> Config {
        return MockConfig(step: 5, max: 10)
    }
}

final class MockStorage: Storing {
    func store<T>(_ value: T, path: [String]) throws {
    }
    
    func get<T>(path: [String]) throws -> T {
        throw MockError.unimplemented
    }
}
