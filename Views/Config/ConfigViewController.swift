//
//  ConfigViewController.swift
//  Views
//
//  Created by Богдан Маншилин on 02/02/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import Foundation
import ViewModels

public final class ConfigViewController: UITableViewController, ConfigViewControlling {
    
    private enum Constants {
        static let cell = "cell"
    }
    
    private weak var stepTextField: UITextField! {
        didSet {
            stepTextField.text = "\(viewModel.step.value)"
            _=viewModel.step.bind(onNext: { [weak self] new in
                self?.stepTextField.text = "\(new)"
            })
        }
    }
    private weak var maxTextField: UITextField! {
        didSet {
            maxTextField.text = "\(viewModel.max.value)"
            _=viewModel.max.bind(onNext: { [weak self] new in
                self?.maxTextField.text = "\(new)"
            })
        }
    }
    private var viewModel: ConfigViewModelling
    public init(viewModel: ConfigViewModelling, style: UITableViewStyle) {
        self.viewModel = viewModel
        super.init(style: style)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        title = "Preferences"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.cell)
        tableView.rowHeight = 44
    }
    
    public override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    public override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "Step"
        case 1: return "Max"
        default: return ""
        }
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cell)!
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .numberPad
        cell.contentView.addSubview(textField)
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: 20),
            textField.topAnchor.constraint(equalTo: cell.contentView.topAnchor),
            textField.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor),
        ])
        
        textField.addTarget(self, action: #selector(valueChanged(_:)), for: .editingChanged)
        
        switch indexPath.section {
        case 0: stepTextField = textField
        case 1: maxTextField = textField
        default: ()
        }
        
        return cell
    }
    
    @objc
    public func valueChanged(_ sender: UITextField) {
        let value = Int(sender.text ?? "") ?? 0
        if sender === stepTextField {
            viewModel.set(step: value)
        } else if sender === maxTextField {
            viewModel.set(max: value)
        }
    }
    
}
