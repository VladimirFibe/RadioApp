//
//  FavoritesViewController.swift
//  RadioApp
//
//  Created by Елена Логинова on 31.07.2024.
//

import UIKit

struct RadioStation: Decodable {
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
    
    var currentRow = Int()
    private let favoritesView = FavoritesView()
    
    private let radioStations: [RadioStation] = [
        .init(name: "Radio Record", votes: 100, url_resolved: "https://mangoradio.stream.laut.fm/mangoradio?t302=2024-07-30_09-17-41&uuid=7c9dcca1-00a5-4fd2-bda6-bfa522ed50d5", tags: "Punk"),
        .init(name: "Radio Gameplay", votes: 250, url_resolved: "https://reyfm-stream18.radiohost.de/reyfm-original_mp3-192?_art=dD0xNzIyMzIzMTkyJmQ9YzFlMDc5NjUzYWVlOWZlYWUxYzg", tags: "Classic"),
        .init(name: "Punk Rock", votes: 100, url_resolved: "", tags: ""),
        .init(name: "IREMIXI", votes: 100, url_resolved: "", tags: "POP"),
        .init(name: "beufm.kz", votes: 100, url_resolved: "", tags: ""),
        .init(name: "Radio Gameplay", votes: 100, url_resolved: "", tags: "Dance"),
        .init(name: "IREMIXI", votes: 250, url_resolved: "", tags: "Rock"),
        .init(name: "Radio Record", votes: 100, url_resolved: "", tags: "Classic"),
        .init(name: "beufm.kz", votes: 100, url_resolved: "", tags: ""),
        .init(name: "Punk Rock", votes: 100, url_resolved: "", tags: ""),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view = favoritesView
        favoritesView.setDelegate(viewController: self)
        favoritesView.delegate = self
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
        currentRow = indexPath.row
    }
}

extension FavoritesViewController: FavoritesViewDelegate {
    func didSlideSlider(slider: UISlider) {
       // let value = slider.value
    }
    
    func playButtonPressed() {
        print("playButtonPressed")
    }
    
    func backButtonPressed() {
        if currentRow > 0 {
            currentRow = currentRow - 1
        }
        let currentSelection = IndexPath(row: currentRow, section: 0)
        favoritesView.collectionView.selectItem(at: currentSelection, animated: true, scrollPosition: .top)
    }
    
    func nextButtonPressed() {
        if currentRow < (radioStations.count - 1) {
            currentRow = currentRow + 1
        } else {
            currentRow = 0
        }
        let currentSelection = IndexPath(row: currentRow, section: 0)
        favoritesView.collectionView.selectItem(at: currentSelection, animated: true, scrollPosition: .top)
    }
}
