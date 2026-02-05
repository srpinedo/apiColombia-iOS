//
//  TourismViewModel.swift
//  apiColombia-iOS
//
//  Created by Joan on 4/02/26.
//

import Foundation

@MainActor
class TourismViewModel {
    
    private let repository: ColombiaNetworkType
    
    private var allAttractions: [TouristAttraction] = []
    
    private(set) var displayedAttractions: [TouristAttraction] = []
    
    private let itemsPerPage = 10
    private var currentPage = 0
    
    var onReloadData: (() -> Void)?
    var onLoading: ((Bool) -> Void)?
    
    var hasMoreData: Bool {
        return displayedAttractions.count < allAttractions.count
    }
    
    init(repository: ColombiaNetworkType = ColombiaNetwork.shared) {
        self.repository = repository
    }
    
    func loadData() {
        onLoading?(true)
        Task {
            defer { onLoading?(false) }
            do {
                allAttractions = try await repository.getAttractions()
                
                displayedAttractions = []
                currentPage = 0
                
                loadNextPage()
                
            } catch {
                print("Error cargando turismo: \(error)")
            }
        }
    }
    
    func loadNextPage() {
        guard hasMoreData else { return }
        
        let startIndex = currentPage * itemsPerPage
        let endIndex = min(startIndex + itemsPerPage, allAttractions.count)
        
        let newItems = Array(allAttractions[startIndex..<endIndex])
        displayedAttractions.append(contentsOf: newItems)
        
        currentPage += 1
        onReloadData?()
    }
    
    var count: Int { displayedAttractions.count }
    
    func item(at index: Int) -> TouristAttraction {
        return displayedAttractions[index]
    }
}
