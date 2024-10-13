//
//  CurrencyListModel.swift
//  Currency Converter
//
//  Created by Ruslan Liulka on 05.08.2023.
//

import Foundation

struct CurencyListResponceSuccess: Codable {

    let conversionRates: [String: Double]

    enum CodingKeys: String, CodingKey {
        case conversionRates = "conversion_rates"
    }
}
