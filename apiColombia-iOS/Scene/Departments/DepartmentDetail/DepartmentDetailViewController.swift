//
//  DepartmentDetailViewController.swift
//  apiColombia-iOS
//
//  Created by Joan on 4/02/26.
//

import UIKit

class DepartmentDetailViewController: UIViewController {
    
    private let department: Deparment
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = .init(top: 20, left: 20, bottom: 20, right: 20)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    init(department: Deparment) {
        self.department = department
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = department.name
        setupUI()
        infoDept()
    }
    
    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    private func infoDept() {
        let descTitle = UILabel()
        descTitle.text = "Descripción"
        descTitle.font = .systemFont(ofSize: 18, weight: .bold)
        stackView.addArrangedSubview(descTitle)
        
        let descBody = UILabel()
        descBody.text = department.description
        descBody.numberOfLines = 0
        descBody.font = .systemFont(ofSize: 16)
        descBody.textColor = .secondaryLabel
        stackView.addArrangedSubview(descBody)
        
        stackView.addArrangedSubview(UIView())
    }
}
