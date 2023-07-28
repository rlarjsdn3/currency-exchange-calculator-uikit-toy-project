//
//  ViewController.swift
//  KRW-USD Calculator
//
//  Created by 김건우 on 7/27/23.
//

import UIKit

class ViewController: UIViewController {
    
    private let mainView = MainView()
    
    private let dunamuManager = DunamuManager()
    
    private var primeExchangeRate = 0.90
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        makeUI()
        setTarget()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        resetExchangeRate()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func makeUI() {
        let rate100 = UIAction(title: "100%", handler: { [weak self] _ in
            self?.primeExchangeRate = 1.0
            self?.mainView.primeExchangeRateMenu.setTitle("100%", for: .normal)
            self?.calulateWonDollarValue()
        })
        let rate90 = UIAction(title: "90%", handler: { [weak self] _ in
            self?.primeExchangeRate = 0.9
            self?.mainView.primeExchangeRateMenu.setTitle("90%", for: .normal)
            self?.calulateWonDollarValue()
        })
        let rate80 = UIAction(title: "80%", handler: { [weak self] _ in
            self?.primeExchangeRate = 0.8
            self?.mainView.primeExchangeRateMenu.setTitle("80%", for: .normal)
            self?.calulateWonDollarValue()
        })
        let rate70 = UIAction(title: "70%", handler: { [weak self] _ in
            self?.primeExchangeRate = 0.7
            self?.mainView.primeExchangeRateMenu.setTitle("70%", for: .normal)
            self?.calulateWonDollarValue()
        })
        let rate60 = UIAction(title: "60%", handler: { [weak self] _ in
            self?.primeExchangeRate = 0.6
            self?.mainView.primeExchangeRateMenu.setTitle("60%", for: .normal)
            self?.calulateWonDollarValue()
        })
        let rate50 = UIAction(title: "50%", handler: { [weak self] _ in
            self?.primeExchangeRate = 0.5
            self?.mainView.primeExchangeRateMenu.setTitle("50%", for: .normal)
            self?.calulateWonDollarValue()
        })
        let rate40 = UIAction(title: "40%", handler: { [weak self] _ in
            self?.primeExchangeRate = 0.4
            self?.mainView.primeExchangeRateMenu.setTitle("40%", for: .normal)
            self?.calulateWonDollarValue()
        })
        let rate30 = UIAction(title: "30%", handler: { [weak self] _ in
            self?.primeExchangeRate = 0.3
            self?.mainView.primeExchangeRateMenu.setTitle("30%", for: .normal)
            self?.calulateWonDollarValue()
        })
        let rate20 = UIAction(title: "20%", handler: { [weak self] _ in
            self?.primeExchangeRate = 0.2
            self?.mainView.primeExchangeRateMenu.setTitle("20%", for: .normal)
            self?.calulateWonDollarValue()
        })
        let rate10 = UIAction(title: "10%", handler: { [weak self] _ in
            self?.primeExchangeRate = 0.1
            self?.mainView.primeExchangeRateMenu.setTitle("10%", for: .normal)
            self?.calulateWonDollarValue()
        })
        
        mainView.primeExchangeRateMenu.menu = UIMenu(
            title: "환전 우대율",
            children: [
                rate100, rate90, rate80, rate70, rate60, rate50, rate40, rate30, rate20, rate10
            ]
        )
        
        let appearence = UINavigationBarAppearance()
        appearence.configureWithOpaqueBackground()
        
        navigationController?.navigationBar.standardAppearance = appearence
        navigationController?.navigationBar.scrollEdgeAppearance = appearence
        navigationController?.navigationBar.compactAppearance = appearence
        
        title = "원-달러 환율 계산기"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setTarget() {
        mainView.resetExchangeRateButton.addTarget(self, action: #selector(resetExchangeRateButtonPressed), for: .touchUpInside)
        mainView.krwTextField.addTarget(self, action: #selector(krwTextFieldValueChanged), for: .editingChanged)
    }
    
    @objc func krwTextFieldValueChanged() {
        calulateWonDollarValue()
    }
    
    @objc func resetExchangeRateButtonPressed() {
        resetExchangeRate()
        calulateWonDollarValue()
    }
    
    func calulateWonDollarValue() {
        guard let krwText = mainView.krwTextField.text, !krwText.isEmpty,
              let inputWonValue = Double(krwText)
        else {
            mainView.usdTextField.text = ""
            return
        }
        if let result = dunamuManager.calculateWonDollarExchange(inputWon: inputWonValue, primeExchangeRate: primeExchangeRate) {
            mainView.usdTextField.text = String(format: "%.2f",  result)
            
        }
    }
    
    func resetExchangeRate() {
        dunamuManager.fetchWonDollarBasePrice { [weak self] basePrice in
            DispatchQueue.main.async {
                if let price = basePrice {
                    print("원/달러 환율 정보 가져오기 성공: \(price)")
                    self?.mainView.wonDollarExchangeRateLabel.text = String(price)
                } else {
                    print("원/달러 환율 정보 가져오기 실패")
                    self?.mainView.wonDollarExchangeRateLabel.text = "-"
                }
            }
        }
    }
}
