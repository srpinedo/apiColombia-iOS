//
//  Endpoint.swift
//  apiColombia-iOS
//
//  Created by Joan on 3/02/26.
//

import Foundation

protocol Endpoint {
    var path: String { get }
    var method: String { get }
}

extension Endpoint {
    var baseURL: String {
        return "https://api-colombia.com/api/v1"
    }
    
    var method: String {
        return "GET"
    }
    
    var url: URL? {
        guard let url = URL(string: baseURL + path) else { return nil }
        return url
    }
}

enum APIEndpoint: Endpoint {
    case allDepartments
    case allRegions
    case allHolidays(year: Int)
    
    var path: String {
        switch self {
        case .allDepartments: return "/Department"
        case .allRegions: return "/Region"
        case .allHolidays(let year): return "/Holiday/year/\(year)"
        }
    }
}
