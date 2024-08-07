//
//  ForgotPasswordViewController.swift
//  RadioApp
//
//  Created by Vadim Zhelnov on 30.07.24.
//

import UIKit

class ForgotPasswordViewController : UIViewController {
    
    // MARK: - Variables
    
    private let forgotPasswordView = ForgotPasswordView()
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: .backgroundAppPart1)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view = forgotPasswordView
        view.backgroundColor = .black
        forgotPasswordView.delegate = self
    }
}

extension ForgotPasswordViewController: ForgotPasswordViewDelegate {
   
    func sentButtonPressed() {
        
    }
    
    func forgotPasswordleftArrowButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
    
}
