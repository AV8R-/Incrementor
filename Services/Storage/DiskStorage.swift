//
//  DiskStorage.swift
//  Services
//
//  Created by Богдан Маншилин on 01/02/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import Foundation

/**
 Стандартное дисковое хранилище.
 Может сохранить на диск любую примитивную переменную
 */
public final class DiskStorage: Storing, Storable {
    
    public init() {}
    
    /**
     Сохраняет указанное примитивное значение.
     
     - Parameters:
         - value: значение любого из примитивных типов. При попытке передать
             не примитивное значение может произойти крэш
         - path: путь по которому нужно сохранить переменную
     
     - Throws:
     Исклчючения типа StorageError
     */
    public func store<T>(_ value: T, path: [String]) throws {
        let filename = path.joined(separator: "_")
        let data = NSKeyedArchiver.archivedData(withRootObject: value)
        let filePath = fullPath(file: filename)
        
        do {
            try data.write(to: filePath)
        } catch {
            throw StorageError.failedToWriteValue
        }

    }
    
    /**
     Извлекает значение из памяти по указанному пути
     
     - Parameter path: путь по которому нужно извлечь переменную
     
     - Throws:
     Исклчючения типа StorageError
     */
    public func get<T>(path: [String]) throws -> T {
        let filename = path.joined(separator: "_")
        let filePath = fullPath(file: filename)
        guard isExists(filePath: filePath) else {
            throw StorageError.storageNotInitialized(reason: "No file for variable at path \(path) created yet")
        }
        guard let value = NSKeyedUnarchiver.unarchiveObject(with: try Data(contentsOf: filePath)) else {
            throw StorageError.valueNotFound(path: path)
        }
        
        guard let safeValue = value as? T else {
            throw StorageError.valueHasAnotherType(expected: T.self)
        }
        
        return safeValue
    }
}
