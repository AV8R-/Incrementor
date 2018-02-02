//
//  Storable.swift
//  Services
//
//  Created by Богдан Маншилин on 01/02/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import Foundation

internal protocol Storable {
}

extension Storable {
    internal static func fullPath(file: String) -> URL {
        return getDocumentsDirectory().appendingPathComponent(file)
    }
    
    internal static func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    internal static func isExists(filePath: URL) -> Bool {
        return FileManager.default.fileExists(atPath: filePath.path)
    }

    internal func fullPath(file: String) -> URL {
        return getDocumentsDirectory().appendingPathComponent(file)
    }
    
    internal func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    internal func isExists(filePath: URL) -> Bool {
        return FileManager.default.fileExists(atPath: filePath.path)
    }
}
