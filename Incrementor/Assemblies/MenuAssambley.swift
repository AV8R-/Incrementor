//
//  MenuAssambley.swift
//  Incrementor
//
//  Created by Богдан Маншилин on 05/02/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import Foundation
import Swinject
import Views

struct MenuAssembley: Assembly {
    func assemble(container: Container) {
        container.register(MenuViewControllering.self) { resolver in
            return MenuViewController(
                incrementor: { try! resolver.resolve()},
                config: { try! resolver.resolve()}
            )
        }
    }
}
