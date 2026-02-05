//
//  HolidaysViewModel.swift
//  apiColombia-iOS
//
//  Created by Joan on 4/02/26.
//

import Foundation

@MainActor
class HolidaysViewModel {
    private let repository: ColombiaNetworkType
    
    private var allHolidays: [Holiday] = []
    
    private(set) var currentYear: Int = Calendar.current.component(.year, from: Date())
    
    var onReloadData: (() -> Void)?
    var onLoading: ((Bool) -> Void)?
    
    init(repository: ColombiaNetworkType = ColombiaNetwork.shared) {
        self.repository = repository
    }

    func loadHolidays(year: Int? = nil) {
        if let year = year {
            self.currentYear = year
        }
        
        onLoading?(true)
        
        Task {
            defer { onLoading?(false) } 
            do {
                allHolidays = try await repository.getHolidays(year: currentYear)
                onReloadData?()
            } catch {
                print("Error cargando festivos \(error)")
            }
        }
    }
    
    func changeYear(to year: Int) {
        loadHolidays(year: year)
    }
    
    var count: Int {
        return allHolidays.count
    }
    
    func holiday(at index: Int) -> Holiday {
        return allHolidays[index]
    }
}
