import Foundation

class ColombiaNetwork: ColombiaNetworkType {

    static let shared = ColombiaNetwork()
    
    private let api: APIClient
    
    init(api: APIClient = .shared) {
        self.api = api
    }
    
    // MARK: - Departamentos
    func getDepartments() async throws -> [Department] {
        let response: [DepartmentResponse] = try await api.request(APIEndpoint.allDepartments)
        return response.map { $0.toDomain() }
    }

    // MARK: - Regiones
    func getRegions() async throws -> [Region] {
        let response: [RegionResponse] = try await api.request(APIEndpoint.allRegions)
        return response.map { $0.toDomain() }
    }
    
    // MARK: - Festivos
    func getHolidays(year: Int) async throws -> [Holiday] {
        let response: [HolidayResponse] = try await api.request(APIEndpoint.allHolidays(year: year))
        return response.map { $0.toDomain() }
    }
    
    // MARK: - Turismo
    func getAttractions() async throws -> [TouristAttraction] {
        let response: [TouristAttractionResponse] = try await api.request(APIEndpoint.allAttractions)
        return response.map { $0.toDomain() }
    }
    
}
