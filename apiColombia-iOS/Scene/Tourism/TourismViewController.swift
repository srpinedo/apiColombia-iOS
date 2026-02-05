//
//  TourismViewController.swift
//  apiColombia-iOS
//
//  Created by Joan on 4/02/26.
//

import UIKit

class TourismViewController: UIViewController {

    private let viewModel = TourismViewModel()
    
    private lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.register(UniversalCell.self, forCellReuseIdentifier: UniversalCell.identifier)
        tv.dataSource = self
        tv.delegate = self
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView(style: .large)
        ai.hidesWhenStopped = true
        ai.translatesAutoresizingMaskIntoConstraints = false
        return ai
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Sitios Turísticos"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        setupUI()
        bindViewModel()
        viewModel.loadData()
    }
    
    private func setupUI() {
        view.addSubview(tableView)
        view.addSubview(loadingIndicator)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func bindViewModel() {
        viewModel.onReloadData = { [weak self] in
            self?.tableView.reloadData()
        }
        
        viewModel.onLoading = { [weak self] isLoading in
            if isLoading {
                self?.loadingIndicator.startAnimating()
            } else {
                self?.loadingIndicator.stopAnimating()
            }
        }
    }
}

// MARK: - TableView & Infinite Scroll
extension TourismViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UniversalCell.identifier, for: indexPath) as? UniversalCell else {
            return UITableViewCell()
        }
        
        let attraction = viewModel.item(at: indexPath.row)
        cell.configure(name: attraction.name, description: attraction.description)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.count - 1 && viewModel.hasMoreData {
            viewModel.loadNextPage()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let select = viewModel.item(at: indexPath.row)
        let detailVC = TourismDetailViewController(attraction: select)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
