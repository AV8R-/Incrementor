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
    var value: BehaviorRelay<Int> { get }
    func increment()
    func reset()
}
