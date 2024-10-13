//
//  UsdRateModel.swift
//  Currency Converter
//
//  Created by Ruslan Liulka on 07.08.2023.
//

import Foundation

struct UsdRateModel: Codable {
    let conversionRate: Double
    
    enum CodingKeys: String, CodingKey {
        case conversionRate = "conversion_rate"
    }
}
