//
//  DetailsViewController.swift
//  RadioApp
//
//  Created by Sergey Zakurakin on 8/2/24.
//

import UIKit
import SnapKit

class DetailsViewController: UIViewController {
    
    //MARK: - UI
    private lazy var background: UIImageView = {
        let element = UIImageView()
        element.image = UIImage(named: "detailsBackground")
        
        return element
    }()
    
    private lazy var equalizer: UIImageView = {
        let element = UIImageView()
        element.image = UIImage(named: "equalizer")
        
        return element
    }()
    

    private lazy var mainTitleLabel: UILabel = {
        let element = UILabel()
        element.textColor = .white
        element.font = UIFont.systemFont(ofSize: 60)
        
        return element
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let element = UILabel()
        element.textColor = .white
        element.font = UIFont.systemFont(ofSize: 20)
        
        return element
    }()
    
    private lazy var logoButton: UIButton = {
        let element = UIButton(type: .system)
        element.setImage(.logo, for: .normal)
        element.tintColor = .red
        
        return element
    }()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupConstraint()
        
    }
    
    //MARK: - Setup View
    private func setupView() {
        view.addSubview(background)
        view.addSubview(mainTitleLabel)
        view.addSubview(logoButton)
        view.addSubview(descriptionLabel)
        view.addSubview(equalizer)
        
        mainTitleLabel.text = "90.5"
        descriptionLabel.text = "Radio Divelement"
    }
}

//MARK: - Setup Constraints
extension DetailsViewController {
    
    func setupConstraint() {
        background.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        mainTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(176)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(mainTitleLabel.snp.bottom)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        logoButton.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(144)
            make.trailing.equalTo(view.snp.trailing).offset(-44)
        }
        
        equalizer.snp.makeConstraints { make in
            make.centerY.equalTo(background.snp.centerY)
            make.leading.trailing.equalToSuperview()
        }
    }
}

