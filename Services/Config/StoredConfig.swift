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
public struct StoredConfig: Config, Codable, Storable {
    private static let filename = "Config"
    private var filePath: URL { return StoredConfig.fullPath(file: StoredConfig.filename) }
    private enum CodingKeys: String, CodingKey {
        case step, max
    }
    
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
    
    private init() {
        step = 1
        max = Int.max
    }
    
    // Конфиг со значениями по умолчанию
    public static let `default`: Config = StoredConfig()
    // Конфиг записаный на диск
    public static var stored: Config? {
        return try? parseConfig()
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
    
    /**
     Прочесть конфиг с диска
     
     - throws:
     Исключения типа `ConfigError`
     */
    public static func assertStored() throws -> Config {
        return try parseConfig()
    }
    
    private func storeConfig() throws {
        let url = fullPath(file: StoredConfig.filename)
        let encoder = PropertyListEncoder()
        let data: Data
        do {
            data = try encoder.encode(self)
        } catch {
            throw ConfigError.failedToSerialize
        }
        
        do {
            try data.write(to: url)
        } catch {
            throw ConfigError.failedToWrite
        }
    }
    
    private func validate() throws {
        guard step > 0 else {
            throw ConfigError.validationFail(property: "step", reason: "must be > 0")
        }
        
        guard max > 0 else {
            throw ConfigError.validationFail(property: "max", reason: "must be > 0")
        }
    }
    
    private static func parseConfig() throws -> StoredConfig {
        let url = fullPath(file: StoredConfig.filename)
        let decoder = PropertyListDecoder()
        let data: Data
        do {
            data = try Data(contentsOf: url)
        } catch {
            throw ConfigError.failedToRead
        }
        
        let config: StoredConfig
        do {
            config = try decoder.decode(StoredConfig.self, from: data)
        } catch {
            throw ConfigError.filedToDeserialize
        }
        return config
    }
}
