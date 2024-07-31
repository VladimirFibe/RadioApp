//
//  ConnectWithGoogleView.swift
//  RadioApp
//
//  Created by Иван Семикин on 31/07/2024.
//

import UIKit

final class ConnectWithGoogleView: UIView {
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        return stackView
    }()
    
    private let dividerView: UIView = {
       let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    private let connectLabel: UILabel = {
       let label = UILabel()
        label.text = "Or connect with"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

@available(iOS 17.0, *)
#Preview() {
    ConnectWithGoogleView()
}
