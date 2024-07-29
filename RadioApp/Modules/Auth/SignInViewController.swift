//
//  SignInViewController.swift
//  RadioApp
//
//  Created by Иван Семикин on 29/07/2024.
//

import UIKit
import SwiftUI

final class SignInViewController: UIViewController {
    override func viewDidLoad() {
        setupUI()
    }
}

// MARK: - Private Methods
private extension SignInViewController {
    func setupUI() {
        view.backgroundColor = .black
    }
    
    func addSubviews() {
        
    }
    
    func setConstraints() {
        
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
