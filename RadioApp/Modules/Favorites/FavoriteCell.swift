//
//  FavoriteCell.swift
//  RadioApp
//
//  Created by Елена Логинова on 31.07.2024.
//

import UIKit

class FavoriteCell: UICollectionViewCell {
    
    static let identifier = "FavoriteCell"

    var dontLikeButtonTapped: (() -> Void)?
   
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var genreLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "POP"
        label.font = .custom(font: .bold, size: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var radioNameLabel: UILabel = {
        let label = UILabel()
        label.font = .custom(font: .regular, size: 15)
        label.textColor = .white
        label.textAlignment = .left
        label.text = "Radio Record"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var curvedLineImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "lineIsSelected")
        imageView.contentMode = .left
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .cyan
        button.backgroundColor = .clear
        button.setBackgroundImage(UIImage(named: "heartButton"), for: .normal)
        button.addTarget(self, action: #selector(likeButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var leftPointView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 4.13
        view.backgroundColor = .green
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var rightPointView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 4.13
        view.backgroundColor = .green
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func likeButtonPressed(sender: UIButton) {
        dontLikeButtonTapped?()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        genreLabel.text = nil
        radioNameLabel.text = nil
    }
    
    public func configureCell(with radio: RadioStations, indexPath: IndexPath) {
        var tag: String {
            guard let stroke = radio.tags?.components(separatedBy: CharacterSet(charactersIn: " ,")).first else { return "" }
            return stroke.capitalized
        }
        var capitalizedName: String {
            guard let stroke = radio.name?.replacingOccurrences(of: "\t", with: "", options: NSString.CompareOptions.literal, range: nil) else { return "" }
            return stroke.capitalized
        }
        genreLabel.text = (radio.tags == "") ? "Online" : tag
        radioNameLabel.text = capitalizedName
        addPointColors(with: indexPath)
    }
    
    private func addPointColors(with indexPath: IndexPath) {
        let arrayPointColors = [#colorLiteral(red: 0.6901960784, green: 0.1568627451, blue: 0.3294117647, alpha: 1), #colorLiteral(red: 0.09019607843, green: 0.5411764706, blue: 0.8666666667, alpha: 1), #colorLiteral(red: 0.5294117647, green: 0.08235294118, blue: 0.8, alpha: 1), #colorLiteral(red: 0.1568627451, green: 0.6901960784, blue: 0.4352941176, alpha: 1), #colorLiteral(red: 0.8901960784, green: 0.6588235294, blue: 0.06274509804, alpha: 1), #colorLiteral(red: 0.9098039216, green: 0.07058823529, blue: 0.07058823529, alpha: 1)]
        let color = arrayPointColors[indexPath.row % arrayPointColors.count]
        leftPointView.backgroundColor = color
        rightPointView.backgroundColor = color
    }
    
    public func deleteFavoriteRadio(indexPath: IndexPath, radio: RadioStations) {
        CoreManager.shared.deleteRadioWith(model: radio) { result in
            switch result {
            case .success():
                NotificationCenter.default.post(name: NSNotification.Name("deleteFavoriteFromFavoriteScreen"), object: nil)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func setupViews() {
        layer.cornerRadius = 15
        layer.borderWidth = 2
        layer.borderColor = #colorLiteral(red: 0.2560741901, green: 0.2609855533, blue: 0.3792468607, alpha: 1).cgColor
        backgroundColor = .clear
        addSubview(stackView)
        stackView.addArrangedSubview(genreLabel)
        stackView.addArrangedSubview(radioNameLabel)
        stackView.addArrangedSubview(curvedLineImageView)
        curvedLineImageView.addSubview(leftPointView)
        curvedLineImageView.addSubview(rightPointView)
        addSubview(likeButton)
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                layer.borderColor = #colorLiteral(red: 1, green: 0.2757065594, blue: 0.5015140772, alpha: 1).cgColor
            } else {
                layer.borderColor = #colorLiteral(red: 0.2560741901, green: 0.2609855533, blue: 0.3792468607, alpha: 1).cgColor
            }
        }
    }
}

extension FavoriteCell {
    func setConstraint() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: likeButton.leadingAnchor, constant: 0),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            
            leftPointView.leadingAnchor.constraint(equalTo: curvedLineImageView.leadingAnchor),
            leftPointView.centerYAnchor.constraint(equalTo: curvedLineImageView.centerYAnchor, constant: -5),
            leftPointView.heightAnchor.constraint(equalToConstant: 8.26),
            leftPointView.widthAnchor.constraint(equalToConstant: 8.26),
            
            rightPointView.leadingAnchor.constraint(equalTo: curvedLineImageView.leadingAnchor, constant: 81),
            rightPointView.centerYAnchor.constraint(equalTo: curvedLineImageView.centerYAnchor, constant: -5),
            rightPointView.heightAnchor.constraint(equalToConstant: 8.26),
            rightPointView.widthAnchor.constraint(equalToConstant: 8.26),

            likeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            likeButton.centerYAnchor.constraint(equalTo:  centerYAnchor),
            likeButton.heightAnchor.constraint(equalToConstant: 53.98),
            likeButton.widthAnchor.constraint(equalToConstant: 61.84),
        ])
    }
}

