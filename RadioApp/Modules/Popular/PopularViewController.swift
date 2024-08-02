//
//  PopularViewController.swift
//  RadioApp
//
//  Created by Елена Логинова on 02.08.2024.
//

import UIKit

final class PopularViewController: UIViewController {
    
    private let popularView = PopularView()
    private var radioStations = [RadioStation]()
    private let radioPlayer = RadioPlayer.shared
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        view = popularView
        popularView.setDelegate(viewController: self)
        popularView.delegate = self
        updateButtonImage(isPlay: true)
        fetchRadio()
    }
    
    func selectStation(at position: Int) {
        radioPlayer.changeCurrentURL(radioStations[selectedIndex].url_resolved)
        popularView.popularCollectionView.selectItem(at: IndexPath(item: position, section: 0), animated: true, scrollPosition: .top)
    }
    
    func updateButtonImage(isPlay: Bool) {
        let image = isPlay ? UIImage(named: "playButton") : UIImage(named: "pauseButton")
        popularView.playPauseButton.setBackgroundImage(image, for: .normal)
    }
}


// MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension PopularViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        radioStations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularCell.identifier, for: indexPath) as? PopularCell else { return UICollectionViewCell() }
        let radio = radioStations[indexPath.row]
        cell.configure(with: radio)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        selectedIndex = indexPath.row
    }
}


extension PopularViewController: PopularViewDelegate {
    func didSlideSlider(_ value: Float) {
        radioPlayer.volume = value
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

extension PopularViewController {
    //Сетевой запрос популярных станций
    private func fetchRadio() {
        guard let url = URL(string: "https://de1.api.radio-browser.info/json/stations/topvote?limit=12") else { return }
        let session = URLSession.shared
        session.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            
            do {
                self.radioStations = try JSONDecoder().decode([RadioStation].self, from: data)
                DispatchQueue.main.async {
                    self.popularView.popularCollectionView.reloadData()
                }
            } catch let error {
                print(error)
            }
        }.resume()
    }
}
