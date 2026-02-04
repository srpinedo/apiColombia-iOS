//
//  RegionResponse.swift
//  apiColombia-iOS
//
//  Created by Joan on 4/02/26.
//

import Foundation

struct RegionResponse: Decodable {
    let id: Int
    let name: String?
    let description: String?
    
    func toDomain() -> Region {
        return Region(id: id, name: name ?? "", description: description ?? "")
    }
}
