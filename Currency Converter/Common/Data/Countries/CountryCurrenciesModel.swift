//
//  CurrencyCountriesModel.swift
//  Currency Converter
//
//  Created by Ruslan Liulka on 05.08.2023.
//

import Foundation

struct CurrencyCodeAndName: Codable, Hashable {
    let currencyCode, currencyName: String

    enum CodingKeys: String, CodingKey {
        case currencyCode = "Currency Code"
        case currencyName = "Currency Name"
    }
}

typealias CountryCurrencies = [String: CurrencyCodeAndName]
