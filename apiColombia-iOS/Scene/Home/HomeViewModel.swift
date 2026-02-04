//
//  HomeViewModel.swift
//  apiColombia-iOS
//
//  Created by Joan on 3/02/26.
//

import UIKit

struct HomeCategory {
    let title: String
    let iconName: String
    let color: UIColor
    let type: CategoryType
}

enum CategoryType {
    case regions
    case departments
    case holidays
    case tourism
}

class HomeViewModel {
    
    private(set) var categories: [HomeCategory] = []
    
    init() {
        loadCategories()
    }
    
    private func loadCategories() {
        self.categories = [
            HomeCategory(title: "Regiones", iconName: "map.fill", color: .systemBlue, type: .regions),
            HomeCategory(title: "Departamentos", iconName: "building.2.fill", color: .systemGreen, type: .departments),
            HomeCategory(title: "Festivos", iconName: "calendar", color: .systemRed, type: .holidays),
            HomeCategory(title: "Turismo", iconName: "camera.fill", color: .systemOrange, type: .tourism)
        ]
    }
    
    var callbackNumberOfItems: Int {
        return categories.count
    }
    
    func item(at indexPath: IndexPath) -> HomeCategory {
        return categories[indexPath.row]
    }
}
