//
//  ConnectWithGoogleView.swift
//  RadioApp
//
//  Created by Иван Семикин on 31/07/2024.
//

import UIKit
import SnapKit

final class ConnectWithGoogleView: UIView {
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()
    
    private let leftDividerView: UIView = {
       let view = UIView()
        view.backgroundColor = .systemGray2
        return view
    }()
    
    private let rightDividerView: UIView = {
       let view = UIView()
        view.backgroundColor = .systemGray2
        return view
    }()
    
    private let connectLabel: UILabel = {
       let label = UILabel()
        label.text = "Or connect with"
        label.textColor = .systemGray2
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private Methods
private extension ConnectWithGoogleView {
    func setupUI() {
        backgroundColor = .clear
        addSubviews()
        setConstraints()
    }
    
    func addSubviews() {
        addSubview(stackView)
        stackView.addArrangedSubview(leftDividerView)
        stackView.addArrangedSubview(connectLabel)
        stackView.addArrangedSubview(rightDividerView)
    }
    
    func setConstraints() {
        stackView.snp.makeConstraints { make in
            make.width.equalTo(295)
            make.height.equalTo(13)
            make.centerX.equalToSuperview()
            make.top.bottom.equalToSuperview()
        }
        
        leftDividerView.snp.makeConstraints { make in
            make.width.equalTo(78)
            make.height.equalTo(2)
        }
        
        rightDividerView.snp.makeConstraints { make in
            make.width.equalTo(78)
            make.height.equalTo(2)
        }
        
        connectLabel.snp.makeConstraints { make in
            make.width.equalTo(95)
        }
    }
}

@available(iOS 17.0, *)
#Preview() {
    ConnectWithGoogleView()
}
