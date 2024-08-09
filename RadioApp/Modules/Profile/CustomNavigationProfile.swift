//
//  BezierCurves.swift
//  RadioApp
//
//  Created by Сергей Сухарев on 06.08.2024.
//


import UIKit
class CustomNavigationProfile: UIView{
    var onTapBack:(() -> Void)?
    var onTapProf:(() -> Void)?
    private lazy var arrowBackButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "Vector"), for: .normal)
        button.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc private func backButtonAction(_ sender: UIButton) {
        //self.navigationController?.popViewController(animated: true)
        onTapBack?()
        print("backButtonAction")
    }
    
    @objc private func upProfile(_ sender: UIButton) {
        onTapProf?()
        print("upProfile")
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.text = "Setting"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(nameTitle: String, imageProfile: String) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.text = nameTitle
        let imageViewProfile = UIImageView(image: UIImage(named: imageProfile))
        
        let shapeLayer = CAShapeLayer(layer: imageViewProfile.layer)
        imageViewProfile.isUserInteractionEnabled = true
        let tapImageProfile = UITapGestureRecognizer(target: self, action: #selector(upProfile))
        imageViewProfile.addGestureRecognizer(tapImageProfile)
        
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
        shapeLayer.frame = imageViewProfile.frame
        imageViewProfile.layer.mask = shapeLayer
        imageViewProfile.translatesAutoresizingMaskIntoConstraints = false
        imageViewProfile.contentMode = .scaleAspectFill
        
        addSubview(arrowBackButton)
        addSubview(titleLabel)
        addSubview(imageViewProfile)
        
        NSLayoutConstraint.activate([
            arrowBackButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 45),
            arrowBackButton.topAnchor.constraint(equalTo: topAnchor, constant: 1),
            arrowBackButton.widthAnchor.constraint(equalToConstant: 36),
            arrowBackButton.heightAnchor.constraint(equalToConstant: 27),
            
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            
            imageViewProfile.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -19),
            imageViewProfile.topAnchor.constraint(equalTo: topAnchor),
            imageViewProfile.widthAnchor.constraint(equalToConstant: 37),
            imageViewProfile.heightAnchor.constraint(equalToConstant: 46),
            
            imageViewProfile.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

@available(iOS 17.0, *)
#Preview {
    CustomNavigationProfile(nameTitle: "Setting", imageProfile: "AppIcon")
}
