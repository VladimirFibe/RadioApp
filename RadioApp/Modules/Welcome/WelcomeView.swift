//
//  WelcomeView.swift
//  RadioApp
//
//  Created by Елена Логинова on 29.07.2024.
//

import UIKit

protocol WelcomeViewDelegate: AnyObject {
    func startButtonPressed()
}

final class WelcomeView: UIView {
    
    weak var delegate: WelcomeViewDelegate?
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "womanImageView")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var blurImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "blurImageView")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Let's Get Started"
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont.custom(font: .bold, size: 60)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .white
        label.font = .custom(font: .regular, size: 16)
        label.text = "Enjoy the best radio stations from your home, don't miss out on anything"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Get Started", for: .normal)
        button.titleLabel?.font = .custom(font: .medium, size: 20)
        button.tintColor = .white
        button.backgroundColor = .systemPink
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(getStartedButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func getStartedButtonPressed() {
        print("startButtonPressed")
        delegate?.startButtonPressed()
    }
    
    private func setupViews() {
        addSubview(backgroundImageView)
        addSubview(blurImageView)
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        addSubview(startButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            blurImageView.topAnchor.constraint(equalTo: topAnchor),
            blurImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            blurImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            blurImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 146),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 52),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -52),

            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 31),
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -158),

            startButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -62),
            startButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 52),
            startButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -52),
            startButton.heightAnchor.constraint(equalToConstant: 58),
        ])
    }
}

