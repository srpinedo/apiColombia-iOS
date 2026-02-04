//
//  RegionViewModel.swift
//  apiColombia-iOS
//
//  Created by Joan on 4/02/26.
//

import Foundation

@MainActor

class RegionViewModel {
    private let repository: ColombiaNetworkType
    
    private var allRegions: [Region] = []
    
    private(set) var filteredRegions: [Region] = []
    
    var onReloadData: (() -> Void)?
    
    init(repository: ColombiaNetworkType = ColombiaNetwork.shared) {
        self.repository = repository
    }
    
    func loadData() {
        Task {
            do {
                allRegions = try await repository.getRegions()
                filteredRegions = allRegions
                onReloadData?()
            } catch {
                print("Error cargando regiones: \(error)")
            }
        }
    }
    
    var count: Int {
        return filteredRegions.count
    }
    
    func region(at index: Int) -> Region {
        return filteredRegions[index]
    }
    
    func filterRegions(query: String?) {
        guard let query = query, !query.isEmpty else {
            filteredRegions = allRegions
            return
        }
        
        filteredRegions = allRegions.filter {
            $0.name.localizedCaseInsensitiveContains(query)
        }
    }
}
