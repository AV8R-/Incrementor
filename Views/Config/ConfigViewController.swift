//
//  ConfigViewController.swift
//  Views
//
//  Created by Богдан Маншилин on 02/02/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import Foundation
import ViewModels
import RxCocoa
import RxSwift

public final class ConfigViewController: UITableViewController, ConfigViewControlling {
    
    private enum Constants {
        static let cell = "cell"
    }
    
    private let disposeBag = DisposeBag()
    
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
        
        switch indexPath.section {
        case 0:
            bind(textField: textField, to: viewModel.step)
            stepTextField = textField
        case 1:
            bind(textField: textField, to: viewModel.max)
            maxTextField = textField
        default: ()
        }

        return cell
    }
    
    private func bind(textField: UITextField, to: BehaviorRelay<Int>) {
        textField.text = "\(to.value)"
        textField.rx.text
            .map {(Int($0 ?? "") ?? 0)}
            .bind(to: to)
            .disposed(by: disposeBag)

    }
    
    // UI tests необходимости
    weak var stepTextField: UITextField!
    weak var maxTextField: UITextField!
}
