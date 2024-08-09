//
//  ChangePasswordView.swift
//  RadioApp
//
//  Created by Vadim Zhelnov on 2.08.24.
//

import UIKit

protocol ChangePasswordViewDelegate: AnyObject {
    func changePasswordButtonPressed()
    func changePasswordLeftArrowButtonPressed()
}

final class ChangePasswordView: UIView {
    
    weak var delegate: ChangePasswordViewDelegate?
    
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
        button.addTarget(self, action: #selector(changePasswordleftArrowButtonPressed), for: .touchUpInside)
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
    
    private lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Medium", size: 16)
        label.textColor = .white
        label.textAlignment = .left
        label.text = "Password"
        label.translatesAutoresizingMaskIntoConstraints = false
       return label
    }()

    private lazy var confirmPasswordLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Medium", size: 16)
        label.textColor = .white
        label.textAlignment = .left
        label.text = "Confirm password"
        label.translatesAutoresizingMaskIntoConstraints = false
       return label
    }()
    
    let passwordTextFild: UITextField = {
       let textfield = UITextField()
        textfield.borderStyle = .none
        textfield.backgroundColor = .clear
        textfield.layer.borderWidth = 2
        textfield.layer.borderColor = #colorLiteral(red: 1, green: 0.2757065594, blue: 0.5015140772, alpha: 1)
        textfield.layer.cornerRadius = 5
        textfield.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textfield.frame.height))
        textfield.leftViewMode = .always
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.gray]
        textfield.attributedPlaceholder = NSAttributedString(string: "Your password", attributes: attributes)
        textfield.font = UIFont(name: "SFProDisplay-Light", size: 16)
        textfield.textColor = .white
        textfield.layer.shadowColor = #colorLiteral(red: 1, green: 0.2757065594, blue: 0.5015140772, alpha: 1)
        textfield.layer.shadowOpacity = 1
        textfield.layer.shadowOffset = CGSize(width: 4, height: 4)
        textfield.layer.shadowRadius = 4
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    let confirmPasswordTextFild: UITextField = {
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
        textfield.attributedPlaceholder = NSAttributedString(string: "Your password", attributes: attributes)
        textfield.layer.shadowColor = #colorLiteral(red: 1, green: 0.2757065594, blue: 0.5015140772, alpha: 1)
        textfield.layer.shadowOpacity = 1
        textfield.layer.shadowOffset = CGSize(width: 4, height: 4)
        textfield.layer.shadowRadius = 4
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    private lazy var secureButtonPassword: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        button.setImage(UIImage(systemName: "eye"), for: .selected)
        button.tintColor = .gray
        button.addTarget(self, action: #selector(passwordVisibility), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()
    
    private lazy var secureButtonConfirmPassword: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        button.setImage(UIImage(systemName: "eye"), for: .selected)
        button.tintColor = .gray
        button.addTarget(self, action: #selector(confirmPasswordVisibility), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()
    
    private lazy var changePasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Change password", for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Light", size: 30)
        button.tintColor = .white
        button.backgroundColor = .cyan
        button.addTarget(self, action: #selector(changePassword), for: .touchUpInside)
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
    
    @objc private func changePassword() {
        delegate?.changePasswordButtonPressed()
        }
    
    @objc private func changePasswordleftArrowButtonPressed() {
            //print("leftButtonPressed")
        delegate?.changePasswordLeftArrowButtonPressed()
    }
    
    @objc func passwordVisibility() {
        passwordTextFild.isSecureTextEntry.toggle()
        secureButtonPassword.isSelected.toggle()
    }
    @objc func confirmPasswordVisibility() {
        confirmPasswordTextFild.isSecureTextEntry.toggle()
        secureButtonConfirmPassword.isSelected.toggle()
    }

    //MARK: - UI Setup
    private func addSubviews() {
        addSubview(backgroundImageView)
        addSubview(triangleImageView)
        addSubview(leftArrowButton)
        addSubview(forgotPasswordLabel)
        addSubview(passwordLabel)
        addSubview(passwordTextFild)
        addSubview(secureButtonPassword)
        addSubview(confirmPasswordLabel)
        addSubview(confirmPasswordTextFild)
        addSubview(secureButtonConfirmPassword)
        addSubview(changePasswordButton)

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
            
            passwordLabel.topAnchor.constraint(equalTo: forgotPasswordLabel.bottomAnchor, constant: 20),
            passwordLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 42),
            passwordLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -42),
            
            passwordTextFild.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 15),
            passwordTextFild.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 42),
            passwordTextFild.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -42),
            passwordTextFild.heightAnchor.constraint(equalToConstant: 53),
            
            secureButtonPassword.centerYAnchor.constraint(equalTo:passwordTextFild.centerYAnchor),
            secureButtonPassword.trailingAnchor.constraint(equalTo: passwordTextFild.trailingAnchor,constant: -16),
            secureButtonPassword.widthAnchor.constraint(equalToConstant: 24),
            secureButtonPassword.heightAnchor.constraint(equalToConstant: 24),
            
            confirmPasswordLabel.topAnchor.constraint(equalTo: passwordTextFild.bottomAnchor, constant: 30),
            confirmPasswordLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 42),
            confirmPasswordLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -42),
            
            confirmPasswordTextFild.topAnchor.constraint(equalTo: confirmPasswordLabel.bottomAnchor, constant: 15),
            confirmPasswordTextFild.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 42),
            confirmPasswordTextFild.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -42),
            confirmPasswordTextFild.heightAnchor.constraint(equalToConstant: 53),
            
            secureButtonConfirmPassword.centerYAnchor.constraint(equalTo:confirmPasswordTextFild.centerYAnchor),
            secureButtonConfirmPassword.trailingAnchor.constraint(equalTo: confirmPasswordTextFild.trailingAnchor,constant: -16),
            secureButtonConfirmPassword.widthAnchor.constraint(equalToConstant: 24),
            secureButtonConfirmPassword.heightAnchor.constraint(equalToConstant: 24),
            
            changePasswordButton.topAnchor.constraint(equalTo: confirmPasswordTextFild.bottomAnchor, constant: 45),
            changePasswordButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 42),
            changePasswordButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -42),
            changePasswordButton.heightAnchor.constraint(equalToConstant: 73),
        ])
    }
}



