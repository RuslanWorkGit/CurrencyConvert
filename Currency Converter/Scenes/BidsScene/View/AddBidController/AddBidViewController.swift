//
//  AddBidViewController.swift
//  Currency Converter
//
//  Created by Ruslan Liulka on 08.08.2023.
//

import UIKit
import RxSwift

class AddBidViewController: BaseViewController {
    
    // MARK: - Properties
    var viewModel: BidsViewModelProtocol!
    
    // MARK: - IBOutlets
    @IBOutlet weak var topTitleLabel: UILabel!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var fromCountryView: SelectCountryView!
    @IBOutlet weak var toLabel: UILabel!
    @IBOutlet weak var toCountryView: SelectCountryView!
    @IBOutlet weak var addButton: UIButton!
 
    // MARK: - Lifecycle funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        configureUI()
        setupBindings()
        addTapGesture()
        checkInput()
        setupDismissKeyboardGesture()
    }
    // MARK: - Flow funcs
    private func setupNavBar() {
        navigationItem.hidesBackButton = true
        setupBackNavBar(title: "Add Bid") { [weak self] in
            self?.viewModel.backSubject.onNext(())
        }
    }
    
    private func configureUI() {
        topTitleLabel.text = "Bid Value (CAD)"
        topTitleLabel.font = UIFont(name: "Montserrat-SemiBold", size: 17)
        fromLabel.text = "Select Country Currency (From)"
        fromLabel.font = UIFont(name: "Montserrat-SemiBold", size: 17)
        toLabel.text = "Select Country Currency (To)"
        toLabel.font = UIFont(name: "Montserrat-SemiBold", size: 17)
        addButton.backgroundColor = .tabBarUnselected
        addButton.layer.cornerRadius = 8
        addButton.tintColor = .white
        amountTextField.placeholder = "Enter Bid Value"
        amountTextField.keyboardType = .numberPad
        amountTextField.textColor = .tabBarSelected
    }
    
    private func addTapGesture() {
        let fromTapGestureRecognizer = UITapGestureRecognizer(target: nil, action: nil)
        fromCountryView.addGestureRecognizer(fromTapGestureRecognizer)
        fromTapGestureRecognizer.rx.event
              .subscribe(onNext: { [weak self] _ in
                  self?.viewModel.selectSubject.onNext(())
                  self?.viewModel.target = .from
              })
              .disposed(by: bag)
        
        let toTapGestureRecognizer = UITapGestureRecognizer(target: nil, action: nil)
        toCountryView.addGestureRecognizer(toTapGestureRecognizer)
        toTapGestureRecognizer.rx.event
              .subscribe(onNext: { [weak self] _ in
                  self?.viewModel.selectSubject.onNext(())
                  self?.viewModel.target = .to
              })
              .disposed(by: bag)
    }
    private func setupBindings() {
        viewModel.selectedCountry
            .subscribe(onNext:  { [weak self] item in
                guard let self else { return }
                switch viewModel.target {
                case .from:
                    fromCountryView.configure(country: item.0, currency: item.1.currencyName, code: item.1.currencyCode)
                    viewModel.fromCode = item.1.currencyCode
                case .to:
                    toCountryView.configure(country: item.0, currency: item.1.currencyName, code: item.1.currencyCode)
                    viewModel.toCode = item.1.currencyCode
                }
               
            }).disposed(by: bag)
        let buttonObserver = addButton.rx.tap
        buttonObserver
            .bind(to: viewModel.backSubject)
            .disposed(by: bag)
        buttonObserver
            .subscribe { [weak self] _ in
                guard let self else { return }
                Task {
                    if let amountString = self.amountTextField.text,
                    let amount = Double(amountString) {
                        try? await self.viewModel.addBid(fromCode: self.viewModel.fromCode, toCode: self.viewModel.toCode, amount: amount)
                    }
                }
            }.disposed(by: bag)
    }
    
    private func checkInput() {
        let inputObservable = amountTextField.rx.text.orEmpty
              .map { !$0.isEmpty }

          let selectObservable = viewModel.selectedCountry

          Observable.combineLatest(inputObservable, selectObservable)
              .subscribe(onNext: { [weak self] isValid, isSelected in
                  guard let self else { return }
                  self.updateButtonState(isValid: isValid, isSelected: self.fromCountryView.isSelected && self.toCountryView.isSelected)
              })
              .disposed(by: bag)
    }
    private func updateButtonState(isValid: Bool, isSelected: Bool) {
        if isValid, isSelected {
            self.addButton.backgroundColor = .addBlue
            self.addButton.isEnabled = true
        } else {
            self.addButton.backgroundColor = .tabBarUnselected
            self.addButton.isEnabled = false
        }
    }
}
