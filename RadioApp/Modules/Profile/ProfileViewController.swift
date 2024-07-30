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
    //let profileEditButton = UIButton()

    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .red
        assignBackground()
        setNavBar()
        setupView()
        setNameLabel()
        setEmaleLabel()
        setGeneralLabel()
        setNotificationImage()
        setMoreLabel()
        setupConstraints()
       // view.backgroundColor = UIColor(patternImage: UIImage(named: "Profile-background")!)
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
//            view.sendSubviewToBack(imageView)
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
        //imageView.tintColor = .white
        imageView.backgroundColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
     func setNameLabel() {
        nameLabel.text = "Name"
        nameLabel.textColor = .white
        nameLabel.textAlignment = .left
        nameLabel.font = .boldSystemFont(ofSize: 16)
//      nameLabellayer.masksToBounds = true
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    private func setEmaleLabel() {
        emailLabel.text = "Email"
        emailLabel.textColor = UIColor(named: "colorGray")
        emailLabel.textAlignment = .left
        emailLabel.font = .boldSystemFont(ofSize: 14)
//        emailLabel.layer.masksToBounds = true
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var profileEditButton: UIButton = {
        let button = UIButton(primaryAction: profileEditAction)
        button.setImage(UIImage(named: "Icon - Edit"), for: .normal)
        //button.setTitle("Log Out", for: .normal)
        //button.setTitleColor(.white, for: .normal)
        //button.titleLabel?.font = UIFont(name: "Medium", size: 16)
        //button.layer.cornerRadius = 28
        //button.backgroundColor = UIColor(named: "ColorButton")
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
       // generalLabel.backgroundColor = UIColor(named: "lightGreyApp")
//        generalLa.layer.masksToBounds = true
        //general.layer.cornerRadius = 12
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
       //moreLabelel.backgroundColor = UIColor(named: "lightGreyApp")
        //moreLabel.layer.masksToBounds = true
       // moreLabelyer.cornerRadius = 12
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
            
            generalView.topAnchor.constraint(equalTo: profileView.bottomAnchor,constant: 35.6),
            generalView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            generalView.widthAnchor.constraint(equalToConstant: 327),
            generalView.heightAnchor.constraint(equalToConstant: 190),
            
            notificationImage.topAnchor.constraint(equalTo: generalLabel.bottomAnchor, constant: 20),
            notificationImage.leadingAnchor.constraint(equalTo: generalView.leadingAnchor, constant: 10),
            //notificationImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            notificationImage.widthAnchor.constraint(equalToConstant: 24),
            notificationImage.heightAnchor.constraint(equalToConstant: 24),

            moreView.topAnchor.constraint(equalTo: generalView.bottomAnchor,constant: 35.6),
            moreView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            moreView.widthAnchor.constraint(equalToConstant: 327),
            moreView.heightAnchor.constraint(equalToConstant: 190),

            logOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logOutButton.widthAnchor.constraint(equalToConstant: 327),
            logOutButton.heightAnchor.constraint(equalToConstant: 56),
            logOutButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -79)
        ])
        
    }
    private func setupView() {
        view.addSubview(profileView)
        view.addSubview(generalView)
        view.addSubview(moreView)
        view.addSubview(logOutButton)
        
        profileView.addSubview(imageView)
        profileView.addSubview(nameLabel)
        profileView.addSubview(emailLabel)
        profileView.addSubview(profileEditButton)
        
        generalView.addSubview(generalLabel)
        generalView.addSubview(notificationImage)
        
        moreView.addSubview(moreLabel)
        
    }
}

extension UIView {
    convenience init(height: Int) {
        self.init()
        self.frame = CGRect(x: 0, y: 0, width: 0, height: height)
        
        //backgroundColor = .white
        layer.cornerRadius = 20
        layer.borderWidth = 2
        layer.borderColor = UIColor(named: "ColorBorder")?.cgColor
//                self.contentMode = .scaleAspectFit
//                self.isUserInteractionEnabled = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}


@available(iOS 17.0, *)
#Preview {
    UINavigationController(rootViewController: ProfileViewController())
}
