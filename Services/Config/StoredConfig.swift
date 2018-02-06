//
//  Config.swift
//  Services
//
//  Created by Богдан Маншилин on 01/02/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import Foundation

/**
 Конфигурация, сохраняющаяся на диске
 Может сохранить только один экземпляр конфига
 */
public struct StoredConfig: Config, Storable {
    private static let filename = "Config"
    private var filePath: URL { return StoredConfig.fullPath(file: StoredConfig.filename) }

    private enum Constants {
        static let stepKey = ["config", "step"]
        static let maxKey = ["config", "max"]
    }
    
    private let store: Storing
    
    /**
      Шаг инкремента
      Валидны только значения больше 0. По умолчанию 1.
     */
    public var step: Int
    /**
      Максимальное значение в инкременте
      Валидны только значения больше 0. По умолчанию `Int.max`
     */
    public var max: Int
    
    private init(store: Storing) {
        self.store = store
        step = 1
        max = Int.max
    }
    
    // Конфиг со значениями по умолчанию
    public static func `default`(store: Storing) -> Config {
        return StoredConfig(store: store)
    }
    
    /// Инициализировтаь конфиг со значениями из хранилища.
    public static func stored(store: Storing) throws -> Config {
        var config = StoredConfig(store: store)
        try config.parseConfig()
        return config
    }
    
    /**
     Сохраняет текущий конфиг на диск
     
     - throws:
     Исключения типа `ConfigError`
     При попытке сохранить конфиг с не валидными значениями выбросит исключение
     `ConfigError.validationFail`
     */
    public func save() throws {
        try validate()
        try storeConfig()
    }
    
    private func storeConfig() throws {
        try store.store(step, path: Constants.stepKey)
        try store.store(max, path: Constants.maxKey)
    }
    
    private func validate() throws {
        guard step > 0 else {
            throw ConfigError.validationFail(property: "step", reason: "must be > 0")
        }
        
        guard max > 0 else {
            throw ConfigError.validationFail(property: "max", reason: "must be > 0")
        }
    }
    
    private mutating func parseConfig() throws {
        max = try store.get(path: Constants.maxKey)
        step = try store.get(path: Constants.stepKey)
    }
}
