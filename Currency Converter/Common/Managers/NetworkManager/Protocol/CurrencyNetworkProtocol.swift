//
//  CurrencyNetworkProtocol.swift
//  Currency Converter
//
//  Created by Ruslan Liulka on 10.08.2023.
//

import Foundation

protocol CurrencyNetworkProtocol {
    func getRates(for code: String) async throws -> CurencyListResponceSuccess
}
