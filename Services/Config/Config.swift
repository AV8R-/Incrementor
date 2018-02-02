//
//  Config.swift
//  Services
//
//  Created by Богдан Маншилин on 01/02/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import Foundation

enum ConfigError: Error {
    case failedToSerialize
    case failedToWrite
    case failedToRead
    case filedToDeserialize
    case validationFail(property: String, reason: String)
}

/// Конфигурация приложения.
public protocol Config {
    /** Значение на которое будет увеличиваться значение в `Incrementing`
       По умолчанию равняется 1
     */
    var step: Int { set get }
    /** Максимальное значение для `Incrementing`.
        Когда значение в Incrementing достигает максимального, оно обнуляется.
        По умолчанию равняется `Int.max`
     */
    var max: Int { set get }
    
    /** Сохраняет текущее состояние конфигурации.
        Можно сохранить только одну конфигурацию.
        При вызове изменит предыдущую сохраненную конфигурацию.
     */
    func save() throws
    
    /// Конфигурация со значениями по умолчанию
    static var `default`: Config { get }
    /// Текущая конфигурация
    static var stored: Config? { get }
    
    /// Загружает текущую конфигурацию. При ошибке бросает исключения типа `ConfigError`
    static func assertStored() throws -> Config
}
