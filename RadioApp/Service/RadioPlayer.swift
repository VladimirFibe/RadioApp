//
//  RadioPlayer.swift
//  RadioApp
//
//  Created by Елена Логинова on 02.08.2024.
//

import Foundation
import AVFoundation

protocol RadioPlayerDelegate: AnyObject {
    func changePlayButton(isPlaying: Bool)
    func changeCurrentURL(_ url: String)
}

class RadioPlayer {

    static let shared = RadioPlayer()

    weak var viewController: FavoritesViewController?
    weak var delegate: RadioPlayerDelegate?
    private var player: AVPlayer?
    private var playerItem: AVPlayerItem?
    private var currentURL: String?
    var volume: Float? {
        get {
            return player?.volume
        } set {
            guard
                let newValue = newValue,
                0.0...1.0 ~= newValue else { return }
            player?.volume = newValue
        }
    }
    private var currentIndex: Int = 0
    private var radioStation: [RadioStation] = []

    func configurePlayer(from radio: RadioStation) {
        guard let radioURL = URL(string: radio.url_resolved) else { return print("Error with URL Radio Station") }

        playerItem = AVPlayerItem(url: radioURL)
        player = AVPlayer(playerItem: playerItem)
        player?.volume = 0.5
        player?.play()
        currentURL = radio.url_resolved
        delegate?.changePlayButton(isPlaying: true)
        delegate?.changeCurrentURL(radio.url_resolved)
        viewController?.updateButtonImage(isPlay: true)
    }
    
    func playMusicWithURL(_ radio: RadioStation) {
        if isPlayingMusic(from: radio.url_resolved) {
            pauseMusic()
        } else {
            configurePlayer(from: radio)
            currentURL = radio.url_resolved
        }
    }

    func playMusic() {
        player?.play()
        delegate?.changePlayButton(isPlaying: true)
        viewController?.updateButtonImage(isPlay: true)
    }

    func pauseMusic() {
        player?.pause()
        delegate?.changePlayButton(isPlaying: false)
        viewController?.updateButtonImage(isPlay: false)
    }

    func stopMusic() {
        player?.pause()
        player = nil
        currentURL = nil
        delegate?.changePlayButton(isPlaying: false)
        delegate?.changeCurrentURL("")
    }

    func isPlayingMusic(from url: String) -> Bool {
        return currentURL == url && player?.rate != 0 && player?.error == nil
    }

    func isPlayerPerforming() -> Bool {
        return player?.timeControlStatus == .playing ? true : false
    }

    func playNextRadio() {
//        currentIndex += 1
//        if currentIndex >= radioStation.count {
//            currentIndex = 0
//        }
//        let nextRadioStation = radioStation[currentIndex]
//        configurePlayer(from: nextRadioStation)
    }

    func playPreviousRadio() {
//        currentIndex -= 1
//        if currentIndex >= radioStation.count {
//            currentIndex = 0
//        }
//        let nextRadioStation = radioStation[currentIndex]
//        configurePlayer(from: nextRadioStation)
    }
}

extension RadioPlayer: RadioPlayerDelegate {
    func changePlayButton(isPlaying: Bool) {
        delegate?.changePlayButton(isPlaying: isPlaying)
    }

    func changeCurrentURL(_ url: String) {
        delegate?.changeCurrentURL(url)
    }
}
