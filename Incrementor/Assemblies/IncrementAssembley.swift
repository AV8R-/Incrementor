//
//  IncrementAssembley.swift
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

struct IncrementAssembley: Assembly {
    func assemble(container: Container) {
        
        // View
        container.register(IncrementViewControlling.self) { resolver in
            return IncrementViewController(
                viewModel: try! resolver.resolve()
            )
        }
        
        // ViewModel
        container.register(IncrementViewModelling.self) { resolver in
            return IncrementViewModel(incrementor: try! resolver.resolve())
        }
        
        // Services
        container.register(Incrementing.self) { resolver in
            return try! Incrementor(
                config: resolver.resolve(),
                storage: resolver.resolve()
            )
        }
    }
}
