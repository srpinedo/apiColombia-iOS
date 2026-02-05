//
//  HomeViewController.swift
//  apiColombia-iOS
//
//  Created by Joan on 3/02/26.
//

import UIKit

class HomeViewController: UIViewController {

    private let viewModel = HomeViewModel()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let width = (UIScreen.main.bounds.width - 48) / 2
        layout.itemSize = CGSize(width: width, height: 120)
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 20, left: 16, bottom: 20, right: 16)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .systemGroupedBackground
        cv.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.identifier)
        cv.dataSource = self
        cv.delegate = self
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGroupedBackground
        title = "Inicio"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor), 
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.callbackNumberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as? CategoryCell else {
            return UICollectionViewCell()
        }
        
        let item = viewModel.item(at: indexPath)
        cell.configure(title: item.title, img: item.iconName, color: item.color)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = viewModel.item(at: indexPath)
        
        var destinationVC: UIViewController?
        
        switch item.type {
        case .departments:
            destinationVC = DepartmentsViewController()
        case .regions:
            destinationVC = RegionViewController()
        case .holidays:
            destinationVC = HolidaysViewController()
        case .tourism:
            destinationVC = TourismViewController()
        }
        
        if let vc = destinationVC {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
