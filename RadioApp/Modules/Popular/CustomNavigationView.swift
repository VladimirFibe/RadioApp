//
//  CustomNavigationView.swift
//  RadioApp
//
//  Created by Елена Логинова on 05.08.2024.
//

import UIKit

final class CustomNavigationView: UIView {
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "iconNavBar")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var helloLabel: UILabel = {
        let label = UILabel()
        let helloString = "Hello"
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 30, weight: .medium)
        //label.font = .custom(font: .medium, size: 30)
        label.text = "Hello Mark"
        label.textColor = #colorLiteral(red: 1, green: 0.1607843137, blue: 0.4274509804, alpha: 1)
        label.textColorChange(fullText: label.text ?? "", changeText: "Hello")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var userButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .cyan
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 25
        button.setBackgroundImage(UIImage(systemName: "person.circle"), for: .normal)
        button.addTarget(self, action: #selector(goToUserProfile), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    private func setupView() {
        addSubview(iconImageView)
        addSubview(helloLabel)
        addSubview(userButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func goToUserProfile(_ sender: UIButton) {
        print("goToUserProfile")
    }
    
//    func updateUser(with model: Model) {
//        helloLabel = "Hello \(model.name)"
//        userButton.setBackgroundImage(UIImage(named: model.photo), for: .normal)
//    }
}

extension CustomNavigationView {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: topAnchor),
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            iconImageView.heightAnchor.constraint(equalToConstant: 33),
            iconImageView.widthAnchor.constraint(equalToConstant: 33),
            
            helloLabel.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor),
            helloLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 6),
            helloLabel.widthAnchor.constraint(equalToConstant: 126),
            helloLabel.trailingAnchor.constraint(equalTo: userButton.leadingAnchor, constant: 10),
            
            userButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            userButton.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor),
            userButton.heightAnchor.constraint(equalToConstant: 50),
            userButton.widthAnchor.constraint(equalToConstant: 50),
        ])
    }
}

