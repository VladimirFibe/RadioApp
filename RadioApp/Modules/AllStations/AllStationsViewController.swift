//
//  AllStationsViewController.swift
//  RadioApp
//
//  Created by Елена Логинова on 09.08.2024.
//

import UIKit
import AVFoundation

protocol AllStationsViewControllerDelegate {
    func startSearch()
    func endSearch()
}

final class AllStationsViewController: UIViewController {
    
    var gestureRecognizer = UITapGestureRecognizer()

    private var offset: Int = 0
    private var limit: Int = 4
    private var hasMoreRadio = true
    
    private let allStationsView = AllStationsView()
    private var allRadioStations: [RadioStation] = []
    private var filteredData: [RadioStation] = []
    private var networkManager = NetworkManager.shared
    private let radioPlayer = RadioPlayer.shared

     var selectedIndex = 0 {
         didSet {
             defer {
                 selectStation(at: selectedIndex)
             }
             guard 0..<allRadioStations.endIndex ~= selectedIndex else {
                 selectedIndex = selectedIndex < 0 ? allRadioStations.count - 1 : 0
                 return
             }
         }
     }

     override func viewDidLoad() {
         super.viewDidLoad()
         view = allStationsView
         allStationsView.setDelegate(viewController: self)
         allStationsView.delegate = self
         updateButtonImage(isPlay: true)
         fetchAllRadioStations(typeURL: .allRadioStations(limit: limit, offset: offset))
         addGestureRecognizer()
         goToProfileScreen()
     }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        allStationsView.searchBar.textField.text?.removeAll()
        radioPlayer.stopMusic()
        updateButtonImage(isPlay: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }

     private func selectStation(at position: Int) {
         radioPlayer.changeCurrentURL(allRadioStations[selectedIndex].url_resolved)
         allStationsView.allStationsCollectionView.selectItem(at: IndexPath(item: position, section: 0), animated: true, scrollPosition: .top)
     }
    
    private func updateButtonImage(isPlay: Bool) {
        let image = isPlay ? UIImage(named: "playButton") : UIImage(named: "pauseButton")
        allStationsView.playPauseButton.setBackgroundImage(image, for: .normal)
    }
    
    private func addGestureRecognizer() {
        gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(endSearch))
        gestureRecognizer.isEnabled = false
        view.addGestureRecognizer(gestureRecognizer)
    }
    
    func goToProfileScreen() {
        allStationsView.topView.profileButtonPressed = {
            let profileVC = ProfileViewController()
            self.navigationController?.pushViewController(profileVC, animated: true)
        }
    }
    
 }

 //MARK: - UITableViewDelegate, UITableViewDataSource

 extension AllStationsViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         allRadioStations.count
     }
     
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AllStationsCell.identifier, for: indexPath) as? AllStationsCell else { return UICollectionViewCell() }
         let radio = allRadioStations[indexPath.row]
         let isFavorite = CoreManager.shared.updateLike(id: radio.stationuuid)
         
         //save to CoreData
         cell.likeCompletion = {
             cell.downloadRadioAt(indexPath: indexPath, radio: radio)
         }
         cell.deleteCompletion = {
             cell.deleteRadioAt(id: radio.stationuuid)
         }
         cell.updateLikeCompletion = {
             DispatchQueue.main.async {
                 self.allStationsView.allStationsCollectionView.reloadData()
             }
         }

         cell.configureCell(with: radio, indexPath: indexPath, isFavorite: isFavorite)
         return cell
     }
     
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         print(indexPath.row)
         selectedIndex = indexPath.row
         radioPlayer.configurePlayer(from: allRadioStations[selectedIndex])
         updateButtonImage(isPlay: false)
     }
     
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         let width = collectionView.bounds.width
         let height: CGFloat = 123
         return CGSize(width: width, height: height)
     }
     
     func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
         let offsetY = scrollView.contentOffset.y
         let contentHeight = scrollView.contentSize.height
         let height = scrollView.frame.size.height
         
         if offsetY >= (contentHeight - height) {
             guard hasMoreRadio == true else { return }
             offset += limit
             fetchAllRadioStations(typeURL: .allRadioStations(limit: limit, offset: offset))
         }
     }
 }

//MARK: - AllStationsViewDelegate
extension AllStationsViewController: AllStationsViewDelegate {
    func searchButtonPressed() {
        endSearch()
        guard let text = allStationsView.searchBar.textField.text else { return }
        if text != "" {
            let resultVC = SearchViewController(text: text)
            navigationController?.pushViewController(resultVC, animated: true)
        }
    }
    
    func didSlideSlider(_ volume: Float) {
        radioPlayer.volume = volume
    }
    
    func nextButtonPressed() {
        selectedIndex += 1
        radioPlayer.configurePlayer(from: allRadioStations[selectedIndex])
        DispatchQueue.main.async {
            self.updateButtonImage(isPlay: self.radioPlayer.isPlayerPerforming())
        }
    }
    
    func backButtonPressed() {
        selectedIndex -= 1
        radioPlayer.configurePlayer(from: allRadioStations[selectedIndex])
        DispatchQueue.main.async {
            self.updateButtonImage(isPlay: self.radioPlayer.isPlayerPerforming())
        }
    }

    func playButtonPressed() {
        let currentRadioStation = allRadioStations[selectedIndex]
        if radioPlayer.isPlayerPerforming() {
            radioPlayer.pauseMusic()
            updateButtonImage(isPlay: true)
        } else {
            radioPlayer.playMusic()
            updateButtonImage(isPlay: false)
            radioPlayer.configurePlayer(from: currentRadioStation)
        }
    }
}


//MARK: - fetchAllStations
extension AllStationsViewController {
    //Сетевой запрос всех станций
    private func fetchAllRadioStations(typeURL: APIEndpoint) {
        let url = typeURL.url
        self.networkManager.fetch([RadioStation].self, from: url) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let allStations):
                if allStations.count < self.limit { self.hasMoreRadio = false }
                self.allRadioStations.append(contentsOf: allStations)
                DispatchQueue.main.async {
                    self.allStationsView.allStationsCollectionView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension AllStationsViewController: AllStationsViewControllerDelegate {
    func startSearch() {
        gestureRecognizer.isEnabled = true
    }
    
    @objc func endSearch() {
        gestureRecognizer.isEnabled = false
        _ = allStationsView.searchBar.resignFirstResponder()
    }
}
