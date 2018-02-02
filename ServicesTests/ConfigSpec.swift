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
    override func spec() {
        describe("config") {
            var config = StoredConfig.default
            config.step = 10
            config.max = 1000
            
            it("stores") {
                do {
                    try config.save()
                } catch {
                    expect(false).to(beTrue())
                }
            }
            
            it("reads") {
                do {
                    _ = try StoredConfig.assertStored()
                } catch {
                    expect(false).to(beTrue())
                }
            }
            
            describe("readed") {
                let readed = try! StoredConfig.assertStored()
                it("has stored values") {
                    expect(readed.step).to(equal(10))
                    expect(readed.max).to(equal(1000))
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
