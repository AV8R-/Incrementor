//
//  Config.swift
//  Services
//
//  Created by Богдан Маншилин on 01/02/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import Foundation

public struct StoredConfig: Config, Codable, Storable {
    private static let filename = "Config"
    private var filePath: URL { return StoredConfig.fullPath(file: StoredConfig.filename) }
    private enum CodingKeys: String, CodingKey {
        case step, max
    }
    
    public var step: Int
    public var max: Int
    
    private init() {
        step = 1
        max = Int.max
    }
    
    public static let `default`: Config = StoredConfig()
    public static var stored: Config? {
        return try? parseConfig()
    }
    
    public func save() throws {
        try storeConfig()
    }
    
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
