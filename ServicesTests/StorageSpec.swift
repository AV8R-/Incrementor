//
//  StorageSpec.swift
//  ServicesTests
//
//  Created by Богдан Маншилин on 02/02/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import Quick
import Nimble
@testable import Services

final class StorageSpec: QuickSpec {
    override func spec() {
        describe("storage") {
            let storage = DiskStorage()
            it("stores primitives") {
                do {
                    try storage.store(5, path: ["incremented"])
                } catch {
                    expect(false).to(beTrue())
                }
            }
            
            it("reads stored values") {
                do {
                    _=try storage.get(path: ["incremented"]) as Int
                } catch {
                    XCTFail("\(error)")
                    return
                }
            }
            
            describe("readed value") {
                let value: Int = try! storage.get(path: ["incremented"])
                it("equals to stored one") {
                    expect(value).to(equal(5))
                }
            }

        }
    }
}
