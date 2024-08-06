//
//  SignInViewController.swift
//  RadioApp
//
//  Created by Иван Семикин on 29/07/2024.
//

import UIKit
import SwiftUI
import SnapKit
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

final class SignInViewController: UIViewController {
    
    // MARK: - Private Properties
    private var isLogin: Bool = true
    private let backgroundView = BackgroundView()
    private var nameTFView: BorderView!
    private let signInStartLabel = SignInStartLabel()
    
    private let scrollView: UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isScrollEnabled = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let authStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    private let connectWithGoogleStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    private let loginButtonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 16
        return stackView
    }()
    
    private let nameTextField: UITextField = {
       let textField = UITextField()
        textField.textColor = .white
        textField.returnKeyType = .next
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.gray]
        textField.attributedPlaceholder = NSAttributedString(string: "Your name",
        attributes: attributes)
        return textField
    }()
    
    private let emailTextField: UITextField = {
       let textField = UITextField()
        textField.textColor = .white
        textField.returnKeyType = .next
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.gray]
        textField.attributedPlaceholder = NSAttributedString(string: "Your email", attributes: attributes)
        return textField
    }()
    
    private let passwordTextField: UITextField = {
       let textField = UITextField()
        textField.isSecureTextEntry = true
        textField.textColor = .white
        textField.returnKeyType = .go
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.gray]
        textField.attributedPlaceholder = NSAttributedString(string: "Your password", attributes: attributes)
        return textField
    }()
    
    private let showPasswordButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        button.setImage(UIImage(systemName: "eye"), for: .selected)
        button.tintColor = .gray
        return button
    }()
    
    private let forgotPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle("Forgot Password ?", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.contentHorizontalAlignment = .right
        return button
    }()
    
    private let googleSignInButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(named: "google-plus"), for: .normal)
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
        button.setTitle("Or Sign UP", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        setupUI()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
        if !isLogin {
            scrollView.scrollToTop(animated: true)
        }
    }
}

// MARK: - Private Methods
private extension SignInViewController {
    func setupUI() {
        view.backgroundColor = .black
        
        nameTFView = createNameBorderedTF()
        nameTFView.isHidden = true
        
        addSubviews()
        setConstraints()
        addTargets()
        
        nameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    func addSubviews() {
        view.addSubview(backgroundView)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(authStackView)
        authStackView.addArrangedSubview(signInStartLabel)
        authStackView.addArrangedSubview(nameTFView)
        authStackView.addArrangedSubview(createEmailBorderedTF())
        authStackView.addArrangedSubview(createPasswordBorderedTF())
        authStackView.addArrangedSubview(forgotPasswordButton)
        authStackView.addArrangedSubview(connectWithGoogleStackView)
        
        connectWithGoogleStackView.addArrangedSubview(ConnectWithGoogleView())
        connectWithGoogleStackView.addArrangedSubview(googleSignInButton)
        
        contentView.addSubview(loginButtonsStackView)
        loginButtonsStackView.addArrangedSubview(loginButton)
        loginButtonsStackView.addArrangedSubview(signUpButton)
    }
    
    func setConstraints() {
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(scrollView)
        }
        
        authStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(220)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        forgotPasswordButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
        }
        
        googleSignInButton.snp.makeConstraints { make in
            make.height.width.equalTo(40)
        }
        
        loginButtonsStackView.snp.makeConstraints { make in
            make.top.equalTo(authStackView.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-200)
        }
        
        loginButton.snp.makeConstraints { make in
            make.width.equalTo(153)
            make.height.equalTo(62)
        }
    }
    
    func addTargets() {
        showPasswordButton.addTarget(
            self,
            action: #selector(togglePasswordVisibility),
            for: .touchUpInside
        )
        
        signUpButton.addTarget(
            self,
            action: #selector(changeLoginState),
            for: .touchUpInside
        )
        
        loginButton.addTarget(
            self,
            action: #selector(loginButtonPressed),
            for: .touchUpInside
        )
        
        googleSignInButton.addTarget(
            self,
            action: #selector(googleSignInButtonPressed),
            for: .touchUpInside
        )
    }
    
    func createNameBorderedTF() -> BorderView {
        let borderView = BorderView(title: "Name")
        borderView.addSubview(nameTextField)
        
        nameTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().offset(-5)
            make.height.equalTo(40)
        }
        return borderView
    }
    
    func createEmailBorderedTF() -> BorderView {
        let borderView = BorderView(title: "Email")
        borderView.addSubview(emailTextField)
        
        emailTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
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
            make.trailing.equalToSuperview().inset(50)
            make.bottom.equalToSuperview().offset(-5)
            make.height.equalTo(40)
        }
        
        borderView.addSubview(showPasswordButton)
        showPasswordButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalTo(passwordTextField.snp.centerY)
            make.width.height.equalTo(24)
        }
        return borderView
    }
    
    @objc func togglePasswordVisibility() {
        passwordTextField.isSecureTextEntry.toggle()
        showPasswordButton.isSelected.toggle()
    }
    
    @objc func changeLoginState() {
        UIView.animate(withDuration: 0.3) {
            self.authStackView.alpha = 0
            self.loginButtonsStackView.alpha = 0
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.viewsIsHiddenToogle()
                UIView.animate(withDuration: 0.3) {
                    self.authStackView.alpha = 1
                    self.loginButtonsStackView.alpha = 1
                }
            }
        }
    }
    
    func viewsIsHiddenToogle() {
        nameTFView.isHidden.toggle()
        forgotPasswordButton.isHidden.toggle()
        connectWithGoogleStackView.isHidden.toggle()
        signInStartLabel.changeTitle()
        
        signUpButton.setTitle(
            isLogin ? "Or Sign In" : "Or Sign Up",
            for: .normal
        )
        isLogin.toggle()
    }
    
    @objc func loginButtonPressed() {
        isLogin ? signIn() : signUp()
    }
}

// MARK: - UITextFieldDelegate
extension SignInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nameTextField:
            emailTextField.becomeFirstResponder()
        case emailTextField:
            passwordTextField.becomeFirstResponder()
        default:
            loginButtonPressed()
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if !isLogin {
            scrollView.scrollToBottom(animated: true)
        }
    }
    
    @objc func googleSignInButtonPressed() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        GIDSignIn.sharedInstance.signIn(withPresenting: self) {
            [weak self] result,
            error in
            guard error == nil else {
                self?.showAlert(title: "Oops..", message: "\(error!.localizedDescription)")
                return
            }
            
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString
            else {
                return
            }
            
            let credential = GoogleAuthProvider.credential(
                withIDToken: idToken,
                accessToken: user.accessToken.tokenString
            )
            
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    self?.showAlert(title: "Oops..", message: "\(error.localizedDescription)")
                    return
                }
                
                self?.navigationController?.pushViewController(TabBarController(), animated: true)
            }
        }
    }
}

// MARK: - FireBase Authorization
private extension SignInViewController {
    func signUp() {
        guard let _ = nameTextField.text,
              let email = emailTextField.text,
              let password = passwordTextField.text else {
            showAlert(title: "Missing Information", message: "Please fill in all required fields to proceed.")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authDataResult, error in
            
            if let error = error {
                self?.showAlert(title: "Oops..", message: "\(error.localizedDescription)")
            } else {
                self?.navigationController?.pushViewController(TabBarController(), animated: true)
            }
        }
    }
    
    func signIn() {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            showAlert(title: "Missing Information", message: "Please fill in all required fields to proceed.")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            if let error = error {
                self?.showAlert(title: "Oops..", message: "\(error.localizedDescription)")
            } else {
                self?.navigationController?.pushViewController(TabBarController(), animated: true)
            }
        }
    }
}

// MARK: - Alert
private extension SignInViewController {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        let okButton = UIAlertAction(title: "OK", style: .cancel) { [weak self] _ in
            self?.passwordTextField.text = ""
        }
        alert.addAction(okButton)
        present(alert, animated: true)
    }
}

@available(iOS 17.0, *)
#Preview {
    SignInViewController()
}
