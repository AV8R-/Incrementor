//
//  ConfigSpec.swift
//  ServicesTests
//
//  Created by Богдан Маншилин on 02/02/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import Quick
import Nimble
@testable import Services

final class ConfigSpec: QuickSpec {
    private final class MockStore: Storing {
        var store: [String: Any] = [:]
        
        func store<T>(_ value: T, path: [String]) throws {
            store[path.joined()] = value
        }
        
        func get<T>(path: [String]) throws -> T {
            return store[path.joined()] as! T
        }
        
        
    }
    
    override func spec() {
        describe("config") {
            let store = MockStore()
            var config = StoredConfig.default(store: store)
            config.step = 10
            config.max = 1000
            
            it("stores") {
                do {
                    try config.save()
                } catch {
                    expect(false).to(beTrue())
                }
            }
            
            it("reads from the store") {
                do {
                    let readed = try StoredConfig.stored(store: store)
                    expect(readed.step).to(equal(10))
                    expect(readed.max).to(equal(1000))
                } catch {
                    expect(false).to(beTrue())
                }
                
            }
                        
            it("validates values") {
                config.step = -10
                do {
                    try config.save()
                } catch {
                    expect(true).to(beTrue())
                    return
                }
                expect(false).to(beTrue())
            }
            
        }
    }
}
