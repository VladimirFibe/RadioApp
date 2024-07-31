//
//  FavoritesViewController.swift
//  RadioApp
//
//  Created by Елена Логинова on 31.07.2024.
//

import UIKit

final class FavoritesViewController: UIViewController {
    
    var currentRow = Int()
    private let favoritesView = FavoritesView()

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
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
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
        
    }
    
    func backButtonPressed() {

    }
    
    func nextButtonPressed() {

    }
}
