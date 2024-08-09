//
//  ProfileEditViewController.swift
//  RadioApp
//
//  Created by Сергей Сухарев on 29.07.2024.
//

import UIKit

class ProfileEditViewController: UIViewController {
    
    let profileVC = ProfileViewController()
    
    let nameLabel = UILabel()
    let emailLabel = UILabel()
    
    let titleRowName = UILabel()
    let nameRow = UITextField(text: "   Name", size: 14, weight: .regular)
    let helperName = UILabel()
    let titleRowEmail = UILabel()
    let emailRow = UITextField(text: "   Email", size: 14, weight: .regular)
    let helperEmail = UILabel()
    
    var imageURLToSave: URL?
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        assignBackground()
        setNavBar()
        setupView()
        setNameLabel()
        setEmaleLabel()
        setTitleNameRow()
        setTitleEmailRow()
        setHelpers()
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
        navigationItem.title = "Profile"
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
        imageView.layer.cornerRadius = 35
        imageView.backgroundColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var editImageButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Edit"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(editImageAction), for: .touchUpInside)
        return button
    }()
    
    @objc private func editImageAction() {
        //        let blurView = UIView(frame: view.bounds)
        //        blurView.backgroundColor = UIColor.black.withAlphaComponent(0.0)
        //         view.addSubview(blurView)
        //
        //        
        //        let blurEffect = UIBlurEffect(style: .dark)
        //        let blurViewEffect = UIVisualEffectView(effect: blurEffect)
        //        blurViewEffect.frame = blurView.bounds
        //        blurView.addSubview(blurViewEffect)
        //        
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.mediaTypes = ["public.image"]
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.present(self.imagePicker, animated: true, completion: nil)
        }
    }
    
    func setNameLabel() {
        nameLabel.text = "Name"
        nameLabel.textColor = .white
        nameLabel.textAlignment = .left
        nameLabel.font = .boldSystemFont(ofSize: 16)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setEmaleLabel() {
        emailLabel.text = "Email"
        emailLabel.textColor = UIColor(named: "colorGray")
        emailLabel.textAlignment = .left
        emailLabel.font = .boldSystemFont(ofSize: 14)
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    func setTitleEmailRow() {
        titleRowEmail.text = "Email"
        titleRowEmail.textColor = .white
        titleRowEmail.textAlignment = .left
        titleRowEmail.font = .boldSystemFont(ofSize: 12)
        titleRowEmail.backgroundColor = .colorTitle
        titleRowEmail.translatesAutoresizingMaskIntoConstraints = false
    }
    func setTitleNameRow() {
        titleRowName.text = "Full name"
        titleRowName.textColor = .white
        titleRowName.textAlignment = .left
        titleRowName.font = .boldSystemFont(ofSize: 12)
        titleRowName.backgroundColor = .colorTitle
        titleRowName.translatesAutoresizingMaskIntoConstraints = false
    }
    private func setHelpers() {
        helperName.textColor = .colorHelper
        helperName.textAlignment = .left
        helperName.font = UIFont(name: "Medium", size: 16)
        helperName.translatesAutoresizingMaskIntoConstraints = false
        helperEmail.textColor = .colorHelper
        helperEmail.textAlignment = .left
        helperEmail.font = UIFont(name: "Medium", size: 16)
        helperEmail.translatesAutoresizingMaskIntoConstraints = false
    }
    private lazy var saveChangesButton: UIButton = {
        let button = UIButton(primaryAction: saveChangesAction)
        button.setTitle("Save Changes", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Medium", size: 16)
        button.layer.cornerRadius = 28
        button.backgroundColor = UIColor(named: "ColorButton")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private lazy var saveChangesAction = UIAction { [self] _ in
        print("Save Profile")
        self.navigationController?.popViewController(animated: true)
        //        if nameRow.text == "12"{
        //            helperName.text = "* Name already exist"
        //        } else {
        //            helperName.text = ""
        //        }
        //        if emailRow.text == ""{
        //            helperEmail.text = "* Email already exist"
        //        } else {
        //            helperEmail.text = ""
        //        }
    }
    private func setupView(){
        view.addSubview(imageView)
        view.addSubview(editImageButton)
        view.addSubview(nameLabel)
        view.addSubview(emailLabel)
        view.addSubview(titleRowName)
        view.addSubview(nameRow)
        view.addSubview(titleRowName)
        view.addSubview(helperName)
        view.addSubview(emailRow)
        view.addSubview(titleRowEmail)
        view.addSubview(helperEmail)
        view.addSubview(saveChangesButton)
        
    }
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            imageView.heightAnchor.constraint(equalToConstant: 72),
            imageView.widthAnchor.constraint(equalToConstant: 72),
            
            editImageButton.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -32),
            editImageButton.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 7),
            editImageButton.heightAnchor.constraint(equalToConstant: 32),
            editImageButton.widthAnchor.constraint(equalToConstant: 32),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 15),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 6),
            emailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            nameRow.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameRow.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 55),
            nameRow.heightAnchor.constraint(equalToConstant: 53),
            nameRow.widthAnchor.constraint(equalToConstant: 327),
            
            titleRowName.leadingAnchor.constraint(equalTo: nameRow.leadingAnchor, constant: 11),
            titleRowName.topAnchor.constraint(equalTo: nameRow.topAnchor, constant: -6),
            
            helperName.leadingAnchor.constraint(equalTo: nameRow.leadingAnchor, constant: 11),
            helperName.topAnchor.constraint(equalTo: nameRow.bottomAnchor, constant: 8),
            
            emailRow.topAnchor.constraint(equalTo: nameRow.bottomAnchor, constant: 50),
            emailRow.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailRow.heightAnchor.constraint(equalToConstant: 53),
            emailRow.widthAnchor.constraint(equalToConstant: 327),
            
            titleRowEmail.leadingAnchor.constraint(equalTo: emailRow.leadingAnchor, constant: 11),
            titleRowEmail.topAnchor.constraint(equalTo: emailRow.topAnchor, constant: -6),
            
            helperEmail.leadingAnchor.constraint(equalTo: emailRow.leadingAnchor, constant: 11),
            helperEmail.topAnchor.constraint(equalTo: emailRow.bottomAnchor, constant: 8),
            
            saveChangesButton.topAnchor.constraint(equalTo: emailRow.bottomAnchor, constant: 47),
            saveChangesButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveChangesButton.widthAnchor.constraint(equalToConstant: 327),
            saveChangesButton.heightAnchor.constraint(equalToConstant: 56),
            
        ])
    }
}

extension UITextField {
    convenience init(text: String, size: CGFloat , weight: UIFont.Weight) {
        self.init()
        self.attributedPlaceholder = NSAttributedString(string: text, attributes: [.foregroundColor: UIColor.lightGray, .font: UIFont.systemFont(ofSize: size, weight: weight)])
        self.layer.borderWidth = 1
        self.textColor = .white
        self.layer.borderColor = UIColor(named: "ColorBorder")?.cgColor
        self.layer.cornerRadius = 24
        self.keyboardType = .default
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
extension ProfileEditViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if info[.mediaType] as? String == "public.image" {
            self.handlePhoto(info)
        } else {
            print("DEBUG PRINT:", "Media was neither image")
            
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.imagePicker.dismiss(animated: true, completion: nil)
        }
    }
    //MARK: - Images
    private func handlePhoto(_ info: [UIImagePickerController.InfoKey: Any]) {
        if let imageURL = info[.imageURL] as? URL {
            print("DEBUG PRINT:", "Image URL: \(imageURL.description)")
            imageURLToSave = imageURL
            let dict: CFDictionary? = self.bestMetadataCollectionMethod(with: imageURL )
            print("DEBUG PRINT:", dict ?? "Failed to get metadata")
        }
        
        if let image = info[.originalImage] as? UIImage {
            self.imageView.image = image
        }
    }
    private func bestMetadataCollectionMethod(with url: URL) -> CFDictionary? {
        let options = [kCGImageSourceShouldCache as String: kCFBooleanFalse]
        guard let data = NSData(contentsOf: url) else { return nil }
        guard let imgSrc = CGImageSourceCreateWithData(data, options as CFDictionary) else { return nil }
        let metadata = CGImageSourceCopyPropertiesAtIndex(imgSrc, 0, options as CFDictionary)
        return metadata
    }
}

@available(iOS 17.0, *)
#Preview {
    UINavigationController(rootViewController: ProfileEditViewController())
}

