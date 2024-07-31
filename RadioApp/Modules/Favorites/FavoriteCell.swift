//
//  FavoriteCell.swift
//  RadioApp
//
//  Created by Елена Логинова on 31.07.2024.
//

import UIKit

class FavoriteCell: UICollectionViewCell {
    
    static let identifier = "FavoriteCell"
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 1
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var genreLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "POP"
        label.font = .custom(font: .bold, size: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var radioNameLabel: UILabel = {
        let label = UILabel()
        label.font = .custom(font: .regular, size: 15)
        label.textColor = .white
        label.textAlignment = .left
        label.text = "Radio Record"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var curvedLineImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "сurvedLineImageView")
        imageView.contentMode = .left
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .cyan
        button.backgroundColor = .clear
        button.setBackgroundImage(UIImage(named: "heartButton"), for: .normal)
        button.addTarget(self, action: #selector(likeButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func likeButtonPressed(sender: UIButton) {
        sender.alpha = 0.45
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            sender.alpha = 1
        }
        print("likeButtonPressed")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        genreLabel.text = nil
        radioNameLabel.text = nil
    }
    
    public func configureCell(with radio: RadioStation) {
        if radio.tags == "" {
            genreLabel.text = "Online"
        } else {
            genreLabel.text = radio.tags
        }
        radioNameLabel.text = radio.name
    }
    
    private func setupViews() {
        layer.cornerRadius = 15
        layer.borderWidth = 2
        layer.borderColor = #colorLiteral(red: 0.2560741901, green: 0.2609855533, blue: 0.3792468607, alpha: 1).cgColor
        backgroundColor = .clear
        addSubview(stackView)
        stackView.addArrangedSubview(genreLabel)
        stackView.addArrangedSubview(radioNameLabel)
        stackView.addArrangedSubview(curvedLineImageView)
        addSubview(likeButton)
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                layer.borderColor = #colorLiteral(red: 1, green: 0.2757065594, blue: 0.5015140772, alpha: 1).cgColor
            } else {
                layer.borderColor = #colorLiteral(red: 0.2560741901, green: 0.2609855533, blue: 0.3792468607, alpha: 1).cgColor
            }
        }
    }
}

extension FavoriteCell {
    func setConstraint() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: likeButton.leadingAnchor, constant: 0),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),

            likeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            likeButton.centerYAnchor.constraint(equalTo:  centerYAnchor),
            likeButton.heightAnchor.constraint(equalToConstant: 53.98),
            likeButton.widthAnchor.constraint(equalToConstant: 61.84),
        ])
    }
}

