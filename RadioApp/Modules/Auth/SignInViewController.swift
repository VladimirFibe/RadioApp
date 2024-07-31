//
//  SignInViewController.swift
//  RadioApp
//
//  Created by Иван Семикин on 29/07/2024.
//

import UIKit
import SwiftUI
import SnapKit

final class SignInViewController: UIViewController {
    
    // MARK: - Private Properties
    private let backgroundView = BackgroundView()
    
    private let authStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    private let emailTextField: UITextField = {
       let textField = UITextField()
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.gray]
        textField.attributedPlaceholder = NSAttributedString(string: "Your email", attributes: attributes)
        return textField
    }()
    
    private let passwordTextField: UITextField = {
       let textField = UITextField()
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.gray]
        textField.attributedPlaceholder = NSAttributedString(string: "Your password", attributes: attributes)
        return textField
    }()
    
    private let forgotPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle("Forgot Password ?", for: .normal)
        button.setTitleColor(.systemGray4, for: .normal)
        button.contentHorizontalAlignment = .right
        return button
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .cyan
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 24, weight: .bold, scale: .large)
        let largeBoldDoc = UIImage(systemName: "arrow.right", withConfiguration: largeConfig)
        button.setImage(largeBoldDoc, for: .normal)
        button.tintColor = .white
        return button
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("or Sign UP", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        setupUI()
    }
}

// MARK: - Private Methods
private extension SignInViewController {
    func setupUI() {
        view.backgroundColor = .black
        addSubviews()
        setConstraints()
    }
    
    func addSubviews() {
        view.addSubview(backgroundView)
        view.addSubview(signUpButton)
        view.addSubview(loginButton)
        
        view.addSubview(authStackView)
        authStackView.addArrangedSubview(SignInStartLabel())
        authStackView.addArrangedSubview(createEmailBorderedTF())
        authStackView.addArrangedSubview(createPasswordBorderedTF())
        authStackView.addArrangedSubview(forgotPasswordButton)
    }
    
    func setConstraints() {
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        authStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
        }
        
        forgotPasswordButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(32)
            make.bottom.equalToSuperview().offset(-64)
        }
        
        loginButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(32)
            make.bottom.equalTo(signUpButton.snp.top).offset(-16)
            make.width.equalTo(153)
            make.height.equalTo(62)
        }
    }
    
    func createEmailBorderedTF() -> BorderView {
        let borderView = BorderView(title: "Email")
        borderView.addSubview(emailTextField)
        
        emailTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().offset(-5)
            make.height.equalTo(40)
        }
        return borderView
    }
    
    func createPasswordBorderedTF() -> BorderView {
        let borderView = BorderView(title: "Password")
        borderView.addSubview(passwordTextField)
        
        passwordTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().offset(-5)
            make.height.equalTo(40)
        }
        return borderView
    }
}

@available(iOS 17.0, *)
#Preview {
    SignInViewController()
}
