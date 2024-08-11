//
//  PopularCell.swift
//  RadioApp
//
//  Created by Елена Логинова on 02.08.2024.
//

import UIKit

final class PopularCell: UICollectionViewCell {
    
    static let identifier = "PopularCell"
    
    private var liked: Bool = false
    private var votes: Int = 0
    private var indexPath: IndexPath!
    
    var likeCompletion: (() -> Void)?
    var deleteCompletion: (() -> Void)?
    var updateLikeCompletion: (() -> Void)?
    
    
    private lazy var genreLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.2032947838, green: 0.204798311, blue: 0.3333529532, alpha: 1)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "RADIO"
        label.font = .custom(font: .bold, size: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var votesLabel: UILabel = {
        let label = UILabel()
        label.text = "votes 250"
        label.textColor = #colorLiteral(red: 0.2032947838, green: 0.204798311, blue: 0.3333529532, alpha: 1)
        label.numberOfLines = 0
        label.textAlignment = .right
        label.font = .custom(font: .bold, size: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = #colorLiteral(red: 0.2032947838, green: 0.204798311, blue: 0.3333529532, alpha: 1)
        button.setBackgroundImage(UIImage(named: "dontLikeButton"), for: .normal)
        button.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var playButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .custom(font: .regular, size: 15)
        label.textColor = #colorLiteral(red: 0.2032947838, green: 0.204798311, blue: 0.3333529532, alpha: 1)
        label.textAlignment = .center
        label.text = "Radio Record"
        label.numberOfLines = 0
        label.contentMode = .top
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var curvedLineImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "lineNotSelected")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
    
    func setupViews() {
        layer.cornerRadius = 15
        layer.borderWidth = 2
        layer.borderColor = #colorLiteral(red: 0.2032947838, green: 0.204798311, blue: 0.3333529532, alpha: 1).cgColor
        addSubview(genreLabel)
        addSubview(votesLabel)
        addSubview(likeButton)
        addSubview(playButton)
        addSubview(titleLabel)
        addSubview(curvedLineImageView)
        curvedLineImageView.addSubview(rightPointView)
        curvedLineImageView.addSubview(leftPointView)
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                backgroundColor = #colorLiteral(red: 1, green: 0.1607843137, blue: 0.4274509804, alpha: 1)
                layer.borderWidth = 0
                layer.borderColor = nil
                genreLabel.textColor = .white
                votesLabel.textColor = .white
                titleLabel.textColor = .white
                playButton.setBackgroundImage(UIImage(named: "playPopular"), for: .normal)
                curvedLineImageView.image = UIImage(named: "lineIsSelected")
                curvedLineImageView.alpha = 1.0
            } else {
                backgroundColor = .none
                layer.borderWidth = 2
                layer.borderColor = #colorLiteral(red: 0.2032947838, green: 0.204798311, blue: 0.3333529532, alpha: 1).cgColor
                genreLabel.textColor = #colorLiteral(red: 0.2032947838, green: 0.204798311, blue: 0.3333529532, alpha: 1)
                votesLabel.textColor = #colorLiteral(red: 0.2032947838, green: 0.204798311, blue: 0.3333529532, alpha: 1)
                titleLabel.textColor = #colorLiteral(red: 0.2032947838, green: 0.204798311, blue: 0.3333529532, alpha: 1)
                playButton.setBackgroundImage(nil, for: .normal)
                curvedLineImageView.image = UIImage(named: "lineNotSelected")
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        genreLabel.text = nil
        titleLabel.text = nil
        votesLabel.text = nil
    }
    
    public func configure(with radio: RadioStation, indexPath: IndexPath, isFavorite: Bool) {
        genreLabel.text = (radio.tag == "") ? "Online" : radio.tag
        titleLabel.text = radio.name
        votesLabel.text = "votes \(radio.votes)"
        
        self.liked = isFavorite
        self.indexPath = indexPath
        self.votes = radio.votes
        
        updateFavoriteButtonAppearance(isFavorite: liked)
        addPointColors(with: indexPath)
    }
    
    private func updateFavoriteButtonAppearance(isFavorite: Bool) {
        let bigActiveIcon = UIImage(named: "likeButton")
        let bigInactiveIcon = UIImage(named: "dontLikeButton")
        let image = isFavorite ? bigActiveIcon : bigInactiveIcon
        likeButton.setBackgroundImage(image, for: .normal)
    }
    
    private func addPointColors(with indexPath: IndexPath) {
        let arrayPointColors = [#colorLiteral(red: 0.6901960784, green: 0.1568627451, blue: 0.3294117647, alpha: 1), #colorLiteral(red: 0.09019607843, green: 0.5411764706, blue: 0.8666666667, alpha: 1), #colorLiteral(red: 0.5294117647, green: 0.08235294118, blue: 0.8, alpha: 1), #colorLiteral(red: 0.1568627451, green: 0.6901960784, blue: 0.4352941176, alpha: 1), #colorLiteral(red: 0.8901960784, green: 0.6588235294, blue: 0.06274509804, alpha: 1), #colorLiteral(red: 0.9098039216, green: 0.07058823529, blue: 0.07058823529, alpha: 1)]
        let color = arrayPointColors[indexPath.row % arrayPointColors.count]
        leftPointView.backgroundColor = color
        rightPointView.backgroundColor = color
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
    
    private func setConstraint() {
        NSLayoutConstraint.activate([
            genreLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -14),
            genreLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            genreLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            
            playButton.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            playButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            playButton.heightAnchor.constraint(equalToConstant: 30),
            playButton.widthAnchor.constraint(equalToConstant: 27),
            
            likeButton.topAnchor.constraint(equalTo: topAnchor, constant: 14),
            likeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -13),
            likeButton.heightAnchor.constraint(equalToConstant: 12),
            likeButton.widthAnchor.constraint(equalToConstant: 14.66),
            
            votesLabel.leadingAnchor.constraint(equalTo: playButton.trailingAnchor, constant: 10),
            votesLabel.trailingAnchor.constraint(equalTo: likeButton.leadingAnchor, constant: -2.5),
            votesLabel.centerYAnchor.constraint(equalTo: likeButton.centerYAnchor, constant: -1),
            
            titleLabel.topAnchor.constraint(equalTo: genreLabel.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            titleLabel.heightAnchor.constraint(equalToConstant: 16),
            
            curvedLineImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            curvedLineImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 21),
            curvedLineImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -21),
            curvedLineImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            
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

extension PopularCell {
    
    public func addStationVotes(isAddVote: Bool) {
        updateVote(isAddVote: isAddVote)
    }
    
    private func updateVote(isAddVote: Bool) {
        if isAddVote == true {
            votes = votes + 1
        } else {
            return
        }
        UIView.transition(with: votesLabel, duration: 0.2, options: .transitionCrossDissolve) {
            self.votesLabel.text = "votes \(self.votes)"
        }
    }
}

private extension PopularCell {
    @objc private func likeButtonTapped(_ sender: UIButton) {
        liked.toggle()
        updateFavoriteButtonAppearance(isFavorite: liked)
        if liked {
            likeCompletion?()
        } else {
            deleteCompletion?()
        }
    }
}
