//
//  NetworkError.swift
//  apiColombia-iOS
//
//  Created by Joan on 3/02/26.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case decodingFailed(Error)
    case serverError(Int)
    case unknown
    
    var errorDescription: String {
        switch self {
        case .invalidURL: return "La URL no es válida."
        case .requestFailed(let error): return "Error en la petición: \(error.localizedDescription)"
        case .invalidResponse: return "Respuesta inválida del servidor."
        case .decodingFailed(let error): return "Error al leer datos: \(error.localizedDescription)"
        case .serverError(let code): return "Error del servidor. Código: \(code)"
        case .unknown: return "Error desconocido."
        }
    }
}
