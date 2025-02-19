//
//  RealmManagerProtocol.swift
//  Currency Converter
//
//  Created by Ruslan Liulka on 08.08.2023.
//

import Foundation

protocol RealmManagerWalletProtocol {
    func saveWalletModels(walletModels: WalletModel)
    func loadWalletModels(completion: @escaping([WalletModel]) -> Void)
    func cleanAll()
}
