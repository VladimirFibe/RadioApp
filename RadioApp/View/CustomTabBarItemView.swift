//
//  CustomTabBarItemView.swift
//  RadioApp
//
//  Created by Sergey Zakurakin on 29/07/2024.
//

import UIKit

final class CustomTabBarItemView: UIView {
    
    //MARK: - properties
    let imageView = UIImageView()
    let titleLabel = UILabel()
    
    
    // MARK: - Initializer
    init(title: String, image: UIImage) {
        super.init(frame: .zero)
        
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.textAlignment = .center
        
        addSubview(titleLabel)
        addSubview(imageView)
        
        setupConstraint()
    }
    
    //MARK: - public method
    func setActive(_ active: Bool) {
        imageView.isHidden = !active
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK: - Setup Constraints
extension CustomTabBarItemView {
    private func setupConstraint() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            imageView.widthAnchor.constraint(equalToConstant: 15),
            imageView.heightAnchor.constraint(equalToConstant: 15),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20)
        ])
    }
}
