//
//  PopularViewController.swift
//  RadioApp
//
//  Created by Елена Логинова on 02.08.2024.
//

import UIKit
import CoreData

final class PopularViewController: UIViewController {
    
    private var offset: Int = 0
    private var limit: Int = 8
    private var hasMoreRadio = true
    
    private let popularView = PopularView()
    private var popularRadioStations = [RadioStation]()
    private let radioPlayer = RadioPlayer.shared
    private let networkManager = NetworkManager.shared
    
    var selectedIndex = 0 {
        didSet {
            defer {
                selectStation(at: selectedIndex)
            }
            guard 0..<popularRadioStations.endIndex ~= selectedIndex else {
                selectedIndex = selectedIndex < 0 ? popularRadioStations.count - 1 : 0
                return
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        view = popularView
        popularView.setDelegate(viewController: self)
        popularView.delegate = self
        updateButtonImage(isPlay: true)
        fetchPopularRadio(typeURL: .popularRadioURL(limit: limit, offset: offset))
        goToProfileScreen()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    func selectStation(at position: Int) {
        radioPlayer.changeCurrentURL(popularRadioStations[selectedIndex].url_resolved)
        popularView.popularCollectionView.selectItem(at: IndexPath(item: position, section: 0), animated: true, scrollPosition: .top)
    }
    
    func updateButtonImage(isPlay: Bool) {
        let image = isPlay ? UIImage(named: "playButton") : UIImage(named: "pauseButton")
        popularView.playPauseButton.setBackgroundImage(image, for: .normal)
    }
    
    func goToProfileScreen() {
        popularView.topView.profileButtonPressed = {
            let profileVC = ProfileViewController()
            self.navigationController?.pushViewController(profileVC, animated: true)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        radioPlayer.stopMusic()
    }
}


// MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension PopularViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        popularRadioStations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularCell.identifier, for: indexPath) as? PopularCell else { return UICollectionViewCell() }

        let radio = popularRadioStations[indexPath.row]
        let isFavorite = CoreManager.shared.updateLike(id: radio.stationuuid)

        
        //MARK: - Save to CoreData
        cell.likeCompletion = {
            cell.downloadRadioAt(indexPath: indexPath, radio: radio)
        }
        
        cell.deleteCompletion = {
            cell.deleteRadioAt(id: radio.stationuuid)
        }
        
        cell.updateLikeCompletion = {
            DispatchQueue.main.async {
                self.popularView.popularCollectionView.reloadData()
            }
        }

        cell.configure(with: radio, indexPath: indexPath, isFavorite: isFavorite)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY >= (contentHeight - height) {
            guard hasMoreRadio == true else { return }
            offset += 8
            fetchPopularRadio(typeURL: .popularRadioURL(limit: limit, offset: offset))
        }
    }
}


//MARK: - PopularViewDelegate
extension PopularViewController: PopularViewDelegate {
    func didSlideSlider(_ value: Float) {
        radioPlayer.volume = value
    }
    
    func playButtonPressed() {
        let currentRadioStation = popularRadioStations[selectedIndex]
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
        radioPlayer.configurePlayer(from: popularRadioStations[selectedIndex])
        DispatchQueue.main.async {
            self.updateButtonImage(isPlay: self.radioPlayer.isPlayerPerforming())
        }
    }
    
    func nextButtonPressed() {
        selectedIndex += 1
        radioPlayer.configurePlayer(from: popularRadioStations[selectedIndex])
        DispatchQueue.main.async {
            self.updateButtonImage(isPlay: self.radioPlayer.isPlayerPerforming())
        }
    }
}

extension PopularViewController {
    //Сетевой запрос популярных станций
    private func fetchPopularRadio(typeURL: APIEndpoint) {
        let url = typeURL.url
        self.networkManager.fetch([RadioStation].self, from: url) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let popular):
                if popular.count < 8 { self.hasMoreRadio = false }
                self.popularRadioStations.append(contentsOf: popular)
                DispatchQueue.main.async {
                    self.popularView.popularCollectionView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
