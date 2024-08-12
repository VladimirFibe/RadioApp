//
//  SearchCell.swift
//  RadioApp
//
//  Created by Елена Логинова on 09.08.2024.
//

import UIKit

final class SearchCell: UICollectionViewCell {
    
    static let identifier = "SearchCell"
    private var isFavorite: Bool = false
    private var liked: Bool = false
    private var votes: Int = 0
    private var indexPath: IndexPath!
    
    var likeCompletion: (() -> Void)?
    var deleteCompletion: (() -> Void)?
    var updateLikeCompletion: (() -> Void)?
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 1
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var genreLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.2560741901, green: 0.2609855533, blue: 0.3792468607, alpha: 1)
        label.text = "POP"
        label.font = .custom(font: .bold, size: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var radioNameLabel: UILabel = {
        let label = UILabel()
        label.font = .custom(font: .regular, size: 15)
        label.textColor = #colorLiteral(red: 0.2560741901, green: 0.2609855533, blue: 0.3792468607, alpha: 1)
        label.contentMode = .left
        label.text = "Radio Record"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var playingNowLabel: UILabel = {
        let label = UILabel()
        label.font = .custom(font: .bold, size: 14)
        label.textColor = #colorLiteral(red: 0.7517294288, green: 0.2430968285, blue: 0.4029924572, alpha: 1)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var curvedLineImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "lineNotSelected")
        imageView.contentMode = .left
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.setBackgroundImage(UIImage(named: "likeButton"), for: .normal)
        button.addTarget(self, action: #selector(likeSearchRadio), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var votesLabel: UILabel = {
        let label = UILabel()
        label.text = "votes 250"
        label.textColor = #colorLiteral(red: 0.2560741901, green: 0.2609855533, blue: 0.3792468607, alpha: 1)
        label.numberOfLines = 0
        label.textAlignment = .right
        label.font = .custom(font: .bold, size: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        NotificationCenter.default.addObserver(self, selector: #selector(updateLike), name: NSNotification.Name("deleteFavoriteFromFavoriteScreen"), object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func updateLike(_ sender: UIButton) {
        updateLikeCompletion?()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        genreLabel.text = nil
        radioNameLabel.text = nil
    }
    
    public func configureCell(with radio: RadioStation, indexPath: IndexPath, isFavorite: Bool) {
        votesLabel.text = "votes \(radio.votes)"
        genreLabel.text = (radio.tag == "") ? "Online" : radio.tag
        radioNameLabel.text = radio.capitalizedName
        
        self.liked = isFavorite
        self.indexPath = indexPath
        self.votes = radio.votes

        updateFavoriteButtonAppearance(isFavorite: liked)
        addPointColors(with: indexPath)
    }
    
    private func addPointColors(with indexPath: IndexPath) {
        let arrayPointColors = [#colorLiteral(red: 0.6901960784, green: 0.1568627451, blue: 0.3294117647, alpha: 1), #colorLiteral(red: 0.09019607843, green: 0.5411764706, blue: 0.8666666667, alpha: 1), #colorLiteral(red: 0.5294117647, green: 0.08235294118, blue: 0.8, alpha: 1), #colorLiteral(red: 0.1568627451, green: 0.6901960784, blue: 0.4352941176, alpha: 1), #colorLiteral(red: 0.8901960784, green: 0.6588235294, blue: 0.06274509804, alpha: 1), #colorLiteral(red: 0.9098039216, green: 0.07058823529, blue: 0.07058823529, alpha: 1)]
        let color = arrayPointColors[indexPath.row % arrayPointColors.count]
        leftPointView.backgroundColor = color
        rightPointView.backgroundColor = color
    }
    
    private func updateFavoriteButtonAppearance(isFavorite: Bool) {
        let likeButtonActive = UIImage(named: "likeButton")
        let likeButtonInactive = UIImage(named: "dontLikeButton")
        let image = isFavorite ? likeButtonActive : likeButtonInactive
        likeButton.setBackgroundImage(image, for: .normal)
    }
    
    public func downloadRadioAt(indexPath: IndexPath, radio: RadioStation) {
        CoreManager.shared.downloadRadioWith(model: radio) { result in
            switch result {
            case .success():
                print("downloaded to Database")
                NotificationCenter.default.post(name: NSNotification.Name("downloaded"), object: nil)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    public func deleteRadioAt(id: String) {
        CoreManager.shared.deleteRadioFromFavorites(id: id) { result in
            switch result {
            case .success():
                print("deleted from Database")
                NotificationCenter.default.post(name: NSNotification.Name("radioDeleted"), object: nil)
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
        addSubview(genreLabel)
        addSubview(radioNameLabel)
        addSubview(playingNowLabel)
        addSubview(curvedLineImageView)
        curvedLineImageView.addSubview(rightPointView)
        curvedLineImageView.addSubview(leftPointView)
        addSubview(votesLabel)
        addSubview(likeButton)
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                backgroundColor = #colorLiteral(red: 1, green: 0.1607843137, blue: 0.4274509804, alpha: 1)
                layer.borderWidth = 0
                layer.borderColor = nil
                genreLabel.textColor = .white
                votesLabel.textColor = .white
                radioNameLabel.textColor = .white
                playingNowLabel.text = "Playing now"
                curvedLineImageView.image = UIImage(named: "lineIsSelected")
            } else {
                backgroundColor = .none
                layer.borderWidth = 2
                layer.borderColor = #colorLiteral(red: 0.2560741901, green: 0.2609855533, blue: 0.3792468607, alpha: 1).cgColor
                genreLabel.textColor = #colorLiteral(red: 0.2560741901, green: 0.2609855533, blue: 0.3792468607, alpha: 1)
                votesLabel.textColor =  #colorLiteral(red: 0.2560741901, green: 0.2609855533, blue: 0.3792468607, alpha: 1)
                radioNameLabel.textColor =  #colorLiteral(red: 0.2560741901, green: 0.2609855533, blue: 0.3792468607, alpha: 1)
                playingNowLabel.text = nil
                curvedLineImageView.image = UIImage(named: "lineNotSelected")
            }
        }
    }
}

extension SearchCell {
    func setConstraint() {
        NSLayoutConstraint.activate([
            genreLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            genreLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            genreLabel.trailingAnchor.constraint(equalTo: curvedLineImageView.leadingAnchor, constant: -10),
            genreLabel.heightAnchor.constraint(equalToConstant: 36),
            
            radioNameLabel.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant: 10),
            radioNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            radioNameLabel.trailingAnchor.constraint(equalTo: curvedLineImageView.leadingAnchor, constant: -10),
            radioNameLabel.heightAnchor.constraint(equalToConstant: 16),
            
            playingNowLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            playingNowLabel.trailingAnchor.constraint(equalTo: curvedLineImageView.leadingAnchor, constant: 10),
            playingNowLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            
            radioNameLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            radioNameLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),

            likeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -13.86),
            likeButton.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            likeButton.heightAnchor.constraint(equalToConstant: 12),
            likeButton.widthAnchor.constraint(equalToConstant: 14.66),
            
            votesLabel.centerYAnchor.constraint(equalTo: likeButton.centerYAnchor),
            votesLabel.trailingAnchor.constraint(equalTo: likeButton.leadingAnchor, constant: -10),
            
            curvedLineImageView.topAnchor.constraint(equalTo: likeButton.bottomAnchor, constant: 30.56),
            curvedLineImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -27),
            curvedLineImageView.widthAnchor.constraint(equalToConstant: 93.91),
            
            leftPointView.leadingAnchor.constraint(equalTo: curvedLineImageView.leadingAnchor),
            leftPointView.centerYAnchor.constraint(equalTo: curvedLineImageView.centerYAnchor, constant: -5),
            leftPointView.heightAnchor.constraint(equalToConstant: 8.26),
            leftPointView.widthAnchor.constraint(equalToConstant: 8.26),
            
            rightPointView.trailingAnchor.constraint(equalTo: curvedLineImageView.trailingAnchor),
            rightPointView.centerYAnchor.constraint(equalTo: curvedLineImageView.centerYAnchor, constant: -5),
            rightPointView.heightAnchor.constraint(equalToConstant: 8.26),
            rightPointView.widthAnchor.constraint(equalToConstant: 8.26),
        ])
    }
}

extension SearchCell {
    @objc func likeSearchRadio(_ sender: UIButton) {
        liked.toggle()
        updateFavoriteButtonAppearance(isFavorite: liked)
        if liked {
            likeCompletion?()
        } else {
            deleteCompletion?()
        }
    }
}
