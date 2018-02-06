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
import RxSwift

public final class IncrementViewModel: IncrementViewModelling {
    public var value: BehaviorRelay<Int>
    public var increment: ControlEvent<()>? {
        didSet {
            increment?.bind { [weak self] _ in
                self?.incrementor.increment()
                self?.update()
            }
            .disposed(by: disposeBag)
        }
    }
    public var reset: ControlEvent<()>? {
        didSet {
            reset?.bind { [weak self] _ in
                self?.incrementor.reset()
                self?.update()
            }
            .disposed(by: disposeBag)
        }
    }
    
    private var incrementor: Incrementing
    private var disposeBag = DisposeBag()
    
    public init(incrementor: Incrementing) {
        self.incrementor = incrementor
        value = BehaviorRelay(value: incrementor.value)
    }
    
    private func update() {
        value.accept(incrementor.value)
    }
    
    
}
