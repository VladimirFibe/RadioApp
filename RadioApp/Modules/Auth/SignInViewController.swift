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
    private let backgroundImageView: UIImageView = {
        let image = UIImage(named: "backgroundApp")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        return imageView
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
        view.addSubview(backgroundImageView)
        view.addSubview(signUpButton)
    }
    
    func setConstraints() {
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        signUpButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(32)
            make.bottom.equalToSuperview().offset(-64)
        }
        
        
    }
}

struct SignInViewControllerPreview: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> SignInViewController {
        return SignInViewController()
    }
    
    func updateUIViewController(_ uiViewController: SignInViewController, context: Context) {
        // Code to update the view controller if needed
    }
}

struct SignInViewControllerPreview_Previews: PreviewProvider {
    static var previews: some View {
        SignInViewControllerPreview()
            .edgesIgnoringSafeArea(.all)
    }
}
