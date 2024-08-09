//
//  SettingRowView.swift
//  RadioApp
//
//  Created by Сергей Сухарев on 29.07.2024.
//

import UIKit

class CellView: UIView {
    
    var onTap1:((_ isOn: Bool?) -> Void)?
    var onTap2:(() -> Void)?
    
    var onMenuTap1:(() -> Void)?
    var onMenuTap2:(() -> Void)?
    
    let titleLabel = UILabel()
    let imageLabel1 = UIImageView()
    let textLabel1 = UILabel()
    var button1: UIControl?
    let line = UIView()
    let imageLabel2 = UIImageView()
    let textLabel2 = UILabel()
    let button2 = UIButton()
    let isMenu: Bool
    
    init(title: String, image1: String, text1: String, btn1: String?, image2: String, text2: String, btn2: String, isMenu: Bool = false){
        self.isMenu = isMenu
        super.init(frame: .zero)
        
        if let btn1 {
            button1 = UIButton()
            let btn = button1 as? UIButton
            btn!.setImage(UIImage(named: btn1), for: .normal)
            btn!.imageView?.contentMode = .scaleAspectFit
            btn!.clipsToBounds = true
        } else {
            button1 = UISwitch()
        }
        
        titleLabel.text = title
        imageLabel1.image = UIImage(named: image1)
        textLabel1.text = text1
        
        imageLabel2.image = UIImage(named: image2)
        textLabel2.text = text2
        button2.setImage(UIImage(named: btn2), for: .normal)
        
        createView()
        configuration()
        setupSubview()
        createView1()
        setConstraints()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupSubview(){
        addSubview(titleLabel)
        addSubview(imageLabel1)
        addSubview(textLabel1)
        addSubview(button1!)
        addSubview(line)
        addSubview(imageLabel2)
        addSubview(textLabel2)
        addSubview(button2)
    }
    private func createView1(){
        line.layer.cornerRadius = 20
        line.layer.borderWidth = 2
        line.layer.borderColor = UIColor(named: "ColorBorder")?.cgColor
        line.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func createView(){
        
        self.layer.cornerRadius = 20
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor(named: "ColorBorder")?.cgColor
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setConstraints(){
        let btn = button1 as? UIButton
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            imageLabel1.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 28),
            imageLabel1.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            imageLabel1.widthAnchor.constraint(equalToConstant: 24),
            imageLabel1.heightAnchor.constraint(equalToConstant: 24),
            
            textLabel1.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 32),
            textLabel1.leadingAnchor.constraint(equalTo: imageLabel1.leadingAnchor, constant: 40),
            //
            button1!.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 25),
            button1!.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -22),
            
            line.widthAnchor.constraint(equalToConstant: 266),
            line.heightAnchor.constraint(equalToConstant: 1),
            
            line.topAnchor.constraint(equalTo: textLabel1.bottomAnchor, constant: 27),
            line.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            imageLabel2.topAnchor.constraint(equalTo: line.bottomAnchor, constant: 27),
            imageLabel2.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            imageLabel2.widthAnchor.constraint(equalToConstant: 24),
            imageLabel2.heightAnchor.constraint(equalToConstant: 24),
            
            textLabel2.topAnchor.constraint(equalTo: line.bottomAnchor, constant: 31),
            textLabel2.leadingAnchor.constraint(equalTo: imageLabel2.leadingAnchor, constant: 40),
            
            button2.topAnchor.constraint(equalTo: line.bottomAnchor, constant: 25),
            button2.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -22),
            button2.widthAnchor.constraint(equalToConstant: 32),
            button2.heightAnchor.constraint(equalToConstant: 32),
            
        ])
        if let btn {
            button1!.heightAnchor.constraint(equalToConstant: 32).isActive = true
            button1!.widthAnchor.constraint(equalToConstant: 32).isActive = true
        } else {
            button1!.heightAnchor.constraint(equalToConstant: 24).isActive = true
            button1!.widthAnchor.constraint(equalToConstant: 48).isActive = true
            
        }
    }
    private func configuration() {
        titleLabel.textColor = .white
        titleLabel.textAlignment = .left
        titleLabel.font = .boldSystemFont(ofSize: 18)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        imageLabel1.contentMode = .scaleAspectFill
        imageLabel1.clipsToBounds = true
        imageLabel1.isUserInteractionEnabled = true
        imageLabel1.translatesAutoresizingMaskIntoConstraints = false
        
        textLabel1.textColor = .white
        textLabel1.textAlignment = .left
        textLabel1.font = .boldSystemFont(ofSize: 14)
        textLabel1.translatesAutoresizingMaskIntoConstraints = false
        
        let btn = button1 as? UIButton
        if let btn {
            
            btn.translatesAutoresizingMaskIntoConstraints = false
            btn.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            btn.tag = 1
            
        } else {
            let switchButton1 = button1 as? UISwitch
            switchButton1!.thumbTintColor = UIColor(named: "ColorSwichBtn")
            switchButton1!.onTintColor = .colorButton
            switchButton1!.translatesAutoresizingMaskIntoConstraints = false
            switchButton1!.addTarget(self, action: #selector(switchAction), for: .valueChanged)
        }
        
        imageLabel2.contentMode = .scaleAspectFill
        imageLabel2.backgroundColor = UIColor(named: "softDarkBlue")
        imageLabel2.layer.cornerRadius = 12
        imageLabel2.clipsToBounds = true
        imageLabel2.isUserInteractionEnabled = true
        imageLabel2.translatesAutoresizingMaskIntoConstraints = false
        
        textLabel2.textColor = .white
        textLabel2.textAlignment = .left
        textLabel2.font = .boldSystemFont(ofSize: 14)
        textLabel2.translatesAutoresizingMaskIntoConstraints = false
        
        button2.tag = 2
        button2.translatesAutoresizingMaskIntoConstraints = false
        button2.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        if isMenu {
            button2.showsMenuAsPrimaryAction = true
            
            let action1 = UIAction(title: "English") { _ in
                self.onMenuTap1?()
            }
            let action2 = UIAction(title: "Russian") { _ in
                self.onMenuTap2?()
            }
            let menu = UIMenu (title: "Language", children: [action1, action2])
            button2.menu = menu
        }
        
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            onTap1?(nil)
        default:
            onTap2?()
        }
    }
    @objc private func switchAction(_ sender: UISwitch) {
        if sender.isOn {
            print("ON")
        } else {
            print ("OFF")
        }
        onTap1?(sender.isOn)
    }
}
