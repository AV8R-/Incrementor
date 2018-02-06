//
//  ConfigurationAssambley.swift
//  Incrementor
//
//  Created by Богдан Маншилин on 05/02/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import Foundation
import Swinject
import Views
import ViewModels
import Services

struct ConfigurationAssembley: Assembly {
    func assemble(container: Container) {
        
        // Service
        container.register(Config.self) { resolver in
            let store: Storing = try! resolver.resolve()
            return (try? StoredConfig.stored(store: store))
                ?? StoredConfig.default(store: store)
        }
        
        // ViewModel
        container.register(ConfigViewModelling.self) { resolver in
            return ConfigViewModel(config: try! resolver.resolve())
        }
        
        // View
        container.register(ConfigViewControlling.self) { resolver in
            return ConfigViewController(
                viewModel: try! resolver.resolve(),
                style: .grouped
            )
        }
    }
}
