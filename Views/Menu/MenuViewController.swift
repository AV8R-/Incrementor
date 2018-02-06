//
//  MenuViewController.swift
//  Views
//
//  Created by Богдан Маншилин on 01/02/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import UIKit

public final class MenuViewController: UITableViewController, MenuViewControllering {    
    private enum Constants {
        static let cellIdentifier = "cell"
    }
    
    public init(incrementor: @escaping () -> IncrementViewControlling, config: @escaping () -> ConfigViewControlling) {
        self.makeIncrementor = incrementor
        self.makeConfig = config
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let makeIncrementor: () -> IncrementViewControlling
    private let makeConfig: () -> ConfigViewControlling
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        title = "Menu"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
        navigationItem.largeTitleDisplayMode = .always
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 60, bottom: 0, right: 0)
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier)!
        switch indexPath.row {
        case 0:
            let image = UIImage(named: "pp", in: Views.bundle, compatibleWith: nil)?
                .resizeImage(withSize: CGSize.init(width: 28, height: 28), scaleMode: .contentAspectFit)?
                .withRenderingMode(.alwaysTemplate)
            cell.imageView?.image = image
            cell.textLabel?.text = "Increment"
        case 1:
            let image = UIImage(named: "config", in: Views.bundle, compatibleWith: nil)?
                .resizeImage(withSize: CGSize.init(width: 28, height: 28), scaleMode: .contentAspectFit)?
                .withRenderingMode(.alwaysTemplate)
            cell.imageView?.image = image
            cell.textLabel?.text = "Preferences"
        default: ()
        }
        
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller: UIViewController
        switch indexPath.row {
        case 0: controller = makeIncrementor().controller
        case 1: controller = makeConfig().controller
        default: return
        }
        navigationController?.show(controller, sender: nil)
    }
    
}
