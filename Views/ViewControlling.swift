//
//  ViewControlling.swift
//  Views
//
//  Created by Богдан Маншилин on 02/02/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import UIKit

public protocol ViewControlling {
    var controller: UIViewController { get }
}

extension ViewControlling where Self: UIViewController {
    public var controller: UIViewController {
        return self
    }
}
