//
//  BidsNetworkProtocol.swift
//  Currency Converter
//
//  Created by Ruslan Liulka on 10.08.2023.
//

import Foundation

protocol BidsNetworkProtocol {
    func getBidAmount(from: String, to: String, amount: Double) async throws -> Double
}
