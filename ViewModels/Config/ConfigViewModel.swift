//
//  ConfigViewModel.swift
//  ViewModels
//
//  Created by Богдан Маншилин on 02/02/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import Services

/// `ViewModel` для экрана конфигурации без валидации значений.
/// Ошибки сохранения конфига умалчиваются
public final class ConfigViewModel: ConfigViewModelling {
    public var step: BehaviorRelay<Int>
    public var max: BehaviorRelay<Int>
    
    internal var config: Config
    private let disposeBag = DisposeBag()
    
    public init(config: Config) {
        self.config = config
        step = BehaviorRelay(value: config.step)
        max = BehaviorRelay(value: config.max)
        
        step.subscribe { [weak self] event in
            guard let value = event.element else {
                return
            }
            self?.config.step = value
            try? self?.config.save()
        }
        .disposed(by: disposeBag)
        
        max.subscribe { [weak self] event in
            guard let value = event.element else {
                return
            }
            self?.config.max = value
            try? self?.config.save()
            }
            .disposed(by: disposeBag)
    }
}
