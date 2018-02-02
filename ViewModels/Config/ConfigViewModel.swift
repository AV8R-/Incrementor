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

/// `ViewModel` для экрана конфигурации
public final class ConfigViewModel: ConfigViewModelling {
    public var step: BehaviorRelay<Int>
    public var max: BehaviorRelay<Int>
    
    internal var config: Config
    
    public init(config: Config) {
        self.config = config
        step = BehaviorRelay(value: config.step)
        max = BehaviorRelay(value: config.max)
    }
    
    /// Устанавливает значение шага. Сохраняет конфиг. Отсылает в `Relay`
    /// новое значение. При ошибке сохранения конфига отсылает в `Relay`
    /// шага предыдущее значение
    public func set(step: Int) {
        let old = config.step
        config.step = step
        do {
            try config.save()
        } catch {
            self.step.accept(old)
            return
        }
        self.step.accept(step)
    }
    
    /// Устанавливает значение максимума. Сохраняет конфиг. Отсылает в
    /// `Relay` новое значение. При ошибке сохранения конфига отсылает в
    /// `Relay` максимума предыдущее значение
    public func set(max: Int) {
        let old = config.max
        config.max = max
        do {
            try config.save()
        } catch {
            self.max.accept(old)
            return
        }
        self.max.accept(max)
    }
}
