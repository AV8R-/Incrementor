//
//  IncrementViewModel.swift
//  ViewModelsTests
//
//  Created by Богдан Маншилин on 02/02/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import Foundation
import Services
import RxCocoa

public final class IncrementViewModel: IncrementViewModelling {
    public var value: BehaviorRelay<Int>
    
    private var incrementor: Incrementing
    
    public init(incrementor: Incrementing) {
        self.incrementor = incrementor
        value = BehaviorRelay(value: incrementor.value)
    }
    
    /// Увеличивает значение, обновляет `Relay` значением из модели
    public func increment() {
        incrementor.increment()
        update()
    }
    
    /// Сбрасывает текущее значение до нуля
    public func reset() {
        incrementor.reset()
        update()
    }
    
    private func update() {
        value.accept(incrementor.value)
    }
    
    
}
