//
//  BackgroundView.swift
//  RadioApp
//
//  Created by Иван Семикин on 31/07/2024.
//

import UIKit
import SnapKit

final class BackgroundView: UIView {
    
    private let backgroundPart1ImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "backgroundAppPart1")
        return imageView
    }()
    
    private let backgroundPart2ImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "backgroundAppPart2")
        return imageView
    }()
    
    private let backgroundPart3ImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "backgroundAppPart3")
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private Methods
private extension BackgroundView {
    func setupUI() {
        backgroundColor = .black
        addSubviews()
        setConstraints()
    }
    
    func addSubviews() {
        addSubview(backgroundPart1ImageView)
        addSubview(backgroundPart2ImageView)
        addSubview(backgroundPart3ImageView)
    }
    
    func setConstraints() {
        backgroundPart1ImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        backgroundPart2ImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(43)
            make.top.equalToSuperview().inset(112)
        }
        
        backgroundPart3ImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview().multipliedBy(1.8)
            make.top.equalToSuperview().inset(80)
        }
    }
}
