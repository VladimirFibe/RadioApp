//
//  ChangePasswordViewController.swift
//  RadioApp
//
//  Created by Vadim Zhelnov on 2.08.24.
//
import UIKit

class ChangePasswordViewController : UIViewController {
    
    // MARK: - Variables
    
    private let changePasswordView = ChangePasswordView()

    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view = changePasswordView
        changePasswordView.delegate = self
    }
}

extension ChangePasswordViewController: ChangePasswordViewDelegate {
    
    func changePasswordButtonPressed() {
        print("changePasswordButtonPressed")
    }
    
    func changePasswordLeftArrowButtonPressed() {
        print("back from changePasswordViewController")
    }
    
}
