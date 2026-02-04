import Foundation

protocol ColombiaNetworkType {
    func getDepartments() async throws -> [Department]
    func getRegions() async throws -> [Region]
}
