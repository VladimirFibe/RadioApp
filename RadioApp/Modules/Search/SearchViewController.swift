//
//  SearchViewController.swift
//  RadioApp
//
//  Created by Елена Логинова on 09.08.2024.
//

import UIKit

final class SearchViewController: UIViewController {
    
    private let searchView = SearchView()
    private var searchResultRadio: [RadioStation] = []
    private var filteredRadioStations: [RadioStation] = []
    private let networkManager = NetworkManager.shared
    private let radioPlayer = RadioPlayer.shared
    
    private var offset: Int = 0
    private var limit: Int = 4
    private var hasMoreRadio = true
    private let query: String
    
    var selectedIndex = 0 {
        didSet {
            defer {
                selectStation(at: selectedIndex)
            }
            guard 0..<searchResultRadio.endIndex ~= selectedIndex else {
                selectedIndex = selectedIndex < 0 ? searchResultRadio.count - 1 : 0
                return
            }
        }
    }
    
    init(text: String) {
        self.query = text
        super.init(nibName: nil, bundle: nil)
        let queryResult = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        fetchSearchRadio(typeURL: .searchURL(guery: queryResult, limit: limit, offset: offset))
        searchView.searchBar.textField.text = text
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.viewDidLoad()
        view = searchView
        searchView.setDelegate(viewController: self)
        searchView.delegate = self
        updateButtonImage(isPlay: true)
        searchView.searchBar.changeButton()
        goToProfileScreen()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        radioPlayer.stopMusic()
        updateButtonImage(isPlay: true)
    }

    
    private func selectStation(at position: Int) {
        radioPlayer.changeCurrentURL(searchResultRadio[selectedIndex].url_resolved)
        searchView.searchCollectionView.selectItem(at: IndexPath(item: position, section: 0), animated: true, scrollPosition: .top)
    }
   
   private func updateButtonImage(isPlay: Bool) {
       let image = isPlay ? UIImage(named: "playButton") : UIImage(named: "pauseButton")
       searchView.playPauseButton.setBackgroundImage(image, for: .normal)
   }
   
   func createDismissKeyboardTapGesture() {
       let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
       view.addGestureRecognizer(tap)
   }
    
    func goToProfileScreen() {
        searchView.topView.profileButtonPressed = {
            let profileVC = ProfileViewController()
            self.navigationController?.pushViewController(profileVC, animated: true)
        }
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        searchResultRadio.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCell.identifier, for: indexPath) as? SearchCell else { return UICollectionViewCell() }
        let radio = searchResultRadio[indexPath.row]
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
                self.searchView.searchCollectionView.reloadData()
            }
        }
        
        cell.configureCell(with: radio, indexPath: indexPath, isFavorite: isFavorite)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        selectedIndex = indexPath.row
        radioPlayer.configurePlayer(from: searchResultRadio[selectedIndex])
        updateButtonImage(isPlay: false)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY >= (contentHeight - height) {
            guard hasMoreRadio == true else { return }
            offset += 4
            let queryResult = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            fetchSearchRadio(typeURL: .searchURL(guery: queryResult, limit: limit, offset: offset))
        }
    }
}

//MARK: - AllStationsViewDelegate
extension SearchViewController: SearchViewDelegate {
    func searchButtonPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
   func didSlideSlider(_ volume: Float) {
       radioPlayer.volume = volume
   }
   
   func nextButtonPressed() {
       selectedIndex += 1
       radioPlayer.configurePlayer(from: searchResultRadio[selectedIndex])
       DispatchQueue.main.async {
           self.updateButtonImage(isPlay: self.radioPlayer.isPlayerPerforming())
       }
   }
   
   func backButtonPressed() {
       selectedIndex -= 1
       radioPlayer.configurePlayer(from: searchResultRadio[selectedIndex])
       DispatchQueue.main.async {
           self.updateButtonImage(isPlay: self.radioPlayer.isPlayerPerforming())
       }
   }

   func playButtonPressed() {
       let currentRadioStation = searchResultRadio[selectedIndex]
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
extension SearchViewController {

    private func fetchSearchRadio(typeURL: APIEndpoint) {
        let url = typeURL.url
        self.networkManager.fetch([RadioStation].self, from: url) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let seachResult):
                if seachResult.count < 4 { self.hasMoreRadio = false }
                self.searchResultRadio.append(contentsOf: seachResult)
                DispatchQueue.main.async {
                    self.searchView.searchCollectionView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
