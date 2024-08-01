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
    
    var capitalizedName: String {
        name.capitalized
    }
    
    var tag: String {
        guard let stroke = tags.components(separatedBy: CharacterSet(charactersIn: " ,")).first else { return "" }
        return stroke.capitalized
    }
}

final class FavoritesViewController: UIViewController {
    
    var selectedIndex = 0 {
        didSet {
            defer {
                selectStation(at: selectedIndex)
            }
            guard 0..<radioStations.endIndex ~= selectedIndex else {
                selectedIndex = selectedIndex < 0 ? radioStations.count - 1 : 0
                return
            }
        }
    }
    private let favoritesView = FavoritesView()
    private let radioPlayer = RadioPlayer.shared
    
    private let radioStations: [RadioStation] = [
        .init(stationuuid: "", name: "MANGORADIO", votes: 100, url_resolved: "https://mangoradio.stream.laut.fm/mangoradio?t302=2024-07-30_09-17-41&uuid=7c9dcca1-00a5-4fd2-bda6-bfa522ed50d5", tags: "Punk"),
        .init(stationuuid: "", name: "REYFM - #original", votes: 250, url_resolved: "https://reyfm-stream18.radiohost.de/reyfm-original_mp3-192?_art=dD0xNzIyMzIzMTkyJmQ9YzFlMDc5NjUzYWVlOWZlYWUxYzg", tags: "Classic"),
        .init(stationuuid: "", name: "Classic Vinyl HD", votes: 100, url_resolved: "https://icecast.walmradio.com:8443/classic", tags: ""),
        .init(stationuuid: "", name: "WALM HD", votes: 100, url_resolved: "https://icecast.walmradio.com:8443/walm", tags: "POP"),
        .init(stationuuid: "", name: "Christmas Vinyl HD", votes: 100, url_resolved: "https://icecast.walmradio.com:8443/christmas", tags: ""),
        .init(stationuuid: "", name: "BBC World Service", votes: 100, url_resolved: "http://stream.live.vc.bbcmedia.co.uk/bbc_world_service", tags: "Dance"),
        .init(stationuuid: "", name: "Adroit Jazz Underground", votes: 250, url_resolved: "https://icecast.walmradio.com:8443/jazz", tags: "Rock"),
        .init(stationuuid: "", name: "RFI Afrique", votes: 100, url_resolved: "", tags: "Classic"),
        .init(stationuuid: "", name: "WALM - Old Time Radio", votes: 100, url_resolved: "https://icecast.walmradio.com:8443/otr", tags: ""),
        .init(stationuuid: "", name: "Iran International", votes: 100, url_resolved: "https://radio.iraninternational.app/iintl_c", tags: ""),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view = favoritesView
        favoritesView.setDelegate(viewController: self)
        favoritesView.delegate = self
        updateButtonImage(isPlay: true)
    }
    
    func updateButtonImage(isPlay: Bool) {
        let image = isPlay ? UIImage(named: "playButton") : UIImage(named: "pause")
        favoritesView.playPauseButton.setBackgroundImage(image, for: .normal)
    }
    
    func selectStation(at position: Int) {
        radioPlayer.changeCurrentURL(radioStations[selectedIndex].url_resolved)
        favoritesView.collectionView.selectItem(at: IndexPath(item: position, section: 0), animated: true, scrollPosition: .top)
    }
}

//MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension FavoritesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        radioStations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteCell.identifier, for: indexPath) as? FavoriteCell else { return UICollectionViewCell() }
        let radio = radioStations[indexPath.row]
        cell.configureCell(with: radio)
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
            favoritesView.playPauseButton.setBackgroundImage(UIImage(named: "playButton"), for: .normal)
        } else {
            radioPlayer.playMusic()
            favoritesView.playPauseButton.setBackgroundImage(UIImage(named: "pause"), for: .normal)
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
