//
//  SignInStartLabel.swift
//  RadioApp
//
//  Created by Иван Семикин on 30/07/2024.
//

import UIKit

final class SignInStartLabel: UIView {
    
    private let stackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    private let signInLabel: UILabel = {
       let label = UILabel()
        label.text = "Sign in"
        label.font = .systemFont(ofSize: 48, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    private let toStartPlayLabel: UILabel = {
       let label = UILabel()
        label.text = "to start play"
        label.font = .systemFont(ofSize: 24)
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private Methods
private extension SignInStartLabel {
    func addSubviews() {
        addSubview(stackView)
        
        stackView.addArrangedSubview(signInLabel)
        stackView.addArrangedSubview(toStartPlayLabel)
    }
    
    func setConstraints() {
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

@available(iOS 17.0, *)
#Preview {
    SignInStartLabel()
}
