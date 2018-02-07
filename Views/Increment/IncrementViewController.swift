//
//  IncrementViewController.swift
//  Views
//
//  Created by Богдан Маншилин on 02/02/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import UIKit
import ViewModels
import RxSwift

public final class IncrementViewController: UIViewController, IncrementViewControlling {
    
    public init(viewModel: IncrementViewModelling) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var viewModel: IncrementViewModelling
    private let disposeBag = DisposeBag()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        title = "Incrementor"
        view.backgroundColor = .white
        
        let inc = makeIncrementControl()
        view.addSubview(inc)
        incrementButton = inc
        
        NSLayoutConstraint.activate([
            inc.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            inc.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        navigationItem.rightBarButtonItem = makeResetButton()
        resetButton = navigationItem.rightBarButtonItem!
    }
    
    // Необходимости UI тестов
    weak var incrementButton: UIButton!
    weak var resetButton: UIBarButtonItem!
    
}

extension IncrementViewController {
    private func makeIncrementControl() -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("0", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 100, weight: .medium)
        button.setTitleColor(.black, for: .normal)
        viewModel.value
            .map { String($0) }
            .bind(to: button.rx.title())
            .disposed(by: disposeBag)
        viewModel.increment = button.rx.tap
        
        return button
    }
    
    private func makeResetButton() -> UIBarButtonItem {
        let button = UIBarButtonItem(title: "Reset", style: .done, target: nil, action: nil)
        viewModel.reset = button.rx.tap
        return button
    }
}
