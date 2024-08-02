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
        updateButtonImage(isPlay: true)
    }
    
    func selectStation(at position: Int) {
        popularView.popularCollectionView.selectItem(at: IndexPath(item: position, section: 0), animated: true, scrollPosition: .top)
    }
    
    func updateButtonImage(isPlay: Bool) {
        let image = isPlay ? UIImage(named: "playButton") : UIImage(named: "pause")
        popularView.playPauseButton.setBackgroundImage(image, for: .normal)
    }
}


// MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension PopularViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularCell.identifier, for: indexPath) as? PopularCell else { return UICollectionViewCell() }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}


extension PopularViewController: PopularViewDelegate {
    func didSlideSlider(_ value: Float) {
        
    }
    
    func playButtonPressed() {
        
    }
    
    func backButtonPressed() {
        
    }
    
    func nextButtonPressed() {

    }
}

    
