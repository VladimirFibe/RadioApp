//
//  BackgroundView.swift
//  RadioApp
//
//  Created by Иван Семикин on 31/07/2024.
//

import UIKit

final class BackgroundView: UIView {
    
    private let backgroundPart1ImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "backgroundAppPart1")
        return imageView
    }()
    
    private let backgroundPart2ImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "backgroundAppPart2")
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
