//
//  ConfigViewModelling.swift
//  ViewModels
//
//  Created by Богдан Маншилин on 02/02/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

///ViewModel экрана настроек
public protocol ConfigViewModelling {
    /// Relay шага инкремента.
    ///
    /// Это значение соответсвоовует значению, на которое увеличивается
    /// значение в `Incrementor` каждый шаг.
    var step: BehaviorRelay<Int> { get }
    
    /// Relay максимального значения в инкременторе.
    ///
    /// Это значение соответсвоовует максимальному значению в `Incrementor`.
    var max: BehaviorRelay<Int> { get }
}
