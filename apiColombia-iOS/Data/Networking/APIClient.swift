import Foundation

protocol APIClientType {
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T
}

class APIClient: APIClientType {
    
    static let shared = APIClient()
    
    private let urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        
        guard let url = endpoint.url else {
            print("❌ [API] Error: URL inválida para endpoint: \(endpoint.path)")
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        print("\n🚀 [REQUEST] \(endpoint.method) \(url.absoluteString)")
        
        do {
            let (data, response) = try await urlSession.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("❌ [ERROR] Respuesta no es HTTP")
                throw NetworkError.invalidResponse
            }
            
            print("📥 [RESPONSE] Status Code: \(httpResponse.statusCode)")
            
            guard (200...299).contains(httpResponse.statusCode) else {
                print("❌ [FAILURE] Server Error: \(httpResponse.statusCode)")
                throw NetworkError.serverError(httpResponse.statusCode)
            }
            
            if let jsonString = String(data: data, encoding: .utf8) {
                print("📦 [DATA]: \(jsonString)")
            }
            
            let decoder = JSONDecoder()
            let decodedObject = try decoder.decode(T.self, from: data)
            
            print("✅ [SUCCESS] Decodificado correctamente a \(T.self)")
            return decodedObject
            
        } catch {
            print("❌ [FAILURE] Error en la petición: \(error)")
            throw NetworkError.requestFailed(error)
        }
    }
}
