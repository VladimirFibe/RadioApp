//
//  FavoritesViewController.swift
//  RadioApp
//
//  Created by Елена Логинова on 31.07.2024.
//

import UIKit
import AVFoundation

struct RadioStation: Decodable {
    let stationuuid: String
    let name: String
    let votes: Int
    let url_resolved: String
    let tags: String
    var isFavorite: Bool?
    
    var capitalizedName: String {
        name.capitalized
    }
    
    var tag: String {
        guard let stroke = tags.components(separatedBy: CharacterSet(charactersIn: " ,")).first else { return "" }
        return stroke.capitalized
    }
}

final class FavoritesViewController: UIViewController {

    private var favoritesRadioStation: [RadioStations] = []
    private let favoritesView = FavoritesView()
    private let radioPlayer = RadioPlayer.shared
    
    
    var selectedIndex = 0 {
        didSet {
            defer {
                selectStation(at: selectedIndex)
            }
            guard 0..<favoritesRadioStation.endIndex ~= selectedIndex else {
                selectedIndex = selectedIndex < 0 ? favoritesRadioStation.count - 1 : 0
                return
            }
        }
    }
    
    private let radioStations: [RadioStation] = [
        .init(stationuuid: "", name: "MANGORADIO", votes: 100, url_resolved: "https://mangoradio.stream.laut.fm/mangoradio?t302=2024-07-30_09-17-41&uuid=7c9dcca1-00a5-4fd2-bda6-bfa522ed50d5", tags: "Punk", isFavorite: true),
        .init(stationuuid: "", name: "REYFM - #original", votes: 250, url_resolved: "https://reyfm-stream18.radiohost.de/reyfm-original_mp3-192?_art=dD0xNzIyMzIzMTkyJmQ9YzFlMDc5NjUzYWVlOWZlYWUxYzg", tags: "Classic", isFavorite: true),
        .init(stationuuid: "", name: "Classic Vinyl HD", votes: 100, url_resolved: "https://icecast.walmradio.com:8443/classic", tags: "", isFavorite: true),
        .init(stationuuid: "", name: "WALM HD", votes: 100, url_resolved: "https://icecast.walmradio.com:8443/walm", tags: "POP", isFavorite: true),
        .init(stationuuid: "", name: "Christmas Vinyl HD", votes: 100, url_resolved: "https://icecast.walmradio.com:8443/christmas", tags: "", isFavorite: true),
        .init(stationuuid: "", name: "BBC World Service", votes: 100, url_resolved: "http://stream.live.vc.bbcmedia.co.uk/bbc_world_service", tags: "Dance", isFavorite: true),
        .init(stationuuid: "", name: "Adroit Jazz Underground", votes: 250, url_resolved: "https://icecast.walmradio.com:8443/jazz", tags: "Rock", isFavorite: true),
        .init(stationuuid: "", name: "RFI Afrique", votes: 100, url_resolved: "", tags: "Classic", isFavorite: true),
        .init(stationuuid: "", name: "WALM - Old Time Radio", votes: 100, url_resolved: "https://icecast.walmradio.com:8443/otr", tags: "", isFavorite: true),
        .init(stationuuid: "", name: "Iran International", votes: 100, url_resolved: "https://radio.iraninternational.app/iintl_c", tags: "", isFavorite: true),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view = favoritesView
        favoritesView.setDelegate(viewController: self)
        favoritesView.delegate = self
        updateButtonImage(isPlay: true)
        fetchLocalStorageForDownloads()
        NotificationCenter.default.addObserver(forName: NSNotification.Name("downloaded"), object: nil, queue: nil) { _ in
            self.fetchLocalStorageForDownloads()
        }
        NotificationCenter.default.addObserver(forName: NSNotification.Name("radioDeleted"), object: nil, queue: nil) { _ in
            self.fetchLocalStorageForDownloads()
        }
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        radioPlayer.stopMusic()
        updateButtonImage(isPlay: true)
        favoritesView.collectionView.reloadData()
    }
    
    func updateButtonImage(isPlay: Bool) {
        let image = isPlay ? UIImage(named: "playButton") : UIImage(named: "pauseButton")
        favoritesView.playPauseButton.setBackgroundImage(image, for: .normal)
    }
    
    func selectStation(at position: Int) {
        radioPlayer.changeCurrentURL(radioStations[selectedIndex].url_resolved)
        favoritesView.collectionView.selectItem(at: IndexPath(item: position, section: 0), animated: true, scrollPosition: .top)
    }
    
    private func fetchLocalStorageForDownloads() {
        CoreManager.shared.fetchingRadioFromDataBase { [weak self] result in
            switch result {
            case .success(let stations):
                self?.favoritesRadioStation = stations
                self?.favoritesView.collectionView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

//MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension FavoritesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        favoritesRadioStation.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteCell.identifier, for: indexPath) as? FavoriteCell else { return UICollectionViewCell() }
        
        let radio = favoritesRadioStation[indexPath.row]
        
        cell.configureCell(with: radio, indexPath: indexPath)
        cell.dontLikeButtonTapped = {
            cell.deleteFavoriteRadio(indexPath: indexPath, radio: radio)
            self.favoritesRadioStation.remove(at: indexPath.item)
            DispatchQueue.main.async {
                self.favoritesView.collectionView.reloadData()
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
    }
}

extension FavoritesViewController: FavoritesViewDelegate {
    func didSlideSlider(_ volume: Float) {
        radioPlayer.volume = volume
    }
    
    func playButtonPressed() {
        let currentRadioStation = radioStations[selectedIndex]
        if radioPlayer.isPlayerPerforming() {
            radioPlayer.pauseMusic()
            updateButtonImage(isPlay: true)
        } else {
            radioPlayer.playMusic()
            updateButtonImage(isPlay: false)
            radioPlayer.configurePlayer(from: currentRadioStation)
        }
        //radioPlayer.isPlayerPerforming() ? radioPlayer.pauseMusic() : radioPlayer.playMusic()
    }
    
    func backButtonPressed() {
        selectedIndex -= 1
        radioPlayer.configurePlayer(from: radioStations[selectedIndex])
        DispatchQueue.main.async {
            self.updateButtonImage(isPlay: self.radioPlayer.isPlayerPerforming())
        }
    }
    
    func nextButtonPressed() {
        selectedIndex += 1
        radioPlayer.configurePlayer(from: radioStations[selectedIndex])
        DispatchQueue.main.async {
              self.updateButtonImage(isPlay: self.radioPlayer.isPlayerPerforming())
        }
    }
}
