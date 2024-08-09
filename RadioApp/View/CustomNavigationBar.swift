//
//  CustomNavigationBar.swift
//  RadioApp
//
//  Created by Елена Логинова on 07.08.2024.
//

import UIKit

final class CustomNavigationBar: UIView {
    
    var profileButtonPressed:(() -> Void)?
    
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
        label.font = .custom(font: .medium, size: 30)
        label.text = "Hello Mark"
        label.textColor = #colorLiteral(red: 1, green: 0.1607843137, blue: 0.4274509804, alpha: 1)
        label.textColorChange(fullText: label.text ?? "", changeText: "Hello")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var userProfileImageView: UIImageView = {
        let imageView = UIImageView()
        let shapeLayer = CAShapeLayer(layer: imageView.layer)
        imageView.isUserInteractionEnabled = true
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 14))
        path.addLine(to: CGPoint(x: 0, y: 31))
        path.addCurve(to: CGPoint(x: 19, y: 41), controlPoint1: CGPoint(x: 0, y: 37), controlPoint2: CGPoint(x: 11, y: 46))
        path.addLine(to: CGPoint(x: 29, y: 35))
        path.addCurve(to: CGPoint(x: 30, y: 11), controlPoint1: CGPoint(x: 37, y: 29), controlPoint2: CGPoint(x: 37, y: 16))
        path.addLine(to: CGPoint(x: 19, y: 4))
        path.addCurve(to: CGPoint(x: 0, y: 16), controlPoint1: CGPoint(x: 12, y: 0), controlPoint2: CGPoint(x: 0, y: 8))
        path.close()
        shapeLayer.path = path.cgPath
        shapeLayer.frame = imageView.frame
        imageView.layer.mask = shapeLayer
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        let tapImageProfile = UITapGestureRecognizer(target: self, action: #selector(goToUserProfile))
        imageView.addGestureRecognizer(tapImageProfile)
        imageView.image = UIImage(named: "womanImageView")
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    private func setupView() {
        addSubview(iconImageView)
        addSubview(helloLabel)
        addSubview(userProfileImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func goToUserProfile(_ sender: UIButton) {
        profileButtonPressed?()
    }
    
//    func updateUser(with model: Model) {
//        helloLabel = "Hello \(model.name)"
//        userProfile.image = UIImage(named: "")
//    }
}

extension CustomNavigationBar {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: topAnchor),
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            iconImageView.heightAnchor.constraint(equalToConstant: 33),
            iconImageView.widthAnchor.constraint(equalToConstant: 33),
            
            helloLabel.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor),
            helloLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 6),
            helloLabel.trailingAnchor.constraint(equalTo: userProfileImageView.leadingAnchor, constant: 10),
            
            userProfileImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -19),
            userProfileImageView.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor),
            userProfileImageView.widthAnchor.constraint(equalToConstant: 37),
            userProfileImageView.heightAnchor.constraint(equalToConstant: 46),
        ])
    }
}

