//
//  WelcomeViewController.swift
//  RadioApp
//
//  Created by Елена Логинова on 28.07.2024.
//

import UIKit

final class WelcomeViewController: UIViewController {
    public var action: (() -> Void)?
    private let welcomeView = WelcomeView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = welcomeView
        welcomeView.delegate = self
    }
}


extension WelcomeViewController: WelcomeViewDelegate {

    func startButtonPressed() {
        action?()
    }
}
