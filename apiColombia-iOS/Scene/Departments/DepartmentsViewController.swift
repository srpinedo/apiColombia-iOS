//
//  DepartmentsViewController.swift
//  apiColombia-iOS
//
//  Created by Joan on 3/02/26.
//

import UIKit

class DepartmentsViewController: UIViewController {
    
    private let viewModel = DepartmentsViewModel()
    
    private lazy var searchController: UISearchController = {
        let sc = UISearchController(searchResultsController: nil)
        sc.searchResultsUpdater = self
        sc.obscuresBackgroundDuringPresentation = false
        sc.searchBar.placeholder = "Buscar departamento"
        return sc
    }()
    
    private lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.register(DepartmentCell.self, forCellReuseIdentifier: DepartmentCell.identifier)
        tv.dataSource = self
        tv.delegate = self
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        viewModel.loadData()
        setupNavigation()
        setupUI()
    }
    
    private func setupNavigation() {
        title = "Departamentos"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
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
}
// MARK: - Update Search Results
extension DepartmentsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let query = searchController.searchBar.text
        viewModel.filter(query: query)
        
        tableView.reloadData()
    }
}
// MARK: - TableView DataSource & Delegate
extension DepartmentsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DepartmentCell.identifier, for: indexPath) as? DepartmentCell else {
            return UITableViewCell()
        }
        
        let department = viewModel.item(at: indexPath.row)
        cell.configure(name: department.name, description: department.description)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("Seleccionado: \(viewModel.item(at: indexPath.row))")
    }
}
