//
//  Storable.swift
//  Services
//
//  Created by Богдан Маншилин on 01/02/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import Foundation

enum StorageError: Swift.Error {
    case storageNotInitialized(reason: String)
    case valueNotFound(path: [String])
    case valueHasAnotherType(expected: Any.Type)
    case failedToWriteValue
    case failedToSerialize
    case failedToDeserialize
}

public protocol Storing {
    
    /**
     Сохраняет заданное значение на диске.
     
     - throws:
     Ошибки типа `StorageError`
     
     - parameters:
        - value: значение, которое нужно сохранить
        - path: путь по которому будет сохранена переменная
     */
    func store<T>(_ value: T, path: [String]) throws
    
    /**
      Считывает значение по указанному пути.
     
     - throws:
     Ошибки типа `StorageError`
     
     - parameters:
         - path: путь, по которому будет прочитана переменная
     
     - returns:
     найденное значение
     */
    func get<T>(path: [String]) throws -> T
}
