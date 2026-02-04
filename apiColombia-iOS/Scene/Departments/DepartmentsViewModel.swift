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
    
    private var allDepartments: [Deparment] = []
    
    private(set) var filteredDepartments: [Deparment] = []
    
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
    
    func item(at index: Int) -> Deparment {
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
