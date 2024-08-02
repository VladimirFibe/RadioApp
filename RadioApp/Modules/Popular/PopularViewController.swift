//
//  PopularViewController.swift
//  RadioApp
//
//  Created by Елена Логинова on 02.08.2024.
//

import UIKit

final class PopularViewController: UIViewController {
    
    private let popularView = PopularView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        view = popularView
        popularView.setDelegate(viewController: self)
        popularView.delegate = self
    }
}


// MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension PopularViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)

    }
}


extension PopularViewController: PopularViewDelegate {
    func didSlideSlider(_ value: Float) {
        //radioPlayer.volume = value
    }
    
    func playButtonPressed() {

    }
    
    func backButtonPressed() {

    }
    
    func nextButtonPressed() {
    }
}


    
