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

public protocol ConfigViewModelling {
    var step: BehaviorRelay<Int> { get }
    var max: BehaviorRelay<Int> { get }
    
    func set(step: Int)
    func set(max: Int)
}
