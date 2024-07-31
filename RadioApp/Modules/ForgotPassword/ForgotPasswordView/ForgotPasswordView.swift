//
//  ForgotPasswordView.swift
//  RadioApp
//
//  Created by Vadim Zhelnov on 30.07.24.
//

import UIKit

protocol ForgotPasswordViewDelegate: AnyObject {
    func sentButtonPressed()
}

final class ForgotPasswordView: UIView {
    
    weak var delegate: ForgotPasswordViewDelegate?
    
    // MARK: - UI Components
    
    private lazy var forgotPasswordLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 100)
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
    
    let emailTextFild: UITextField = {
       let textfield = UITextField()
        textfield.borderStyle = .none
        textfield.backgroundColor = .green
        textfield.layer.borderWidth = 2
        textfield.layer.borderColor = #colorLiteral(red: 1, green: 0.2757065594, blue: 0.5015140772, alpha: 1)
        textfield.layer.cornerRadius = 10
        textfield.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textfield.frame.height))
        textfield.leftViewMode = .always
        textfield.clearButtonMode = .always
        textfield.placeholder = "Your email"
        textfield.font = UIFont(name: "SFProDisplay-Light", size: 16)
        textfield.tintColor = .white
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    let passwordTextFild: UITextField = {
       let textfield = UITextField()
        textfield.borderStyle = .none
        textfield.backgroundColor = .green
        textfield.layer.borderWidth = 2
        textfield.layer.borderColor = #colorLiteral(red: 1, green: 0.2757065594, blue: 0.5015140772, alpha: 1)
        textfield.layer.cornerRadius = 10
        textfield.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textfield.frame.height))
        textfield.leftViewMode = .always
        textfield.clearButtonMode = .always
        textfield.placeholder = "Your password"
        textfield.font = UIFont(name: "SFProDisplay-Light", size: 16)
        textfield.tintColor = .white
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    let confirmPasswordTextFild: UITextField = {
       let textfield = UITextField()
        textfield.borderStyle = .none
        textfield.backgroundColor = .green
        textfield.layer.borderWidth = 2
        textfield.layer.borderColor = #colorLiteral(red: 1, green: 0.2757065594, blue: 0.5015140772, alpha: 1)
        textfield.layer.cornerRadius = 10
        textfield.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textfield.frame.height))
        textfield.leftViewMode = .always
        textfield.clearButtonMode = .always
        textfield.placeholder = "Your password"
        textfield.font = UIFont(name: "SFProDisplay-Light", size: 16)
        textfield.tintColor = .white
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
    
    @objc private func sentPassword() {
            print("sentButtonPressed")
            delegate?.sentButtonPressed()
        }
    
    @objc private func changePassword() {
            print("changePasswordButtonPressed")
        }
    
    func showChangePasswordView() {
        passwordLabel.alpha = 1
        passwordTextFild.alpha = 1
        confirmPasswordLabel.alpha = 1
        confirmPasswordTextFild.alpha = 1
        changePasswordButton.alpha = 1
        emailLabel.alpha = 0
        emailTextFild.alpha = 0
        sentButton.alpha = 0
    }
    
    func hideChangePasswordView() {
        passwordLabel.alpha = 0
        passwordTextFild.alpha = 0
        confirmPasswordLabel.alpha = 0
        confirmPasswordTextFild.alpha = 0
        changePasswordButton.alpha = 0
        
    }
    
    //MARK: - Set Delegates
    

    
    
    //MARK: - UI Setup
    private func addSubviews() {
        addSubview(forgotPasswordLabel)
        addSubview(emailLabel)
        addSubview(passwordLabel)
        addSubview(emailTextFild)
        addSubview(passwordTextFild)
        addSubview(confirmPasswordLabel)
        addSubview(confirmPasswordTextFild)
        addSubview(sentButton)
        addSubview(changePasswordButton)

    }
    // MARK: - Setup Constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            forgotPasswordLabel.topAnchor.constraint(equalTo: topAnchor, constant: 190),
            forgotPasswordLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 42),
            forgotPasswordLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -42),
            forgotPasswordLabel.heightAnchor.constraint(equalToConstant: 120),
            
            emailLabel.topAnchor.constraint(equalTo: forgotPasswordLabel.bottomAnchor, constant: 20),
            emailLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 42),
            emailLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -42),
            
            passwordLabel.topAnchor.constraint(equalTo: forgotPasswordLabel.bottomAnchor, constant: 20),
            passwordLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 42),
            passwordLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -42),
            
            emailTextFild.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 15),
            emailTextFild.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 42),
            emailTextFild.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -42),
            emailTextFild.heightAnchor.constraint(equalToConstant: 53),
            
            passwordTextFild.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 15),
            passwordTextFild.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 42),
            passwordTextFild.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -42),
            passwordTextFild.heightAnchor.constraint(equalToConstant: 53),
            
            confirmPasswordLabel.topAnchor.constraint(equalTo: passwordTextFild.bottomAnchor, constant: 30),
            confirmPasswordLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 42),
            confirmPasswordLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -42),
            
            confirmPasswordTextFild.topAnchor.constraint(equalTo: confirmPasswordLabel.bottomAnchor, constant: 15),
            confirmPasswordTextFild.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 42),
            confirmPasswordTextFild.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -42),
            confirmPasswordTextFild.heightAnchor.constraint(equalToConstant: 53),
            
            sentButton.topAnchor.constraint(equalTo: emailTextFild.bottomAnchor, constant: 70),
            sentButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 42),
            sentButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -42),
            sentButton.heightAnchor.constraint(equalToConstant: 73),
            
            changePasswordButton.topAnchor.constraint(equalTo: confirmPasswordTextFild.bottomAnchor, constant: 45),
            changePasswordButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 42),
            changePasswordButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -42),
            changePasswordButton.heightAnchor.constraint(equalToConstant: 73),
        ])
    }
}
