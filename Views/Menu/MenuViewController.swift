//
//  MenuViewController.swift
//  Views
//
//  Created by Богдан Маншилин on 01/02/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import UIKit

public final class MenuViewController: UITableViewController, MenuViewControllering {
    public var controller: UIViewController {
        return self
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        title = "Menu"
    }
    
}
