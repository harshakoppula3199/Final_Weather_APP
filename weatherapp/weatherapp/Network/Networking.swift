//
//  Networking.swift
//  weatherapp
//
//  Created by rentamac on 1/26/26.
//

import Foundation

@MainActor
protocol Networking {
    func request<T: Decodable>(
        endpoint: APIEndpoint,
        responseType: T.Type
    ) async throws -> T
}
