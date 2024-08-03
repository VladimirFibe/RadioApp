//
//  PoliciesView.swift
//  RadioApp
//
//  Created by Сергей Сухарев on 30.07.2024.
//

import UIKit

class PoliciesView: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        assignBackground()
        view.addSubview(privacyText)
        setConstraint()
        //        view.backgroundColor = .red
        
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
        navigationItem.title = "Privacy Policy"
        navigationController?.navigationBar.titleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 20), .foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.tintColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "Vector"), style: .plain, target: self, action: #selector(backButtonAction))
    }
    @objc private func backButtonAction() {
        navigationController?.popViewController(animated: true)
    }
    private lazy var privacyText: UITextView = {
        let privacyText = UITextView()
    
        let attributedText = NSMutableAttributedString()
        
        let titleText1 = NSMutableAttributedString(string: "Terms\n", attributes: [
            .font: UIFont.boldSystemFont(ofSize: 14),
            .foregroundColor: UIColor.white
        ])
        attributedText.append(titleText1)
        
        let ruleText1 = NSMutableAttributedString(string: "\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Eget ornare quam vel facilisis feugiat amet sagittis arcu, tortor. Sapien, consequat ultrices morbi orci semper sit nulla. Leo auctor ut etiam est, amet aliquet ut vivamus. Odio vulputate est id tincidunt fames.\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Eget ornare quam vel facilisis feugiat amet sagittis arcu, tortor. Sapien, consequat ultrices morbi orci semper sit nulla. Leo auctor ut etiam est, amet aliquet ut vivamus. Odio vulputate est id tincidunt fames.\n", attributes: [.font: UIFont.systemFont(ofSize: 14),.foregroundColor: UIColor.gray])
        
        attributedText.append(ruleText1)

        let titleText2 = NSMutableAttributedString(string: "\nChanges to the Service and/or Terms:\n", attributes: [
            .font: UIFont.boldSystemFont(ofSize: 14),
            .foregroundColor: UIColor.white
            ])
        
        attributedText.append(titleText2)
        
        let ruleText2 = NSMutableAttributedString(string:"\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Eget ornare quam vel facilisis feugiat amet sagittis arcu, tortor. Sapien, consequat ultrices morbi orci semper sit nulla. Leo auctor ut etiam est, amet aliquet ut vivamus. Odio vulputate est id tincidunt fames.\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Eget ornare quam vel facilisis feugiat amet sagittis arcu, tortor. Sapien, consequat ultrices morbi orci semper sit nulla. Leo auctor ut etiam est, amet aliquet ut vivamus. Odio vulputate est id tincidunt fames.\n", attributes: [.font: UIFont.systemFont(ofSize: 14),.foregroundColor: UIColor.gray])
        
        attributedText.append(ruleText2)
        privacyText.attributedText = attributedText
        
        
        //privacyText.textColor = .white
        privacyText.backgroundColor = .clear
        privacyText.textAlignment = .left
        privacyText.font = .boldSystemFont(ofSize: 16)
        //      privacyText.masksToBounds = true
        privacyText.isEditable = false
        privacyText.translatesAutoresizingMaskIntoConstraints = false
        return privacyText
    }()
    
    func setConstraint() {
        NSLayoutConstraint.activate([
            privacyText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            // privacyText.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            privacyText.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            privacyText.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            privacyText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            privacyText.widthAnchor.constraint(equalToConstant: 357),
            //privacyText.heightAnchor.constraint(equalToConstant: )
            
            
        ])
    }
}
@available(iOS 17.0, *)
#Preview {
    UINavigationController(rootViewController: PoliciesView())
}
