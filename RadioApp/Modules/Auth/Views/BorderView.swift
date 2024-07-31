//
//  BorderView.swift
//  RadioApp
//
//  Created by Иван Семикин on 30/07/2024.
//

import UIKit
import SnapKit

final class BorderView: UIView {
    private let stackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 19)
        label.textColor = .white
        return label
    }()
    
    private let borderView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.borderColor = UIColor.red.cgColor
        view.layer.borderWidth = 2
        view.layer.cornerRadius = 5
        return view
    }()
    
    init(frame: CGRect = .zero, title: String) {
        super.init(frame: frame)
        titleLabel.text = title
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private Methods
private extension BorderView {
    func setupUI() {
        addSubviews()
        setConstraints()
        setShadow()
    }
    
    func addSubviews() {
        addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(borderView)
    }
    
    func setConstraints() {
        stackView.snp.makeConstraints { make in
            make.width.equalTo(338)
            make.height.equalTo(87)
            make.edges.equalToSuperview()
        }
    }
    
    func setShadow() {
        borderView.layer.shadowColor = UIColor.red.cgColor
        borderView.layer.shadowOpacity = 1
        borderView.layer.shadowOffset = CGSize(width: 4, height: 4)
        borderView.layer.shadowRadius = 4
    }
}
