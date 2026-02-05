import Foundation

protocol ColombiaNetworkType {
    func getDepartments() async throws -> [Department]
    func getRegions() async throws -> [Region]
    func getHolidays(year: Int) async throws -> [Holiday]
}
