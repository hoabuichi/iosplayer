//
//  VideoPlayer.swift
//  CustomVideoPlayer
//
//  Created by HOABC
//

import UIKit
import AVFoundation

final class VideoPlayer: UIView {
    // MARK: - Outlets
    
    private let videoView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    private let playBackView: PlayBackView = {
        let playerView = PlayBackView()
        return playerView
    }()
    
    // MARK: - Properties
    
    private var player: AVPlayer!
    private var playerLayer: AVPlayerLayer!
    private var isShowPlayBack = true
    private var playerTimer: Timer?
    
    var dismissClosure: (() -> Void)?
    
    // MARK: - Override Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        config()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
        config()
    }
    
    // MARK: - Public Methods
    
    func playVideo(with urlString: String, isLive: Bool) {
        guard let url = URL(string: urlString) else { return }
        let playerItem = AVPlayerItem(url: url)
        player?.replaceCurrentItem(with: playerItem)
        playBackView.isLive = isLive
        playBackView.playVideo()
    }
    
    func updateLayoutSubviews() {
        layoutIfNeeded()
        playerLayer.frame = videoView.bounds
    }
    
    // MARK: - Private Methods
    
    private func commonInit() {        
        self.addSubview(videoView)
        self.addSubview(playBackView)
        
        videoView.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor)
        
        playBackView.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor)
    }
    
    private func config() {
        // Tap gesture
        let controlTapGesture = UITapGestureRecognizer(target: self, action: #selector(playerViewHandleTap))
        self.addGestureRecognizer(controlTapGesture)
        
        setupPlayer()
        
        playBackView.config(with: player)
        playBackView.pauseAutoHidePlayBackClosure = { [weak self] in
            self?.resetTimer()
        }
        
        playBackView.closeBtnPressed = { [weak self] in
            self?.dismissClosure?()
            self?.playerTimer?.invalidate()
        }
        
        playBackView.overlayPressed = { [weak self] in
            self?.showHidePlayBackView()
        }
        
        startTimer()
    }
    
    private func setupPlayer() {
        player = AVPlayer()
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = videoView.bounds
        playerLayer.videoGravity = .resizeAspect
        videoView.layer.addSublayer(playerLayer)
    }
    
    @objc private func playerViewHandleTap(_ gestureRecognizer: UITapGestureRecognizer) {
        showHidePlayBackView()
    }
}

// MARK: - Show / Hide PlayBack

private extension VideoPlayer {
    func startTimer() {
        playerTimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(autoHidePlayBack), userInfo: nil, repeats: false)
    }
    
    func resetTimer() {
        playerTimer?.invalidate()
        startTimer()
    }
    
    @objc func autoHidePlayBack() {
        if isShowPlayBack {
            showHidePlayBackView()
        }
    }
    
    func showHidePlayBackView() {
        isShowPlayBack = !isShowPlayBack
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            guard let self = self else { return }
            self.playBackView.alpha = !self.isShowPlayBack ? 0 : 1
        })
        if isShowPlayBack {
            resetTimer()
        }
    }
}
