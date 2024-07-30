//
//  BorderView.swift
//  RadioApp
//
//  Created by Иван Семикин on 30/07/2024.
//

import UIKit

final class BorderView: UIView {
    private let borderView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.borderColor = UIColor.red.cgColor
        view.layer.borderWidth = 2
        view.layer.cornerRadius = 5
        return view
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
private extension BorderView {
    func setupUI() {
        addSubviews()
        setConstraints()
        setShadow()
    }
    
    func addSubviews() {
        addSubview(borderView)
    }
    
    func setConstraints() {
        borderView.snp.makeConstraints { make in
            make.width.equalTo(338)
            make.height.equalTo(53)
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
    
    func setShadow() {
        borderView.layer.shadowColor = UIColor.red.cgColor
        borderView.layer.shadowOpacity = 1
        borderView.layer.shadowOffset = CGSize(width: 4, height: 4)
        borderView.layer.shadowRadius = 4
    }
}

@available(iOS 17.0, *)
#Preview {
    BorderView()
}
