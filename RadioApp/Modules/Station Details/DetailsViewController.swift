//
//  DetailsViewController.swift
//  RadioApp
//
//  Created by Sergey Zakurakin on 8/2/24.
//

import UIKit
import SnapKit

class DetailsViewController: UIViewController {
   
    private var positionRadio: Int = 0
    private var detailRadioStations: [RadioStation] = []
    private let radioPlayer = RadioPlayer.shared
    
    //MARK: - UI
    private lazy var topView: CustomNavigationProfile = {
        let element = CustomNavigationProfile(nameTitle: "Playing now", imageProfile: "AppIcon")
        element.onTapBack = {
            self.navigationController?.popViewController(animated: true)
        }
        element.onTapProf = {
            self.navigationController?.pushViewController(ProfileViewController(), animated: true)
        }
        return element
    }()
    
    private lazy var background: UIImageView = {
        let element = UIImageView()
        element.image = UIImage(named: "detailsBackground")
        return element
    }()
    
    private lazy var equalizer: UIImageView = {
        let element = UIImageView()
        element.image = UIImage(named: "equalizer")
        return element
    }()
    
    private lazy var mainTitleLabel: UILabel = {
        let element = UILabel()
        element.textColor = .white
        element.font = UIFont.custom(font: .bold, size: 59)
        element.textAlignment = .center
        element.numberOfLines = 0
        return element
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let element = UILabel()
        element.textColor = .white
        element.font = UIFont.custom(font: .regular, size: 20)
        element.textAlignment = .center
        element.numberOfLines = 0
        return element
    }()
    
    private lazy var logoButton: UIButton = {
        let element = UIButton(type: .system)
        element.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        element.tintColor = .white
        return element
    }()
    
    private lazy var playPauseButton: UIButton = {
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
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.tintColor = .white
        button.setBackgroundImage(UIImage(named: "previousButton"), for: .normal)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var lineImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "lineImageView")
        return imageView
    }()
    
    private lazy var volumeSlider: UISlider = {
        let slider = UISlider()
        let configuration = UIImage.SymbolConfiguration(pointSize: 10)
        let image = UIImage(systemName: "circle.fill", withConfiguration: configuration)
        slider.setThumbImage(image, for: .normal)
        slider.maximumValue = 1.0
        slider.minimumValue = 0.0
        slider.value = 0.5
        slider.tintColor = .cyan
        slider.addTarget(self, action: #selector(sliderTapped), for: .valueChanged)
        return slider
    }()
    
    private lazy var volumeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "volume.2")
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var volumeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "50%"
        label.font = .custom(font: .regular, size: 15)
        return label
    }()
    
    init(currentRadio: [RadioStation], positionRadio: Int) {
        self.detailRadioStations = currentRadio
        self.positionRadio = positionRadio
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraint()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        radioPlayer.stopMusic()
    }
    
    //MARK: - Setup View
    private func setupView() {
        view.addSubview(background)
        view.addSubview(mainTitleLabel)
        view.addSubview(logoButton)
        view.addSubview(descriptionLabel)
        view.addSubview(equalizer)
        view.addSubview(playPauseButton)
        view.addSubview(backButton)
        view.addSubview(nextButton)
        view.addSubview(lineImageView)
        view.addSubview(volumeSlider)
        view.addSubview(volumeImageView)
        view.addSubview(volumeLabel)
        view.addSubview(topView)
    }
    
    private func configure() {
        let station = detailRadioStations[positionRadio]
        mainTitleLabel.text = station.tag
        descriptionLabel.text = station.capitalizedName
        let isFavorite = CoreManager.shared.updateLike(id: station.stationuuid)
        updateFavoriteButtonAppearance(isFavorite: isFavorite)
    }
    
    private func updateFavoriteButtonAppearance(isFavorite: Bool) {
        let like = UIImage(named: "logo")
        let dontLike = UIImage(named: "dontLikeButton")
        let image = isFavorite ? like : dontLike
        logoButton.setBackgroundImage(image, for: .normal)
    }
}

//MARK: - Setup Constraints
extension DetailsViewController {
    
    func setupConstraint() {
        background.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        mainTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(176)
            make.leading.equalTo(view.snp.leading).offset(16)
            make.trailing.equalTo(view.snp.trailing).offset(-16)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(mainTitleLabel.snp.bottom)
            make.leading.equalTo(view.snp.leading).offset(16)
            make.trailing.equalTo(view.snp.trailing).offset(-16)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        logoButton.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(144)
            make.trailing.equalTo(view.snp.trailing).offset(-44)
            make.height.equalTo(18)
            make.width.equalTo(21.99)
        }
        
        equalizer.snp.makeConstraints { make in
            make.centerY.equalTo(background.snp.centerY)
            make.leading.trailing.equalToSuperview()
        }
        
        playPauseButton.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-70)
            make.height.equalTo(89)
            make.width.equalTo(89)
        }
        
        lineImageView.snp.makeConstraints { make in
            make.centerX.equalTo(playPauseButton.snp.centerX)
            make.centerY.equalTo(playPauseButton.snp.centerY)
        }
        
        nextButton.snp.makeConstraints { make in
            make.centerY.equalTo(playPauseButton.snp.centerY)
            make.leading.equalTo(playPauseButton.snp.trailing).offset(35)
        }
            
        backButton.snp.makeConstraints { make in
            make.centerY.equalTo(playPauseButton.snp.centerY)
            make.trailing.equalTo(playPauseButton.snp.leading).offset(-35)
        }
        
        volumeSlider.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.bottom.equalTo(view.snp.bottom).offset(-59)
            make.width.equalTo(196)
        }
        
        volumeImageView.snp.makeConstraints { make in
            make.trailing.equalTo(volumeSlider.snp.leading).offset(-20)
            make.centerY.equalTo(volumeSlider.snp.centerY)
        }

        volumeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(volumeSlider.snp.centerY)
            make.leading.equalTo(volumeSlider.snp.trailing).offset(20)
        }
        
        topView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
        }
    }
}

//MARK: - Setup Radio
extension DetailsViewController {
    
    @objc private func playPauseButtonTapped(_ sender: UIButton) {
        if radioPlayer.isPlayerPerforming() {
            radioPlayer.pauseMusic()
            updateButtonImage(isPlay: true)
        } else {
            radioPlayer.playMusic()
            updateButtonImage(isPlay: false)
            radioPlayer.configurePlayer(from: detailRadioStations[positionRadio])
        }
    }
    
    func updateButtonImage(isPlay: Bool) {
        let image = isPlay ? UIImage(named: "playButton") : UIImage(named: "pauseButton")
        playPauseButton.setBackgroundImage(image, for: .normal)
    }
    
    @objc private func sliderTapped(_ sender: UISlider) {
        volumeLabel.text = "\(Int(sender.value * 100))%"
        radioPlayer.volume = sender.value
    }
    
    @objc private func backButtonTapped(_ sender: UIButton) {
        if positionRadio > 0 {
            positionRadio -= 1
        }
        configure()
        radioPlayer.configurePlayer(from: detailRadioStations[positionRadio])
        DispatchQueue.main.async {
            self.updateButtonImage(isPlay: self.radioPlayer.isPlayerPerforming())
        }
    }
    
    @objc private func nextButtonTapped(_ sender: UIButton) {
        if positionRadio < (detailRadioStations.count - 1) {
            positionRadio += 1
        }
        configure()
        radioPlayer.configurePlayer(from: detailRadioStations[positionRadio])
        DispatchQueue.main.async {
            self.updateButtonImage(isPlay: self.radioPlayer.isPlayerPerforming())
        }
    }
}

//MARK: - Setup Save
extension DetailsViewController {
    
    @objc private func likeButtonTapped(_ sender: UIButton) {
        let station = detailRadioStations[positionRadio]
        let isFavorite = CoreManager.shared.updateLike(id: station.stationuuid)
        if isFavorite == true {
            deleteRadioAt(id: station.stationuuid)
            updateFavoriteButtonAppearance(isFavorite: false)
        } else {
            downloadRadioAt(radio: station)
            updateFavoriteButtonAppearance(isFavorite: true)
        }
    }
    
    
    private func downloadRadioAt(radio: RadioStation) {
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
    
    private func deleteRadioAt(id: String) {
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
}
