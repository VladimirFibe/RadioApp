//
//  ForgotPasswordView.swift
//  RadioApp
//
//  Created by Vadim Zhelnov on 30.07.24.
//

import UIKit

protocol ForgotPasswordViewDelegate: AnyObject {
    func sentButtonPressed()
    func forgotPasswordleftArrowButtonPressed()
}

final class ForgotPasswordView: UIView {
    
    weak var delegate: ForgotPasswordViewDelegate?
    
    // MARK: - UI Components
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: .backgroundAppPart1)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private lazy var triangleImageView: UIImageView = {
        let imageView = UIImageView(image: .backgroundAppPart3)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var leftArrowButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.left", withConfiguration:UIImage.SymbolConfiguration(pointSize: 24, weight: .light,scale: .large)), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(forgotPasswordleftArrowButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()
    
    private lazy var forgotPasswordLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 50)
        label.numberOfLines = 2
        label.textColor = .white
        label.textAlignment = .left
        label.text = "Forgot password"
        label.translatesAutoresizingMaskIntoConstraints = false
       return label
    }()
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Medium", size: 16)
        label.textColor = .white
        label.textAlignment = .left
        label.text = "Email"
        label.translatesAutoresizingMaskIntoConstraints = false
       return label
    }()
    
    let emailTextFild: UITextField = {
       let textfield = UITextField()
        textfield.borderStyle = .none
        textfield.backgroundColor = .clear
        textfield.layer.borderWidth = 2
        textfield.layer.borderColor = #colorLiteral(red: 1, green: 0.2757065594, blue: 0.5015140772, alpha: 1)
        textfield.layer.cornerRadius = 5
        textfield.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textfield.frame.height))
        textfield.leftViewMode = .always
        textfield.font = UIFont(name: "SFProDisplay-Light", size: 16)
        textfield.textColor = .white
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.gray]
        textfield.attributedPlaceholder = NSAttributedString(string: "Your email", attributes: attributes)
        textfield.layer.shadowColor = UIColor.red.cgColor
        textfield.layer.shadowOpacity = 1
        textfield.layer.shadowOffset = CGSize(width: 4, height: 4)
        textfield.layer.shadowRadius = 4
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    private lazy var sentButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sent", for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Light", size: 30)
        button.tintColor = .white
        button.backgroundColor = .cyan
        button.addTarget(self, action: #selector(sentPassword), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Actions
    
    @objc private func sentPassword() {
            print("sentButtonPressed")
            delegate?.sentButtonPressed()
        }
    
    @objc private func forgotPasswordleftArrowButtonPressed() {
            print("leftButtonPressed")
        delegate?.forgotPasswordleftArrowButtonPressed()
    }
    
    //MARK: - UI Setup
    private func addSubviews() {
        addSubview(backgroundImageView)
        addSubview(triangleImageView)
        addSubview(leftArrowButton)
        addSubview(forgotPasswordLabel)
        addSubview(emailLabel)
        addSubview(emailTextFild)
        addSubview(sentButton)

    }
    // MARK: - Setup Constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            triangleImageView.topAnchor.constraint(equalTo: topAnchor,constant: 80),
            triangleImageView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 265),
            
            leftArrowButton.topAnchor.constraint(equalTo: topAnchor,constant: 130),
            leftArrowButton.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 42),
            leftArrowButton.widthAnchor.constraint(equalToConstant: 36),
            
            forgotPasswordLabel.topAnchor.constraint(equalTo: topAnchor, constant: 190),
            forgotPasswordLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 42),
            forgotPasswordLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -42),
            forgotPasswordLabel.heightAnchor.constraint(equalToConstant: 120),
            
            emailLabel.topAnchor.constraint(equalTo: forgotPasswordLabel.bottomAnchor, constant: 20),
            emailLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 42),
            emailLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -42),

            emailTextFild.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 15),
            emailTextFild.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 42),
            emailTextFild.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -42),
            emailTextFild.heightAnchor.constraint(equalToConstant: 53),
            
            sentButton.topAnchor.constraint(equalTo: emailTextFild.bottomAnchor, constant: 70),
            sentButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 42),
            sentButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -42),
            sentButton.heightAnchor.constraint(equalToConstant: 73),
        ])
    }
}
