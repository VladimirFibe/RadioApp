//
//  PopularView.swift
//  RadioApp
//
//  Created by Елена Логинова on 02.08.2024.
//

import UIKit

protocol PopularViewDelegate: AnyObject {
    func nextButtonPressed()
    func backButtonPressed()
    func playButtonPressed()
    func didSlideSlider(_ volume: Float)
}

final class PopularView: UIView {

    weak var delegate: PopularViewDelegate?
    
    lazy var topView: CustomNavigationBar = {
        let view = CustomNavigationBar()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var volumeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "volume.2")
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var volumeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "50%"
        label.font = .custom(font: .regular, size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var popularLabel: UILabel = {
        let label = UILabel()
        label.font = .custom(font: .regular, size: 30)
        label.textColor = .white
        label.text = "Popular"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var popularCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: setupFlowLayout())
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(PopularCell.self, forCellWithReuseIdentifier: PopularCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var volumeSlider: UISlider = {
        let slider = UISlider()
        let configuration = UIImage.SymbolConfiguration(pointSize: 10)
        let image = UIImage(systemName: "circle.fill", withConfiguration: configuration)
        slider.setThumbImage(image, for: .normal)
        slider.maximumValue = 1.0
        slider.minimumValue = 0.0
        slider.value = 0.5
        slider.transform = CGAffineTransform(rotationAngle: -CGFloat.pi/2)
        slider.tintColor = .cyan
        slider.addTarget(self, action: #selector(sliderTapped), for: .valueChanged)
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    lazy var playPauseButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.setBackgroundImage(UIImage(named: "playButton"), for: .normal)
        button.addTarget(self, action: #selector(playPauseButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.setBackgroundImage(UIImage(named: "nextButton"), for: .normal)
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.tintColor = .white
        button.setBackgroundImage(UIImage(named: "previousButton"), for: .normal)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var lineImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "lineImageView")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("PopularView not initialised ")
    }
    
    @objc func sliderTapped(_ sender: UISlider) {
        volumeLabel.text = "\(Int(sender.value * 100))%"
        delegate?.didSlideSlider(sender.value)
    }
    
    @objc func buttonPressed(_ sender: UIButton) {
        delegate?.nextButtonPressed()
    }
    
    @objc func backButtonTapped(_ sender: UIButton) {
        delegate?.backButtonPressed()
    }
    
    @objc func playPauseButtonTapped(_ sender: UIButton) {
        delegate?.playButtonPressed()
    }
    
    func setDelegate(viewController: PopularViewController) {
        popularCollectionView.delegate = viewController
        popularCollectionView.dataSource = viewController
    }
    
    func setupFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: 139, height: 139)
        layout.minimumLineSpacing = 14
        return layout
    }
    
    func setupViews() {
        backgroundColor = #colorLiteral(red: 0.002947255969, green: 0.002675811062, blue: 0.1643544436, alpha: 1)
        addSubview(topView)
        addSubview(popularLabel)
        addSubview(popularCollectionView)
        addSubview(volumeSlider)
        addSubview(lineImageView)
        addSubview(volumeImageView)
        addSubview(volumeLabel)
        addSubview(playPauseButton)
        addSubview(nextButton)
        addSubview(backButton)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
            topView.heightAnchor.constraint(equalToConstant: 45),
            topView.trailingAnchor.constraint(equalTo: trailingAnchor),
            topView.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            popularLabel.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 26),
            popularLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 62.79),
            popularLabel.heightAnchor.constraint(equalToConstant: 36),
            
            volumeSlider.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -20),
            volumeSlider.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -178),
            volumeSlider.widthAnchor.constraint(equalToConstant: 196),
            
            volumeImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15),
            volumeImageView.topAnchor.constraint(equalTo: volumeSlider.topAnchor, constant: 118),
            
            volumeLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15),
            volumeLabel.topAnchor.constraint(equalTo: volumeSlider.topAnchor, constant: -118),
            
            playPauseButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            playPauseButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -70),
            playPauseButton.heightAnchor.constraint(equalToConstant: 89),
            playPauseButton.widthAnchor.constraint(equalToConstant: 89),
            
            lineImageView.centerXAnchor.constraint(equalTo: playPauseButton.centerXAnchor),
            lineImageView.centerYAnchor.constraint(equalTo: playPauseButton.centerYAnchor),
            
            nextButton.centerYAnchor.constraint(equalTo: playPauseButton.centerYAnchor),
            nextButton.leadingAnchor.constraint(equalTo: playPauseButton.trailingAnchor, constant: 35),
            
            backButton.centerYAnchor.constraint(equalTo: playPauseButton.centerYAnchor),
            backButton.trailingAnchor.constraint(equalTo: playPauseButton.leadingAnchor, constant: -35),
            
            popularCollectionView.topAnchor.constraint(equalTo: popularLabel.bottomAnchor, constant: 26),
            popularCollectionView.bottomAnchor.constraint(equalTo: playPauseButton.topAnchor, constant: -70),
            popularCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 60.5),
            popularCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -60.5),
        ])
    }
}
