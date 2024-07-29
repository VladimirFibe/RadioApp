//
//  CustomViewController.swift
//  RadioApp
//
//  Created by Sergey Zakurakin on 29/07/2024.
//

import UIKit
import SnapKit

final class CustomTabBarItemView: UIView {
    
    // MARK: - Properties
    let imageView = UIImageView()
    let titleLabel = UILabel()
    
    
    //MARK: - initilizer
    init(title: String, image: UIImage?) {
        super.init(frame: .zero)
        
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        
        titleLabel.text = title
        titleLabel.font = UIFont(name: "SFProDisplayBlack.otf", size: 20)
        titleLabel.textAlignment = .center
        
        addSubview(imageView)
        addSubview(titleLabel)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    func setActive(_ active: Bool) {
        imageView.isHidden = !active
    }
}

// MARK: - Constraints Setup
extension CustomTabBarItemView {
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(5)
        }
        
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.width.height.equalTo(15)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
    
}

///
