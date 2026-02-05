//
//  TouristAttractionResponse.swift
//  apiColombia-iOS
//
//  Created by Joan on 4/02/26.
//

import Foundation

struct TouristAttractionResponse: Decodable {
    let id: Int
    let name: String?
    let description: String?
    let cityId: Int?
    let images: [String]?
    
    func toDomain() -> TouristAttraction {
        return TouristAttraction(
            id: id,
            name: name ?? "",
            description: description ?? "",
            cityId: cityId,
            images: images ?? []
        )
    }
}
