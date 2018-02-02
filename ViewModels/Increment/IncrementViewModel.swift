//
//  IncrementViewModel.swift
//  ViewModelsTests
//
//  Created by Богдан Маншилин on 02/02/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import Foundation
import Services
import RxSwift

public final class IncrementViewModel: IncrementViewModelling {
    public var value: Variable<Int>
    
    private var incrementor: Incrementing
    
    init(incrementor: Incrementing) {
        self.incrementor = incrementor
        value = Variable(incrementor.value)
    }
    
    public func increment() {
        incrementor.increment()
        update()
    }
    
    private func update() {
        value.value = incrementor.value
    }
    
    
}
