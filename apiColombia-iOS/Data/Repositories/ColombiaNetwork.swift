import Foundation

class ColombiaNetwork: ColombiaNetworkType {

    static let shared = ColombiaNetwork()
    
    private let api: APIClient
    
    init(api: APIClient = .shared) {
        self.api = api
    }
    
    // MARK: - Departamentos
    func getDepartments() async throws -> [Deparment] {
        let response: [DepartmentResponse] = try await api.request(APIEndpoint.allDepartments)
        
        return response.map { $0.toDomain() }
    }
    
}
