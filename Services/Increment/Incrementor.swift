//
//  Incrementor.swift
//  Services
//
//  Created by Богдан Маншилин on 01/02/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import Foundation

/**
 * Стандартный инкрементор. Не подготовлен к многопоточности
 **/
public struct Incrementor: Incrementing {
    /**
     * Enum исключений, которые модет выбросить `Incrementor`
     */
    public enum Error: Swift.Error {
        /// Максимальное значение не может быть меньше 0
        case maxIsOutOfAllowedRange
    }
    
    /// Текущее число. В самом начале это ноль.
    public private(set) var value: Int = 0 {
        didSet {
            try? storage.store(value, path: ["value"])
            dropValueIfNeeded()
        }
    }
    private var max: Int = .max {
        didSet {
            dropValueIfNeeded()
        }
    }
    private var step: Int = 1
    private let storage: Storing
    
    public init(config: Config, storage: Storing) {
        max = config.max
        step = config.step
        value = (try? storage.get(path: ["value"])) ?? 0
        self.storage = storage
    }

    private mutating func dropValueIfNeeded() {
        if value >= max {
            value = 0
        }
    }
    
    /**
     * Увеличивает текущее число на один.
     *
     * После каждого вызова этого метода getNumber() будет возвращать число
     * на один больше.
     */
    public mutating func increment() {
        value += step
    }
    
    /**
     * Устанавливает максимальное значение текущего числа.
     *
     * Когда при вызове incrementNumber() текущее число достигает
     * этого значения, оно обнуляется
     * По умолчанию максимум -- максимальное значение int.
     * Если при смене максимального значения число резко начинает
     * превышать максимальное значение, то число обнулится.
     * Максимум не может быть меньше нуля.
     */
    public mutating func set(maximum: Int) throws {
        guard maximum >= 0 else {
            throw Error.maxIsOutOfAllowedRange
        }
        max = maximum
    }
}
