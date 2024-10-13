//
//  SelectViewModelProtocol.swift
//  Currency Converter
//
//  Created by Ruslan Liulka on 09.08.2023.
//

import Foundation
import RxSwift

protocol SelectViewModelProtocol {
    var backSubject: PublishSubject<Void> { get }
    var selectedCountry: PublishSubject<(String, CurrencyCodeAndName)> { get }
}
