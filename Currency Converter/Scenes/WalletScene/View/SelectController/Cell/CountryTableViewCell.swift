//
//  CountryTableViewCell.swift
//  Currency Converter
//
//  Created by Ruslan Liulka on 07.08.2023.
//

import UIKit

class CountryTableViewCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var flagView: UIImageView!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    
    // MARK: - Lifecycle funcs
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    // MARK: - Flow funcs
    private func configureUI() {
        countryLabel.font = UIFont(name: "Montserrat-SemiBold", size: 17)
        currencyLabel.font = UIFont(name: "Montserrat-Regular", size: 17)
        currencyLabel.textColor = .tabBarUnselected
    }
    
    func configure(code: String, country: String, currency: String) {
        flagView.image = UIImage(named: code)
        countryLabel.text = country
        currencyLabel.text = currency + " (\(code))"
    }
    
}
