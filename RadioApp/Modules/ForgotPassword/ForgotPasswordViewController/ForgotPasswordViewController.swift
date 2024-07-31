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

    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view = forgotPasswordView
        forgotPasswordView.delegate = self
        view.backgroundColor = .lightGray
        forgotPasswordView.hideChangePasswordView()
    }
}

extension ForgotPasswordViewController: ForgotPasswordViewDelegate {
    func sentButtonPressed() {
        forgotPasswordView.showChangePasswordView()
    }
}
