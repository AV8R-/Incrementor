//
//  Incrementing.swift
//  Services
//
//  Created by Богдан Маншилин on 01/02/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import Foundation

/**
 * Инктементатор для одного Int числа.
 *
 * Увеличивает число на единицу в интервале от 0 до устанавливаемого максимума.
 * Максимум по умолчанию равен `Int.max`
 */
public protocol Incrementing {
    /// Текущее число.
    var value: Int { get }
    /// Увеличивает текущее число на один.
    mutating func increment()
    /// Устанавливает максимальное значение текущего числа.
    mutating func set(maximum: Int) throws
    /// Сбрасывает текущее значение до нуля
    mutating func reset()
}
