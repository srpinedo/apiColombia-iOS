//
//  HolidayResponse.swift
//  apiColombia-iOS
//
//  Created by Joan on 4/02/26.
//

import Foundation

struct HolidayResponse: Decodable {
    let name: String?
    let date: String?
    let celebrationDate: String?
    
    func toDomain() -> Holiday {
        let rawDateString = celebrationDate ?? date ?? ""
        
        let formattedDate = formatDate(rawDateString)
        
        return Holiday(
            name: name ?? "",
            date: date ?? "",
            celebrationDate: formattedDate
        )
    }
    
    private func formatDate(_ isoDate: String) -> String {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        let simpleFormatter = DateFormatter()
        simpleFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        if let dateObj = simpleFormatter.date(from: isoDate) {
            let displayFormatter = DateFormatter()
            displayFormatter.dateStyle = .long
            displayFormatter.locale = Locale(identifier: "es_CO")
            return displayFormatter.string(from: dateObj)
        }
        
        return String(isoDate.prefix(10))
    }
}
