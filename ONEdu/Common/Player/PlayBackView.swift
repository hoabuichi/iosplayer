//
//  PlayBackView.swift
//  CustomVideoPlayer
//
//  Created by HOABC
//

import AVFoundation
import UIKit

extension Notification.Name {
    static let PlayerFullScreen = Notification.Name("PlayerFullScreen")
    static let PlayerMinimizeScreen = Notification.Name("PlayerMinimizeScreen")
}

struct PlayerConstant {
    static let icTrack = UIImage(named: "ic_track")
    static let icLive = UIImage(named: "ic_live")
    static let icFull = UIImage(named: "ic_full")
    static let icPrevious = UIImage(named: "ic_previous")
    static let icNext = UIImage(named: "ic_next")
    static let icMinimize = UIImage(named: "ic_minimize")
    static let icPlay = UIImage(named: "ic_play")
    static let icBack = UIImage(named: "ic_back")
    static let icPause = UIImage(named: "ic_pause")
    static let icSeekForward = UIImage(named: "ic_forward")
    static let icSeekBackward = UIImage(named: "ic_rewind")
//    static let urlString = "https://moctobpltc-i.akamaihd.net/hls/live/571329/eight/playlist.m3u8"
    static let urlString = "https://onsportvod.vtvcab.vn/hls/vod/newonsports/video-upload/a543b456-411a-49e9-bf3b-af5d5d324a3f/index.m3u8"
    static let seekDuration: Float64 = 10
}

final class PlayBackView: UIView {
    var closeBtnPressed: (() -> Void)?
    var overlayPressed: (() -> Void)?
    var isLive = false
    
    var sliderBottomAnchor: NSLayoutConstraint?
    var forwardBtnAnchor: NSLayoutConstraint?
    var backwardBtnAnchor: NSLayoutConstraint?
    
    var isFullScreen = false {
        didSet {
            if (isFullScreen == true) {
                fullBtn.setImage(PlayerConstant.icMinimize, for: .normal)
                if UIDevice.current.userInterfaceIdiom == .phone {
                    AppUtility.lockOrientation(.landscape, andRotateTo: .landscapeRight)
                }
            } else {
                fullBtn.setImage(PlayerConstant.icFull, for: .normal)
                if UIDevice.current.userInterfaceIdiom == .phone {
                    AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
                }
            }
            
        }
    }
    
    // MARK: - Outlets
    
    private let closeBtn: UIButton = {
        let button = UIButton()
        button.setImage(PlayerConstant.icBack, for: .normal)
        return button
    }()
    
    private let title: UILabel = {
        let label = UILabel()
        label.text = "Title video: Doremon và bảo bối thần kỳ - Tập 5"
        label.font = AppFont.bold.of(style: .headline)
        label.textColor = .white
        return label
    }()
    
    private let liveIcon: UIImageView = {
        let image = UIImageView()
        image.image = PlayerConstant.icLive
        return image
    }()
    
    private let seekForwardBtn: UIButton = {
        let button = UIButton()
        button.setImage(PlayerConstant.icSeekForward, for: .normal)
        return button
    }()
    
    private let seekBackwardBtn: UIButton = {
        let button = UIButton()
        button.setImage(PlayerConstant.icSeekBackward, for: .normal)
        return button
    }()
    
    private let nextBtn: UIButton = {
        let button = UIButton()
        button.setImage(PlayerConstant.icNext, for: .normal)
        return button
    }()
    
    private let previousBtn: UIButton = {
        let button = UIButton()
        button.setImage(PlayerConstant.icPrevious, for: .normal)
        return button
    }()
    
    private let playPauseButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    private let timeSlider: TimeSlider = {
        let slider = TimeSlider()
        slider.tintColor = .blueLighter
        slider.maximumTrackTintColor = .bkg
        return slider
    }()
    
    private let fullBtn: UIButton = {
        let button = UIButton()
        button.setImage(PlayerConstant.icFull, for: .normal)
        return button
    }()
    
    private let timeRemainingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    override func layoutSubviews() {
        playPauseButton.center(inView: self)
        
        nextBtn.anchor(left: playPauseButton.rightAnchor, paddingLeft: 25)
        nextBtn.centerY(inView: playPauseButton)
        
        previousBtn.anchor(right: playPauseButton.leftAnchor, paddingRight: 25)
        previousBtn.centerY(inView: playPauseButton)
        
        forwardBtnAnchor?.isActive = false
        forwardBtnAnchor = seekForwardBtn.leftAnchor.constraint(equalTo: playPauseButton.rightAnchor, constant: UIScreen.main.bounds.width / 4)
        forwardBtnAnchor?.isActive = true
        seekForwardBtn.centerY(inView: playPauseButton)
        
        backwardBtnAnchor?.isActive = false
        backwardBtnAnchor = seekBackwardBtn.rightAnchor.constraint(equalTo: playPauseButton.leftAnchor, constant: -UIScreen.main.bounds.width / 4)
        backwardBtnAnchor?.isActive = true
        seekBackwardBtn.centerY(inView: playPauseButton)
        
        fullBtn.anchor(right: self.rightAnchor, paddingRight: 16)
        
        sliderBottomAnchor?.isActive = false
        sliderBottomAnchor = fullBtn.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: isFullScreen ? -32 : -16)
        sliderBottomAnchor?.isActive = true
        
        liveIcon.anchor(left: self.leftAnchor, paddingLeft: 16)
        liveIcon.centerY(inView: fullBtn)
        
        timeRemainingLabel.anchor(left: self.leftAnchor, paddingLeft: 16)
        timeRemainingLabel.centerY(inView: fullBtn)
        
        timeSlider.centerY(inView: fullBtn)

        if isLive {
            timeRemainingLabel.isHidden = true
            nextBtn.isHidden = true
            previousBtn.isHidden = true
            seekForwardBtn.isHidden = true
            seekBackwardBtn.isHidden = true
            timeSlider.isHidden = true
        } else {
            liveIcon.isHidden = true
            
            timeSlider.anchor(left: timeRemainingLabel.rightAnchor, right: fullBtn.leftAnchor, paddingLeft: 16, paddingRight: 29)
        }
        
        closeBtn.anchor(top: self.topAnchor, left: self.leftAnchor, paddingTop: 16, paddingLeft: 16)
        
        title.anchor(left: closeBtn.rightAnchor, paddingLeft: 8)
        title.centerY(inView: closeBtn)
    }
    
    // MARK: - Controls & Properties
    
    var pauseAutoHidePlayBackClosure: (() -> Void)?
    private var player: AVPlayer?
    private var isMuted: Bool = false
    private var isVideoFinished: Bool = false
    
    private var statusObserver: NSKeyValueObservation?
    
    // MARK: - Override Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "outputVolume" {
            pauseAutoHidePlayBackClosure?()
        }
    }
    
    // MARK: - Deinit
    
    deinit {
        statusObserver?.invalidate()
        AVAudioSession.sharedInstance().removeObserver(self, forKeyPath: "outputVolume")
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Public Methods
    
    func config(with player: AVPlayer) {
        self.player = player
        addObservers()
    }
    
    // MARK: - Private Methods
    
    private func setup() {
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(overlayOnPress(sender:)))
        addGestureRecognizer(gesture)
        addSubview(liveIcon)
        addSubview(timeRemainingLabel)
        addSubview(playPauseButton)
        addSubview(nextBtn)
        addSubview(previousBtn)
        addSubview(seekForwardBtn)
        addSubview(seekBackwardBtn)
        addSubview(playPauseButton)
        addSubview(timeSlider)
        addSubview(fullBtn)
        addSubview(closeBtn)
        addSubview(title)
        backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        timeSlider.setThumbImage(PlayerConstant.icTrack, for: .normal)
        timeSlider.addTarget(self, action: #selector(timeSliderValueChanged(_:event:)), for: .valueChanged)
        
        let longPress = UILongPressGestureRecognizer(target: timeSlider, action: #selector(timeSlider.tapAndSlide(gesture:)))
        longPress.minimumPressDuration = 0
        timeSlider.addGestureRecognizer(longPress)
        
        timeSlider.valueChange = { [weak self] value in
            guard let player = self?.player else {
                return
            }
            
            if let isLive = self?.isLive, isLive {
                if let items = player.currentItem?.seekableTimeRanges {
                    if(!items.isEmpty) {
                        let range = items[items.count - 1]
                        let timeRange = range.timeRangeValue
                        let startSeconds = CMTimeGetSeconds(timeRange.start)
                        let durationSeconds = CMTimeGetSeconds(timeRange.duration)
                        let result = (startSeconds + durationSeconds)
                        let target = result * Double(value)
                        player.seek(to: CMTime(seconds: target, preferredTimescale: CMTimeScale(1.0))) { complete in
                        }
                    }
                }
            } else {
                guard let duration = player.currentItem?.duration else {
                    return
                }
                
                self?.pauseAutoHidePlayBackClosure?()
                self?.isVideoFinished = false
                
                let target = duration.seconds * Double(value)
                let newTime = CMTime(value: Int64(target * 1000 as Float64), timescale: 1000)
                player.seek(to: newTime, toleranceBefore: CMTime.zero, toleranceAfter: CMTime.zero)
            }
        }
        
        playPauseButton.addTarget(self, action: #selector(playPauseButtonTapped), for: .touchUpInside)
        
        closeBtn.addTarget(self, action: #selector(closeVideo), for: .touchUpInside)
        
        seekForwardBtn.addTarget(self, action: #selector(seekForwardBtnPressed), for: .touchUpInside)
        
        seekBackwardBtn.addTarget(self, action: #selector(seekBackwardPressed), for: .touchUpInside)
        
        fullBtn.addTarget(self, action: #selector(fullBtnPressed), for: .touchUpInside)
        
        title.isHidden = true
        updateTimeLabel(timeRemainingString: "00:00/ ", videoDuration: "00:00")
    }
    
    func toggleFullScreen() {
        isFullScreen = !isFullScreen
        if isFullScreen {
            title.isHidden = false
            NotificationCenter.default.post(name: .PlayerFullScreen, object: nil)
            
            sliderBottomAnchor?.constant = -32
        } else {
            title.isHidden = true
            NotificationCenter.default.post(name: .PlayerMinimizeScreen, object: nil)
            
            sliderBottomAnchor?.constant = -16
        }
        self.layoutIfNeeded()
    }
    
    @objc func fullBtnPressed() {
        toggleFullScreen()
    }
    
    @objc func overlayOnPress(sender : UITapGestureRecognizer) {
        overlayPressed?()
    }
    
    @objc func closeVideo() {
        if isFullScreen {
            toggleFullScreen()
            return
        }
        closeBtnPressed?()
    }
    
    @objc func seekForwardBtnPressed() {
        seekPlayback(isForward: true)
    }
    
    @objc func seekBackwardPressed() {
        seekPlayback(isForward: false)
    }
    
    private func seekPlayback(isForward: Bool) {
        guard let player = player, let duration = player.currentItem?.duration else {
            return
        }
        
        pauseAutoHidePlayBackClosure?()
        isVideoFinished = false

        let currentElapsedTime = player.currentTime().seconds

        var destinationTime = isForward ? (currentElapsedTime + PlayerConstant.seekDuration) : (currentElapsedTime - PlayerConstant.seekDuration)

        if destinationTime < 0 {
            destinationTime = 0
        }

        if destinationTime < duration.seconds {
            let newTime = CMTime(value: Int64(destinationTime * 1000 as Float64), timescale: 1000)
            player.seek(to: newTime)
        }
    }
    
    @objc private func timeSliderValueChanged(_ sender: UISlider, event: UIEvent) {
        if isLive {
            return
        }
        guard let duration = player?.currentItem?.duration else { return }
        let totalSeconds = CMTimeGetSeconds(duration)
        guard !(totalSeconds.isNaN || totalSeconds.isInfinite) else { return }
        let value = Float64(sender.value) * totalSeconds
        let seekTime = CMTime(value: CMTimeValue(value), timescale: 1)
        
        // Seek and scrub video
        if let touchEvent = event.allTouches?.first {
            switch touchEvent.phase {
            case .began:
                pauseVideo()
            case .moved:
                player?.seek(to: seekTime, toleranceBefore: .zero, toleranceAfter: .zero)
            case .ended:
                playVideo()
                isVideoFinished = false
            default:
                break
            }
        }
        
        // Update time remaining label
        let timeRemaining = duration - seekTime
        guard let timeRemainingString = timeRemaining.getTimeString() else { return }
        guard let videoDuration = duration.getTimeString() else { return }
        
        updateTimeLabel(timeRemainingString: timeRemainingString, videoDuration: videoDuration)
        
        // Delay auto hide playback
        pauseAutoHidePlayBackClosure?()
    }
    
    func updateTimeLabel(timeRemainingString: String, videoDuration: String) {
        let normalAttrs = [NSAttributedString.Key.font : AppFont.regular.of(style: .smallText)]
        let normalText = "\(timeRemainingString)/ "
        let attributedString = NSMutableAttributedString(string:normalText, attributes: normalAttrs)
        
        let attrs = [NSAttributedString.Key.font : AppFont.semiBold.of(style: .smallText)]
        let boldText = NSMutableAttributedString(string:videoDuration, attributes:attrs)
        attributedString.append(boldText)
        timeRemainingLabel.attributedText = attributedString
    }
    
    @objc func playPauseButtonTapped(_ sender: Any) {
        guard let player = player else { return }
        if player.isPlaying {
            pauseVideo()
        } else {
            if isVideoFinished {
                replayVideo()
            } else {
                playVideo()
            }
        }
        pauseAutoHidePlayBackClosure?()
    }
}

// MARK: - Play, Pause, Replay Video

extension PlayBackView {
    func playVideo() {
        player?.play()
        playPauseButton.setImage(PlayerConstant.icPause, for: .normal)
    }
    
    func pauseVideo() {
        player?.pause()
        playPauseButton.setImage(PlayerConstant.icPlay, for: .normal)
    }
    
    func replayVideo() {
        isVideoFinished = false
        player?.seek(to: CMTime.zero, completionHandler: { [weak self] isFinished in
            self?.player?.play()
        })
        playPauseButton.setImage(PlayerConstant.icPause, for: .normal)
    }
}

// MARK: - Observers

private extension PlayBackView {
    func addObservers() {
        // Observer player's status
        addPlayerStatusObserver()
        
        // Detect volume output
        AVAudioSession.sharedInstance().addObserver(self, forKeyPath: "outputVolume", options: .new, context: nil)
        
        addTimeObserver()
        addNotificationObserver()
    }
    
    func addPlayerStatusObserver() {
        statusObserver = player?.observe(\.status, options: .new) { [weak self] currentPlayer, _ in
            guard let self = self else { return }
            if currentPlayer.status == .readyToPlay {
                self.playPauseButton.setImage(PlayerConstant.icPause, for: .normal)
            }
        }
    }
    
    func addTimeObserver() {
        let interval = CMTime(value: 1, timescale: 2)
        player?.addPeriodicTimeObserver(forInterval: interval, queue: .main, using: { [weak self] progressTime in
            self?.updateVideoPlayerState(progressTime: progressTime)
//            let playbackType = self?.player?.currentItem?.accessLog()?.events.last?.playbackType!
//                print("Playback Type: \(playbackType ?? "NA")")
        })
    }
    
    func updateVideoPlayerState(progressTime: CMTime) {
        // Update time slider's value
        if isLive {
            return
        }
        guard let duration = player?.currentItem?.duration else { return }
        timeSlider.value = Float(progressTime.seconds / duration.seconds)

        // Update time remaining label
        let timeRemaining = duration - progressTime
        guard let timeRemainingString = timeRemaining.getTimeString() else { return }
        guard let videoDuration = duration.getTimeString() else { return }
        updateTimeLabel(timeRemainingString: timeRemainingString, videoDuration: videoDuration)
    }
    
    func addNotificationObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didEnterBackground(_:)),
                                               name: UIApplication.didEnterBackgroundNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(playerDidFinishPlaying),
                                               name: .AVPlayerItemDidPlayToEndTime,
                                               object: nil)
    }
    
    @objc func didEnterBackground(_: Notification) {
        player?.pause()
        playPauseButton.setImage(PlayerConstant.icPlay, for: .normal)
    }
    
    @objc func playerDidFinishPlaying() {
        isVideoFinished = true
        playPauseButton.setImage(PlayerConstant.icPlay, for: .normal)
    }
}
