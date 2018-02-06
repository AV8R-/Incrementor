//
//  Services.swift
//  Incrementor
//
//  Created by Богдан Маншилин on 05/02/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import Foundation
import Swinject
import Services

struct ServicesAssembley: Assembly {
    func assemble(container: Container) {
        container.register(Storing.self) { _ in DiskStorage() }
    }
}
