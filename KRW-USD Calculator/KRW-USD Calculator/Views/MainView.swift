//
//  MainView.swift
//  KRW-USD Calculator
//
//  Created by 김건우 on 7/28/23.
//

import UIKit

class MainView: UIView {
    
    private var currentExchangeRateLabel: UILabel = {
        let label = UILabel()
        label.text = "현재 환율"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var wonDollarExchangeRateLabel: UILabel = {
        let label = UILabel()
        label.text = "-"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var resetExchangeRateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrow.counterclockwise"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var wonDollarStackView: UIStackView = {
        let st = UIStackView(
            arrangedSubviews: [wonDollarExchangeRateLabel, resetExchangeRateButton]
        )
        st.axis = .horizontal
        st.spacing = 5
        st.distribution = .equalSpacing
        st.translatesAutoresizingMaskIntoConstraints = false
        return st
    }()
    
    private lazy var exchangeRateStackView: UIStackView = {
        let st = UIStackView(
            arrangedSubviews: [currentExchangeRateLabel, wonDollarStackView]
        )
        st.axis = .horizontal
        st.spacing = 5
        st.distribution = .equalSpacing
        st.translatesAutoresizingMaskIntoConstraints = false
        return st
    }()
    
    private var krwGroupView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.secondarySystemBackground
        view.clipsToBounds = true
        view.layer.cornerRadius = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var krwLabel: UILabel = {
        let label = UILabel()
        label.text = "🇰🇷원(KRW)"
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var krwTextField: UITextField = {
        let tf = UITextField()
        tf.font = UIFont.boldSystemFont(ofSize: 80)
        tf.borderStyle = .none
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        tf.autocapitalizationType = .none
        tf.keyboardType = .numberPad
        tf.adjustsFontSizeToFitWidth = true
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private var usdGroupView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.secondarySystemBackground
        view.clipsToBounds = true
        view.layer.cornerRadius = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var usdLabel: UILabel = {
        let label = UILabel()
        label.text = "🇺🇸달러(USD)"
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var usdTextField: UITextField = {
        let tf = UITextField()
        tf.isEnabled = false
        tf.font = UIFont.boldSystemFont(ofSize: 80)
        tf.borderStyle = .none
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        tf.autocapitalizationType = .none
        tf.keyboardType = .numberPad
        tf.adjustsFontSizeToFitWidth = true
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private var primeExchangeRateLabel: UILabel = {
        let label = UILabel()
        label.text = "환전 우대"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var primeExchangeRateMenu: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("90%", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var primeExchangeStackView: UIStackView = {
        let st = UIStackView(
            arrangedSubviews: [primeExchangeRateLabel, primeExchangeRateMenu]
        )
        st.axis = .horizontal
        st.alignment = .leading
        st.spacing = 5
        st.translatesAutoresizingMaskIntoConstraints = false
        return st
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeUI() {
        backgroundColor = UIColor.white
    }
    
    func setConstraints() {
        setWonDollarExchangeRateConstraint()
        setKrwGroupConstraints()
        setUsdGroupConstraints()
        setPrimeExchangeRateConstraints()
    }
    
    func setWonDollarExchangeRateConstraint() {
        addSubview(exchangeRateStackView)
        
        NSLayoutConstraint.activate([
            exchangeRateStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            exchangeRateStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            exchangeRateStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            exchangeRateStackView.heightAnchor.constraint(equalToConstant: 30),
            
            currentExchangeRateLabel.centerYAnchor.constraint(equalTo: exchangeRateStackView.centerYAnchor),
            
            wonDollarStackView.centerYAnchor.constraint(equalTo: exchangeRateStackView.centerYAnchor),
            wonDollarStackView.widthAnchor.constraint(equalToConstant: 120),
            
            wonDollarExchangeRateLabel.centerYAnchor.constraint(equalTo: wonDollarStackView.centerYAnchor),
            wonDollarExchangeRateLabel.widthAnchor.constraint(equalToConstant: 80),
            
            resetExchangeRateButton.centerYAnchor.constraint(equalTo: wonDollarStackView.centerYAnchor),
            resetExchangeRateButton.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func setKrwGroupConstraints() {
        addSubview(krwGroupView)
        addSubview(krwLabel)
        addSubview(krwTextField)
        
        NSLayoutConstraint.activate([
            krwGroupView.topAnchor.constraint(equalTo: exchangeRateStackView.bottomAnchor, constant: 10),
            krwGroupView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            krwGroupView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            krwGroupView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            krwGroupView.heightAnchor.constraint(equalToConstant: 150),
            
            krwLabel.topAnchor.constraint(equalTo: krwGroupView.topAnchor, constant: 10),
            krwLabel.leadingAnchor.constraint(equalTo: krwGroupView.leadingAnchor, constant: 10),
            krwLabel.trailingAnchor.constraint(equalTo: krwGroupView.trailingAnchor, constant: -10),
            krwLabel.heightAnchor.constraint(equalToConstant: 30),
            
            krwTextField.topAnchor.constraint(equalTo: krwLabel.bottomAnchor, constant: 5),
            krwTextField.leadingAnchor.constraint(equalTo: krwLabel.leadingAnchor),
            krwTextField.trailingAnchor.constraint(equalTo: krwLabel.trailingAnchor)
        ])
    }
    
    func setUsdGroupConstraints() {
        addSubview(usdGroupView)
        addSubview(usdLabel)
        addSubview(usdTextField)
        
        NSLayoutConstraint.activate([
            usdGroupView.topAnchor.constraint(equalTo: krwGroupView.bottomAnchor, constant: 10),
            usdGroupView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            usdGroupView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            usdGroupView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            usdGroupView.heightAnchor.constraint(equalToConstant: 150),
            
            usdLabel.topAnchor.constraint(equalTo: usdGroupView.topAnchor, constant: 10),
            usdLabel.leadingAnchor.constraint(equalTo: usdGroupView.leadingAnchor, constant: 10),
            usdLabel.trailingAnchor.constraint(equalTo: usdGroupView.trailingAnchor, constant: -10),
            usdLabel.heightAnchor.constraint(equalToConstant: 30),
            
            usdTextField.topAnchor.constraint(equalTo: usdLabel.bottomAnchor, constant: 5),
            usdTextField.leadingAnchor.constraint(equalTo: usdLabel.leadingAnchor),
            usdTextField.trailingAnchor.constraint(equalTo: usdLabel.trailingAnchor)
        ])
    }
    
    func setPrimeExchangeRateConstraints() {
        addSubview(primeExchangeStackView)
        
        NSLayoutConstraint.activate([
            primeExchangeStackView.topAnchor.constraint(equalTo: usdGroupView.bottomAnchor, constant: 10),
            primeExchangeStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            primeExchangeStackView.heightAnchor.constraint(equalToConstant: 30),
            primeExchangeStackView.widthAnchor.constraint(equalToConstant: 150),
            
            primeExchangeRateLabel.centerYAnchor.constraint(equalTo: primeExchangeStackView.centerYAnchor),
            primeExchangeRateLabel.widthAnchor.constraint(equalToConstant: 100),
            
            primeExchangeRateMenu.centerYAnchor.constraint(equalTo: primeExchangeStackView.centerYAnchor),
            primeExchangeRateMenu.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
}
