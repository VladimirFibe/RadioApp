//
//  FavoritesViewController.swift
//  RadioApp
//
//  Created by Елена Логинова on 31.07.2024.
//

import UIKit
import AVFoundation

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

    override func viewDidLoad() {
        super.viewDidLoad()
        view = favoritesView
        favoritesView.setDelegate(viewController: self)
        favoritesView.delegate = self
        updateButtonImage(isPlay: true)
        fetchLocalStorageForDownloads()
        goToProfileScreen()
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    func updateButtonImage(isPlay: Bool) {
        let image = isPlay ? UIImage(named: "playButton") : UIImage(named: "pauseButton")
        favoritesView.playPauseButton.setBackgroundImage(image, for: .normal)
    }
    
    func selectStation(at position: Int) {
        radioPlayer.changeCurrentURL(favoritesRadioStation[selectedIndex].url_resolved ?? "")
        favoritesView.collectionView.selectItem(at: IndexPath(item: position, section: 0), animated: true, scrollPosition: .top)
    }
    
    func goToProfileScreen() {
        favoritesView.topView.profileButtonPressed = {
            let profileVC = ProfileViewController()
            self.navigationController?.pushViewController(profileVC, animated: true)
        }
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

extension FavoritesViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let height: CGFloat = 123
        return CGSize(width: width, height: height)
    }
}

extension FavoritesViewController: FavoritesViewDelegate {
    func didSlideSlider(_ volume: Float) {
        radioPlayer.volume = volume
    }
    
    func playButtonPressed() {
        let currentRadioStation = favoritesRadioStation[selectedIndex]
        if radioPlayer.isPlayerPerforming() {
            radioPlayer.pauseMusic()
            updateButtonImage(isPlay: true)
        } else {
            radioPlayer.playMusic()
            updateButtonImage(isPlay: false)
            radioPlayer.configurePlayerForFavorite(from: currentRadioStation)
        }
    }
    
    func backButtonPressed() {
        selectedIndex -= 1
        radioPlayer.configurePlayerForFavorite(from: favoritesRadioStation[selectedIndex])
        DispatchQueue.main.async {
            self.updateButtonImage(isPlay: self.radioPlayer.isPlayerPerforming())
        }
    }
    
    func nextButtonPressed() {
        selectedIndex += 1
        radioPlayer.configurePlayerForFavorite(from: favoritesRadioStation[selectedIndex])
        DispatchQueue.main.async {
              self.updateButtonImage(isPlay: self.radioPlayer.isPlayerPerforming())
        }
    }
}
