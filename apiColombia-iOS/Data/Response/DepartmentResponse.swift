//
//  DepartmentResponse.swift
//  apiColombia-iOS
//
//  Created by Joan on 4/02/26.
//

import Foundation

struct DepartmentResponse: Decodable {
    let id: Int
    let name: String
    let description: String?
    let cityCapitalId: Int?
    
    func toDomain() -> Department {
        return Department(
            id: id,
            name: name,
            description: description ?? "",
            cityCapitalId: cityCapitalId ?? 0
        )
    }
}
