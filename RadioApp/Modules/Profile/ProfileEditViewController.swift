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
    
    let nameRow = UITextField(text: "   Name", size: 14, weight: .regular)
    let emailRow = UITextField(text: "   Email", size: 14, weight: .regular)
    
    var imageURLToSave: URL?
    let imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        assignBackground()
        setupView()
        setNameLabel()
        setEmaleLabel()
        setupConstraints()
        setNavBar()
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
        //imageView.tintColor = .white
        imageView.backgroundColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var editImageButton: UIButton = {
        let button = UIButton(primaryAction: editImageAction)
        button.setImage(UIImage(named: "Edit"), for: .normal)
        //button.setTitle("Log Out", for: .normal)
//        button.setTitleColor(.white, for: .normal)
        //button.titleLabel?.font = UIFont(name: "Medium", size: 16)
        button.layer.cornerRadius = 15
        button.backgroundColor = UIColor(named: "DarkBlue")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var editImageAction = UIAction { _ in
        self.imagePicker.delegate = self
        self.imagePicker.allowsEditing = true
        self.imagePicker.mediaTypes = ["public.image"]
        
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
  
    private lazy var saveChangesAction = UIAction { _ in
        print("Saved")
    }
    private func setupView(){
        view.addSubview(imageView)
        view.addSubview(editImageButton)
        view.addSubview(nameLabel)
        view.addSubview(emailLabel)
        view.addSubview(nameRow)
        view.addSubview(emailRow)
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
            
            
            emailRow.topAnchor.constraint(equalTo: nameRow.bottomAnchor, constant: 50),
            emailRow.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailRow.heightAnchor.constraint(equalToConstant: 53),
            emailRow.widthAnchor.constraint(equalToConstant: 327),

            
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
        self.layer.borderColor = UIColor(named: "ColorBorder")?.cgColor
        self.layer.cornerRadius = 8
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
        guard let imgSrc = CGImageSourceCreateWithData(data, options as CFDictionary) else {
            return nil }
        let metadata = CGImageSourceCopyPropertiesAtIndex(imgSrc, 0, options as CFDictionary)
        return metadata
    }
}

@available(iOS 17.0, *)
#Preview {
    UINavigationController(rootViewController: ProfileEditViewController())
}

