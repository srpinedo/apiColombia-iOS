import Foundation

protocol ColombiaNetworkType {
    func getDepartments() async throws -> [Deparment]
}
