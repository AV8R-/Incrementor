//
//  MenuViewControlling.swift
//  Views
//
//  Created by Богдан Маншилин on 02/02/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import Foundation

/// View для экрана меню
public protocol MenuViewControllering: ViewControlling {
    /// Конструктор
    ///
    /// - Parameters:
    ///   - incrementor: Фабрика для создания экрана инкремента
    ///   - config: Фабрика для создания экрана конфигурации
    init(
        incrementor: @escaping () -> IncrementViewControlling,
        config: @escaping () -> ConfigViewControlling
    )
}
