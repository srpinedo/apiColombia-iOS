//
//  HolidaysViewController.swift
//  apiColombia-iOS
//
//  Created by Joan on 4/02/26.
//

import UIKit

class HolidaysViewController: UIViewController {
    private let viewModel = HolidaysViewModel()
    
    private lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.register(UniversalCell.self, forCellReuseIdentifier: UniversalCell.identifier)
        tv.dataSource = self
        tv.delegate = self
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Festivos"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        setupUI()
        setupFilterButton()
        bindViewModel()
        viewModel.loadHolidays()
    }
    
    private func setupFilterButton() {
        let years = [2024, 2025, 2026, 2027]
        var actions: [UIAction] = []
        
        for year in years {
            let state: UIMenuElement.State = (viewModel.currentYear == year) ? .on : .off
            let action = UIAction(title: "\(year)", state: state) { [weak self] _ in
                self?.viewModel.changeYear(to: year)
            }
            actions.append(action)
        }
        
        let customAction = UIAction(title: "Otro año...", image: UIImage(systemName: "pencil")) { [weak self] _ in
            self?.presentYearInput()
        }
        
        let menu = UIMenu(title: "Seleccionar Año", options: .displayInline, children: actions + [customAction])
        let filterButton = UIBarButtonItem(title: nil, image: UIImage(systemName: "calendar.badge.clock"), primaryAction: nil, menu: menu)
        navigationItem.rightBarButtonItem = filterButton
    }
    
    private func presentYearInput() {
        let alert = UIAlertController(title: "Viajar en el tiempo ⏳", message: "Ingresa el año que quieres consultar", preferredStyle: .alert)
        
        alert.addTextField { tf in
            tf.placeholder = "Ej: 1988"
            tf.keyboardType = .numberPad
        }
        
        let searchAction = UIAlertAction(title: "Buscar", style: .default) { [weak self, weak alert] _ in
            guard let text = alert?.textFields?.first?.text, let year = Int(text) else { return }
            self?.viewModel.changeYear(to: year)
        }
        
        alert.addAction(searchAction)
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
        
        present(alert, animated: true)
    }
    
    private func setupUI() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func bindViewModel() {
        viewModel.onReloadData = { [weak self] in
            guard let self = self else { return }
            self.title = "Festivos \(self.viewModel.currentYear)"
            self.setupFilterButton()
            self.tableView.reloadData()
        }
    }
}

// MARK: - TableView
extension HolidaysViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UniversalCell.identifier, for: indexPath) as? UniversalCell else {
            return UITableViewCell()
        }
        
        let holiday = viewModel.holiday(at: indexPath.row)
        cell.configure(name: holiday.name, description: "Fecha: \(holiday.celebrationDate)")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // Por ahora no navegamos a ningún lado
    }
}
