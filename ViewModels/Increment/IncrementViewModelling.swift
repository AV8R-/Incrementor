//
//  IncrementViewModelling.swift
//  ViewModelsTests
//
//  Created by Богдан Маншилин on 02/02/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import Foundation
import RxCocoa

public protocol IncrementViewModelling {
    ///Текущее значение в инкременторе
    var value: BehaviorRelay<Int> { get }
    /// Событие увеличения значение в инкременторе
    var increment: ControlEvent<()>? { set get }
    /// Событие сброса значения в инкременторе до стартового
    var reset: ControlEvent<()>? { set get }
}
