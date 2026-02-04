//
//  DepartmentsViewModel.swift
//  apiColombia-iOS
//
//  Created by Joan on 3/02/26.
//

import Foundation

@MainActor
class DepartmentsViewModel {
    
    private let repository: ColombiaNetworkType
    
    private var allDepartments: [Department] = []
    
    private(set) var filteredDepartments: [Department] = []
    
    var onReloadData: (() -> Void)?
    
    init(repository: ColombiaNetworkType = ColombiaNetwork.shared) {
        self.repository = repository
    }
    
    func loadData() {
        Task {
            do {
                allDepartments = try await repository.getDepartments()
                filteredDepartments = allDepartments
                onReloadData?()
            } catch {
                print("Error cargando departamentos: \(error)")
            }
        }
    }
    
    var count: Int { filteredDepartments.count }
    
    func item(at index: Int) -> Department {
        return filteredDepartments[index]
    }
    
    func filter(query: String?) {
        guard let query = query, !query.isEmpty else {
            filteredDepartments = allDepartments
            return
        }
        filteredDepartments = allDepartments.filter {
            $0.name.localizedCaseInsensitiveContains(query)
        }
    }
}
