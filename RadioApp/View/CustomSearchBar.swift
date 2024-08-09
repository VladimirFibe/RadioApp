//
//  CustomSearchBar.swift
//  RadioApp
//
//  Created by Елена Логинова on 09.08.2024.
//

import UIKit

class CustomSearchBar: UIView {

    let textField = UITextField()
    private let searchButton = UIButton()
    private let magnifyingglassImageView = UIImageView()
    
    var delegate: AllStationsViewControllerDelegate?
    
    
    init() {
        super.init(frame: .null)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) {
        searchButton.addTarget(target, action: action, for: controlEvents)
    }
    
    
    func changeButton() {
        searchButton.setImage(UIImage(named: "clearButton"), for: .normal)
    }
    
    override func resignFirstResponder() -> Bool {
        textField.resignFirstResponder()
    }
    
    private func setupUI() {
        self.backgroundColor = #colorLiteral(red: 0.3956975937, green: 0.4000861645, blue: 0.5145202279, alpha: 1)
        self.layer.cornerRadius = 15
        self.clipsToBounds = true
        
        searchButton.setImage(UIImage(named: "searchButton"), for: .normal)
        searchButton.tintColor = .gray
        
        let placeholder = NSAttributedString(string: "Search radio station", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.45), NSAttributedString.Key.font: UIFont.custom(font: .regular, size: 15)])
        textField.attributedPlaceholder = placeholder
        textField.returnKeyType = .search
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.font = UIFont.custom(font: .regular, size: 15)
        textField.textColor = .white
        textField.rightView = searchButton
        textField.rightViewMode = .always
        textField.leftViewMode = .always
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        magnifyingglassImageView.image = UIImage(named: "magnifyingglass")
        magnifyingglassImageView.contentMode = .scaleAspectFit
        magnifyingglassImageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraints() {
        self.addSubview(textField)
        self.addSubview(magnifyingglassImageView)
        NSLayoutConstraint.activate([
            magnifyingglassImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            magnifyingglassImageView.widthAnchor.constraint(equalToConstant: 17),
            magnifyingglassImageView.heightAnchor.constraint(equalToConstant: 17),
            magnifyingglassImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            textField.leftAnchor.constraint(equalTo: magnifyingglassImageView.rightAnchor, constant: 25),
            textField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            textField.topAnchor.constraint(equalTo: self.topAnchor),
            textField.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}


extension CustomSearchBar: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        delegate?.startSearch()
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        searchButton.sendActions(for: .touchUpInside)
        return true
    }
}
