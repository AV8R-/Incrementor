//
//  IncrementViewController.swift
//  Views
//
//  Created by Богдан Маншилин on 02/02/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import UIKit
import ViewModels

public final class IncrementViewController: UIViewController, IncrementViewControlling {
    
    public init(viewModel: IncrementViewModelling) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var viewModel: IncrementViewModelling
    weak var button: UIButton!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        title = "Incrementor"
        view.backgroundColor = .white
        
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("0", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 100, weight: .medium)
        button.setTitleColor(.black, for: .normal)
        view.addSubview(button)
        self.button = button
        button.addTarget(self, action: #selector(increment), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        _=viewModel.value.bind(onNext: { [weak self] value in
            self?.button.setTitle("\(value)", for: .normal)
        })
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Reset", style: .done, target: self, action: #selector(reset))
    }
    
    @objc
    func increment() {
        viewModel.increment()
    }
    
    @objc
    func reset() {
        viewModel.reset()
    }
    
}
