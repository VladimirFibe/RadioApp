//
//  ProfileViewController.swift
//  RadioApp
//
//  Created by Сергей Сухарев on 29.07.2024.
//

import UIKit

class ProfileViewController: UIViewController {
    
    
    
    let profileView = UIView(height: 86)
    let generalView = UIView(height: 190)
    let moreView = UIView(height: 190)
    let nameLabel = UILabel()
    let emailLabel = UILabel()
    let generalLabel = UILabel()
    let moreLabel = UILabel()
    let notificationImage = UIImageView()
    
    let generalCellView = (CellView(title: "General", image1: "alert", text1: "Notification", btn1: nil, image2: "globe", text2: "Language", btn2: "left-arrow"))
    
    let moreCellView = (CellView(title: "More", image1: "shield", text1: "Legal and Policies", btn1: "left-arrow", image2: "info", text2: "About Us", btn2: "left-arrow"))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assignBackground()
        setNavBar()
        setupView()
        settingButton()
        setNameLabel()
        setEmailLabel()
        setGeneralLabel()
        setNotificationImage()
        setMoreLabel()
        setupConstraints()
        
    }
  
    func assignBackground(){
            let background = UIImage(named: "Profile-background")
            var imageView : UIImageView!
            imageView = UIImageView(frame: view.bounds)
            imageView.contentMode =  .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.image = background
            imageView.center = view.center
            view.addSubview(imageView)
        }
    
    func setNavBar() {
        navigationItem.title = "Settings"
        navigationController?.navigationBar.titleTextAttributes = [
          .font: UIFont.systemFont(ofSize: 20), .foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.tintColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "Vector"), style: .plain, target: self, action: #selector(backButtonAction))
    }
    @objc private func backButtonAction() {
        navigationController?.popViewController(animated: true)
    }
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "AppIcon")
        imageView.layer.cornerRadius = 27
        imageView.backgroundColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
     private func setNameLabel() {
        nameLabel.text = "Name"
        nameLabel.textColor = .white
        nameLabel.textAlignment = .left
        nameLabel.font = .boldSystemFont(ofSize: 16)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    private func setEmailLabel() {
        emailLabel.text = "Email"
        emailLabel.textColor = UIColor(named: "colorGray")
        emailLabel.textAlignment = .left
        emailLabel.font = .boldSystemFont(ofSize: 14)
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var profileEditButton: UIButton = {
        let button = UIButton(primaryAction: profileEditAction)
        button.setImage(UIImage(named: "Icon - Edit"), for: .normal)
        button.tintColor = .colorButton
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var profileEditAction = UIAction { _ in
        let profileEditVC = ProfileEditViewController()
        self.navigationController?.pushViewController(profileEditVC, animated: true)
        profileEditVC.navigationItem.title = "Profile"
        profileEditVC.navigationController?.navigationBar.titleTextAttributes = [
          .font: UIFont.systemFont(ofSize: 20), .foregroundColor: UIColor.white]
    }
    private func setGeneralLabel() {
        generalLabel.text = "    General"
        generalLabel.textColor = .white
        generalLabel.textAlignment = .left
        generalLabel.font = .boldSystemFont(ofSize: 18)
        generalLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    private func setNotificationImage(){
        notificationImage.image = UIImage(named: "notification")
        notificationImage.contentMode = .scaleAspectFill
        notificationImage.backgroundColor = UIColor(named: "softDarkBlue")
        notificationImage.layer.cornerRadius = 12
        notificationImage.clipsToBounds = true
        notificationImage.isUserInteractionEnabled = true
        notificationImage.translatesAutoresizingMaskIntoConstraints = false
    }
    private func setMoreLabel() {
        moreLabel.text = "     More"
        moreLabel.textColor = .white
        moreLabel.textAlignment = .left
        moreLabel.font = .boldSystemFont(ofSize: 18)
        moreLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var logOutButton: UIButton = {
        let button = UIButton(primaryAction: logOutAction)
        button.setTitle("Log Out", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Medium", size: 16)
        button.layer.cornerRadius = 28
        button.backgroundColor = UIColor(named: "ColorButton")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var logOutAction = UIAction { _ in
        print("Log Out")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            profileView.topAnchor.constraint(equalTo: view.topAnchor,constant: 120),
            profileView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileView.widthAnchor.constraint(equalToConstant: 327),
            profileView.heightAnchor.constraint(equalToConstant: 86),
            
            imageView.leadingAnchor.constraint(equalTo: profileView.leadingAnchor, constant: 16),
            imageView.centerYAnchor.constraint(equalTo: profileView.centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 54),
            imageView.widthAnchor.constraint(equalToConstant: 54),
            
            nameLabel.topAnchor.constraint(equalTo: profileView.topAnchor, constant: 21),
            nameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16),

            
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            emailLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16),
            
            profileEditButton.centerYAnchor.constraint(equalTo: profileView.centerYAnchor),
            profileEditButton.trailingAnchor.constraint(equalTo: profileView.trailingAnchor,constant: -19),
            
            generalCellView.topAnchor.constraint(equalTo: profileView.bottomAnchor,constant: 35.6),
            generalCellView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            generalCellView.widthAnchor.constraint(equalToConstant: 327),
            generalCellView.heightAnchor.constraint(equalToConstant: 190),
            
            moreCellView.topAnchor.constraint(equalTo: generalCellView.bottomAnchor,constant: 35.6),
            moreCellView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            moreCellView.widthAnchor.constraint(equalToConstant: 327),
            moreCellView.heightAnchor.constraint(equalToConstant: 190),

            logOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logOutButton.widthAnchor.constraint(equalToConstant: 327),
            logOutButton.heightAnchor.constraint(equalToConstant: 56),
            logOutButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -79),
            ])
        
    }
    private func art (){
        if generalCellView.button2.currentImage == UIImage(named: "left-arrow"){
            generalCellView.button2.setImage(UIImage(named: "right-arrow"), for: .normal)
        } else {
            generalCellView.button2.setImage(UIImage(named: "left-arrow"), for: .normal)
        }
    }
    private func settingButton(){
        
        generalCellView.onTap1 = { isOn in
            guard let isOn else { return }
            if isOn {
                print("Включить уведомления")
            } else {
                print("Выключить уведомления")
            }
        }
        generalCellView.onTap2 = { [weak self] in
            print("language")
            self?.art()
        }
        
        moreCellView.onTap1 = {_ in
            let policiesVC = PoliciesView()
            self.navigationController?.pushViewController(policiesVC, animated: true)
            policiesVC.navigationItem.title = "Privacy Policy"
            policiesVC.navigationController?.navigationBar.titleTextAttributes = [
              .font: UIFont.systemFont(ofSize: 20), .foregroundColor: UIColor.white]
        }
        moreCellView.onTap2 = {
            let aboutUs = AboutUs()
            self.navigationController?.pushViewController(aboutUs, animated: true)
            aboutUs.navigationItem.title = "About Us"
            aboutUs.navigationController?.navigationBar.titleTextAttributes = [
              .font: UIFont.systemFont(ofSize: 20), .foregroundColor: UIColor.white]
        }
        
    }
    
    private func setupView() {
       
        view.addSubview(profileView)
        view.addSubview(generalCellView)
        view.addSubview(moreCellView)
        view.addSubview(logOutButton)
        
        profileView.addSubview(imageView)
        profileView.addSubview(nameLabel)
        profileView.addSubview(emailLabel)
        profileView.addSubview(profileEditButton)
        
    }
}

extension UIView {
    convenience init(height: Int) {
        self.init()
        frame = CGRect(x: 0, y: 0, width: 0, height: height)
        
        layer.cornerRadius = 20
        layer.borderWidth = 2
        layer.borderColor = UIColor(named: "ColorBorder")?.cgColor
        translatesAutoresizingMaskIntoConstraints = false
    }
}


@available(iOS 17.0, *)
#Preview {
    UINavigationController(rootViewController: ProfileViewController())
}
