////
////  BasePlayer.swift
////  ONSports
////
////  Created by Steve on 05/07/2021.
////
//
//import UIKit
//import DolphinPlayerONSports
//import Player
//import AVFoundation
//import GoogleInteractiveMediaAds
//import WebKit
//import AVKit
//class BasePlayer: UIView {
//    @IBOutlet fileprivate weak var contentView: UIView!
//    @IBOutlet public weak var vDenied: UIView!
//    @IBOutlet public weak var vErrorVideo: UIView!
//    @IBOutlet public weak var vOverlay: UIView!
//    @IBOutlet fileprivate weak var timeSlider: TimeSlider!
//    @IBOutlet fileprivate weak var brightnessSlider: UISlider!
//    @IBOutlet fileprivate weak var timeStack: UIStackView!
//    @IBOutlet fileprivate weak var lbCurrentTime: UILabel!
//    @IBOutlet fileprivate weak var lbTotalTime: UILabel!
//    @IBOutlet fileprivate weak var btnFull: UIButton!
//    @IBOutlet fileprivate weak var btnPlayPause: UIButton!
//    @IBOutlet fileprivate weak var btnNext: UIButton!
//    @IBOutlet fileprivate weak var btnPrev: UIButton!
//    @IBOutlet public weak var activityIndicator: UIActivityIndicatorView!
//    @IBOutlet fileprivate weak var sliderBottomContraint: NSLayoutConstraint!
//    @IBOutlet fileprivate weak var contentBottomContraint: NSLayoutConstraint!
//    @IBOutlet fileprivate weak var fullRightContraint: NSLayoutConstraint!
//    @IBOutlet fileprivate weak var sliderLeadingContraint: NSLayoutConstraint!
//    @IBOutlet fileprivate weak var sliderTrailingContraint: NSLayoutConstraint!
//    @IBOutlet weak var btnBack: UIButton!
//    @IBOutlet weak var lbTitle: UILabel!
//    @IBOutlet fileprivate weak var imvLive: UIImageView!
//    @IBOutlet fileprivate weak var stackLive: UIStackView!
//    @IBOutlet fileprivate weak var btnSeekToLive: UIButton!
//    @IBOutlet weak var btnBackWhenError: UIButton!
//    @IBOutlet weak var btnShare: UIButton!
//
//    var model = VODDetailModel()
//    var countLink: Int = 0
//    var countOnline: Int = 0
//    var isVisible = true
//    var isStarted = false
//    var vc: UIViewController? = nil
//    var contentPlayhead: IMAAVPlayerContentPlayhead?
//    var adsLoader: IMAAdsLoader!
//    var adsManager: IMAAdsManager!
//    var onDestroy = false
//
//    @IBAction func onShare(_ sender: UIButton) {
//        NotificationCenter.default.post(name: Notification.Name("ShareVideo"), object: nil)
//    }
//    private let skipAdsLabel: UILabel = {
//        let label = UILabel()
//        label.text = ""
//        label.textColor = .white
//        label.font = AppFont.regular.of(style: .caption1)
//        return label
//    }()
//
//    private let skipAdsIcon: UIImageView = {
//        let image = UIImageView()
//        image.image = UIImage(named: "skipAds")
//        return image
//    }()
//
//    private lazy var skipAdsButton: UIButton = {
//        let button = UIButton(type: .system)
//        return button
//    }()
//
//    private let skipView: UIView = {
//        let uiView = UIView()
//        uiView.backgroundColor = UIColor.bkgDark.withAlphaComponent(0.6)
//
//        return uiView
//    }()
//
//    @IBAction func btnTryAgain(_ sender: UIButton) {
//        onTryRunVideo()
//    }
//
//    @IBAction func onBackError(_ sender: UIButton) {
//        onBackAction()
//    }
//
//    @IBAction func brightnessChange(_ sender: UISlider) {
//        print(sender.value)
//        UIScreen.main.brightness = CGFloat(sender.value)
//    }
//
//    let goHomeAttributes: [NSAttributedString.Key: Any] = [
//        .font: AppFont.regular.of(style: .caption1),
//        .foregroundColor: UIColor.blue,
//        .underlineStyle: NSUnderlineStyle.single.rawValue
//    ]
//
//    let screenRecordingProtector = ScreenRecordingProtector()
//
//    var cacheTime: Float64 = -1.0
//    var countTime: Int = 0
//    var countCurrentTime: Int = 0
//    var isAddingObserver: Bool = false
//    fileprivate var totalTime: TimeInterval!
//    var timerAutoHideOverlay: Timer?
//    var timer: Timer?
//    var timerAds: Timer?
//    fileprivate var isSliderSliding = false
//    var isVod: Bool = true {
//        willSet {
//            if (!activityIndicator.isAnimating) {
//                if (isShowOverlay && isVod != newValue) {
//                    isShowOverlay = false
//                }
//            }
//        }
//    }
//
//    var changeModeView: ((Bool)->Void)?
//    var backAction:(() -> Void)?
//
//    func showHideControls() {
//        self.btnBack.isHidden = !self.isShowOverlay
//        self.btnFull.isHidden = !self.isShowOverlay
//        self.btnShare.isHidden = !self.isShowOverlay
//        self.btnPlayPause.isHidden = !self.isShowOverlay
//        self.timeSlider.isHidden = !self.isShowOverlay
//
//        if (isVod) {
//            self.btnNext.isHidden = !self.isShowOverlay
//            self.btnPrev.isHidden = !self.isShowOverlay
//            self.timeStack.isHidden = !self.isShowOverlay
//            self.stackLive.isHidden = true
//            self.btnSeekToLive.isHidden = true
//        } else {
//            self.btnNext.isHidden = true
//            self.btnPrev.isHidden = true
//            self.timeStack.isHidden = true
//        }
//        if (self.isFullScreen) {
//            self.lbTitle.isHidden = !self.isShowOverlay
//            self.brightnessSlider.isHidden = !self.isShowOverlay
//        } else {
//            self.lbTitle.isHidden = true
//            self.brightnessSlider.isHidden = true
//        }
//    }
//
//    var isFullScreen = false {
//        didSet {
//            if (isFullScreen == true) {
//                btnFull.setImage(UIImage(named: "ic_small"), for: .normal)
//                sliderBottomContraint.constant = 50
//                sliderLeadingContraint.constant = 20
//                sliderTrailingContraint.constant = 30
//                fullRightContraint.constant = 22
//                contentBottomContraint.constant = 0
//                if UIDevice.current.userInterfaceIdiom == .phone {
//                    AppUtility.lockOrientation(.landscape, andRotateTo: .landscapeRight)
//                }
//                lbTitle.isHidden = false
//                brightnessSlider.isHidden = false
//                NotificationCenter.default.post(name: Notification.Name("fullscreenon"), object: nil)
//            } else {
//                btnFull.setImage(UIImage(named: "ic_full"), for: .normal)
//                sliderBottomContraint.constant = -8
//                sliderLeadingContraint.constant = 0
//                sliderTrailingContraint.constant = 0
//                fullRightContraint.constant = 10
//                contentBottomContraint.constant = 8
//                if UIDevice.current.userInterfaceIdiom == .phone {
//                    AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
//                }
//                lbTitle.isHidden = true
//                brightnessSlider.isHidden = true
//            }
//            btnFull.setNeedsUpdateConstraints()
//            timeSlider.setNeedsUpdateConstraints()
//            contentView.setNeedsUpdateConstraints()
//            updateFramePlayer()
//            if let callback = self.changeModeView {
//                callback(isFullScreen)
//            }
//            isShowOverlay = false
//        }
//    }
//
//    public var isShowOverlay = false {
//        willSet {
//            if newValue {
//                vOverlay.backgroundColor = .bkgDark.withAlphaComponent(0.4)
//                timerAutoHideOverlay?.invalidate()
//                timerAutoHideOverlay = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(hideOverlay), userInfo: nil, repeats: false)
//            }
//            else {
//                vOverlay.backgroundColor = .clear
//            }
//        }
//        didSet {
//            showHideControls()
//        }
//    }
//
//    var player: DolphinPlayer!
//    var isPlaying = true {
//        didSet {
//            DispatchQueue.main.async {
//                if self.isPlaying {
//                    self.btnPlayPause.setImage(UIImage(named: "ic_pause"), for: .normal)
//                } else {
//                    self.btnPlayPause.setImage(UIImage(named: "ic_play"), for: .normal)
//                }
//            }
//        }
//    }
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        commonInit()
//    }
//
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        commonInit()
//    }
//
//    func commonInit() {
//        addNibView(from: BasePlayer.self)
//
//        overlayConfig()
//        sliderConfig()
//
//        screenRecordingProtector.callback = { isCapture in
//            self.vDenied?.isHidden = isCapture
//        }
//        screenRecordingProtector.startPreventing()
//
//        try! AVAudioSession.sharedInstance().setCategory(.playback, options: [])
//
//        NotificationCenter.default.addObserver(self, selector: #selector(goOnline), name: Notification.Name(NETWORK_ONLINE), object: nil)
//
//        NotificationCenter.default.addObserver(self, selector: #selector(goOffline), name: Notification.Name(NETWORK_OFFLINE), object: nil)
//
//        NotificationCenter.default.addObserver(self, selector: #selector(onNewPlayer), name: Notification.Name("NewPlayerComming"), object: nil)
//    }
//
//    deinit {
//        guard let playerLayer = player.playerLayer(), let player = playerLayer.player else {
//            return
//        }
//        if isAddingObserver {
//            player.removeObserver(self, forKeyPath: "timeControlStatus")
//            isAddingObserver = false
//        }
//        NotificationCenter.default.removeObserver(self)
//        vOverlay.removeObserver(self, forKeyPath: "hidden")
//    }
//
//    @objc func onNewPlayer() {
//        NotificationCenter.default.removeObserver(self)
//    }
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        updateFramePlayer()
//    }
//
//    override func awakeFromNib() {
//        super.awakeFromNib()
//    }
//
//    // MARK: - Play Video Func
//
//    func playVideoWithUrl(url: String, isProtected: Bool) {
//        isStarted = false
//        self.activityIndicator.startAnimating()
//        if model.isProtected {
//            self.validateSignKey(completed:{ [weak self] status in
//                guard let `self` = self else {
//                    return
//                }
//                switch status {
//                case .ReadyToPlay:
//                    if let signkey = UserDefaults.standard.string(forKey: SIGNKEY_VALUE_KEY) {
//                        print("sign key: \(signkey)")
//                        self.player.setDataSourceUsingPOST(urlString: url, signKey: signkey)
//                        if self.model.skipAds {
//                            self.play()
//                        } else {
//                            if self.model.active {
//                                if self.model.type == .vod || self.model.status == .live {
//                                    self.requestAds()
//                                }
//                            }
//                        }
//                    }
//                    break
//                default:
//                    break
//                }
//            })
//        } else {
//            if let player = self.player {
//                player.setDataSource(urlString: url)
//                if self.model.skipAds {
//                    self.play()
//                } else {
//                    if self.model.active {
//                        if self.model.type == .vod || self.model.status == .live {
//                            self.requestAds()
//                        }
//                    }
//                }
//            }
//        }
//    }
//
//    // MARK: Set up your content playhead and contentComplete callback.
//
//    func setContentPlayHead() {
//        if let avPlayer = getAVPlayer() {
//            contentPlayhead = IMAAVPlayerContentPlayhead(avPlayer: avPlayer)
//            NotificationCenter.default.addObserver(
//             self,
//             selector: #selector(contentDidFinishPlaying(_:)),
//             name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
//             object: avPlayer.currentItem);
//        }
//    }
//
//    @objc func contentDidFinishPlaying(_ notification: Notification) {
//        if (notification.object as! AVPlayerItem) == getAVPlayer()?.currentItem {
//            adsLoader.contentComplete()
//        }
//    }
//
//    func setUpAdsLoader() {
//        adsLoader = IMAAdsLoader(settings: nil)
//        adsLoader.delegate = self
//    }
//
//    func buildURLTag() -> String {
//        let bundleId = Bundle.main.bundleIdentifier ?? ""
//        var urlTag = "https://search.spotxchange.com/vast/2.0/323774?VPI[]=MP4&player_width=640&player_height=360&app[bundle]=\(bundleId)&media_transcoding=low&omidpn=Google&omidpv=1"
//        if let deviceIDFA = userDefaults.string(forKey: DEVICE_IDFA) {
//            urlTag = urlTag + "&device[ifa]=\(deviceIDFA)"
//        }
//
////        let appStoreUrl = "https://apps.apple.com/us/app/on-sports-tv-tr%E1%BB%B1c-ti%E1%BA%BFp-b%C3%B3ng-%C4%91%C3%A1/id1282845933"
////        let userAgent = WKWebView().value(forKey: "userAgent") as? String ?? ""
////        print("address: \(Utils.getIPAddress())")
//
//        return urlTag
//    }
//
//    func requestAds() {
//       // Create ad display container for ad rendering.
//        let adDisplayContainer = IMAAdDisplayContainer(adContainer: self, viewController: self.vc)
//       // Create an ad request with our ad tag, display container, and optional user context.
//        print("URL Tag: \(buildURLTag())")
//       let request = IMAAdsRequest(
//           adTagUrl: buildURLTag(),
//           adDisplayContainer: adDisplayContainer,
//           contentPlayhead: contentPlayhead,
//           userContext: nil)
//
//       adsLoader.requestAds(with: request)
//     }
//
//    func configPlayer(url: String, isProtected: Bool, title: String, isVod: Bool) {
//        vOverlay.isHidden = false
//        self.isVod = isVod
//        lbTitle.text = title
//        destroy()
//        player = DolphinPlayer(enableDRM: isProtected)
//        player.playerView.playerBackgroundColor = .black
//        player.autoplay = false
//        updateFramePlayer()
//        contentView.addSubview(player.view)
//        stackLive.isHidden = true
//        btnSeekToLive.isHidden = true
//
//        player.playerDelegate = self
//        player.playbackDelegate = self
//
//        vErrorVideo.isHidden = true
//        vDenied.isHidden = true
//        setContentPlayHead()
//        setUpAdsLoader()
//        playVideoWithUrl(url: url, isProtected: isProtected)
//
//        if #available(iOS 13.0, *) {
//            NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: UIScene.willEnterForegroundNotification, object: nil)
//
//            NotificationCenter.default.addObserver(self, selector: #selector(appMovedToBackground), name: UIScene.didEnterBackgroundNotification, object: nil)
//        } else {
//            // Fallback on earlier versions
//            NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
//            NotificationCenter.default.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
//        }
//
//        NotificationCenter.default.addObserver(self, selector: #selector(appDidBecomeActiveHandler), name: UIApplication.didBecomeActiveNotification, object: nil)
//
//        NotificationCenter.default.addObserver(self, selector: #selector(brightnessDidChange), name: UIScreen.brightnessDidChangeNotification, object: nil)
//
//        player.playerLayer()?.player?.addObserver(self, forKeyPath: "timeControlStatus", options: [.old, .new], context: nil)
//        isAddingObserver = true
//        NotificationCenter.default.addObserver(self, selector: #selector(playerItemFailedToPlay(_:)), name: NSNotification.Name.AVPlayerItemFailedToPlayToEndTime, object: nil)
//        isFullScreen = false
//        play()
//        if !self.model.skipAds {
//            pause()
//        }
//
//        setupTimer()
//    }
//
//    @objc func appDidBecomeActiveHandler(){
//        if onDestroy {
//            return
//        }
//        if isVisible && !model.skipAds {
//            resumeAds()
//        }
//    }
//
//
//    @objc func brightnessDidChange() {
//        brightnessSlider.setValue(Float(UIScreen.main.brightness), animated: true)
//    }
//
//    @objc func playerItemFailedToPlay(_ notification: Notification) {
//        print(notification)
//        guard let error = notification.userInfo?[AVPlayerItemFailedToPlayToEndTimeErrorKey] as? Error, let msg = error.localizedDescription as? String else {
//            return
//        }
//        print("app \(msg)")
//    }
//
//    var cacheMode = true
//    @objc func willEnterForeground() {
////        isFullScreen = false
//        if (cacheMode) {
//            play()
//        } else {
//            pause()
//        }
//    }
//
//    @objc func appMovedToBackground() {
//        cacheMode = isPlaying
//    }
//
//    func updateFramePlayer() {
//        if (player != nil) {
//            print("update frame")
//            if (isFullScreen) {
//                player.view.frame = self.contentView.bounds
//            } else {
//                let masterWith = self.bounds.width
//                let masterHeight = masterWith * 9/16
//                player.view.frame = CGRect(x: 0, y: 0, width: masterWith, height: masterHeight)
//            }
//            player.view.setNeedsLayout()
//            player.view.layoutIfNeeded()
//        }
//
//    }
//
//    override public func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
//        if keyPath == "timeControlStatus", let change = change, let newValue = change[NSKeyValueChangeKey.newKey] as? Int, let oldValue = change[NSKeyValueChangeKey.oldKey] as? Int {
//            if #available(iOS 10.0, *) {
//                let oldStatus = AVPlayer.TimeControlStatus(rawValue: oldValue)
//                let newStatus = AVPlayer.TimeControlStatus(rawValue: newValue)
//                if newStatus != oldStatus {
//                    DispatchQueue.main.async {[weak self] in
//                        guard let `self` = self else {
//                            return
//                        }
//                        if newStatus == .playing || newStatus == .paused {
//                            self.isStarted = true
//                            self.activityIndicator.stopAnimating()
//                        } else {
//                            self.activityIndicator.startAnimating()
//                            self.isShowOverlay = false
//                        }
//                        if (self.activityIndicator.isAnimating) {
//                            self.btnNext.isHidden = true
//                            self.btnPrev.isHidden = true
//                            self.btnPlayPause.isHidden = true
//                        } else {
//                            self.isShowOverlay = true
//                        }
//
//                    }
//                }
//            } else {
//                // Fallback on earlier versions
//                self.activityIndicator.stopAnimating()
//            }
//            guard let layer = player.playerLayer(), let avplayer = layer.player else {
//                return
//            }
//            switch avplayer.timeControlStatus {
//            case .paused:
//                isPlaying = false
//            case .playing:
//                isPlaying = true
//            case .waitingToPlayAtSpecifiedRate:
//                print("waitingToPlayAtSpecifiedRate")
//            default:
//                print("unknow status")
//            }
//        }
//        if (keyPath == "hidden") {
//            if (vOverlay.isEqual(object)) {
//            }
//        }
//    }
//
//    public func destroy() {
//        if ((player) != nil) {
//            print("player destroy")
//            if isAddingObserver {
//                player.playerLayer()?.player?.removeObserver(self, forKeyPath: "timeControlStatus")
//                isAddingObserver = false
//            }
//            pause()
//            player.stop()
//            player.playerLayer()?.player?.replaceCurrentItem(with: nil)
//        }
//    }
//}
//
//
////MARK: - Switch links
//extension BasePlayer {
//    func onTryRunVideo() {
//        destroy()
//        if !NetworkMonitor.shared.isConnected {
//            return
//        }
//        self.activityIndicator.startAnimating()
//        countLink = 0
//        vErrorVideo.isHidden = true
//        playVideoWithUrl(url: model.url, isProtected: model.isProtected)
//    }
//
//    func showErrorUI() {
//        countLink = 0
//        activityIndicator.stopAnimating()
////        isShowOverlay = false
////        layoutSubviews()
//        vOverlay.isHidden = true
//        vErrorVideo.isHidden = false
//    }
//
//    func onVideoFailed() {
//        if countLink == model.linkPreventive.count {
//            showErrorUI()
//            return
//        }
//        print("Baseplayer switchlink index: \(countLink)")
//        print("Baseplayer switchlink link: \(model.linkPreventive[countLink])")
//
//        playVideoWithUrl(url: model.linkPreventive[countLink], isProtected: model.isProtected)
//        countLink = countLink + 1
//    }
//
//    func onVideoSuccess() {
//        self.activityIndicator.stopAnimating()
//        countLink = 0
//    }
//
//    @objc func goOnline() {
//        if isVisible {
//            onTryRunVideo()
//        }
//    }
//
//    @objc func goOffline() {
//        destroy()
//        showErrorUI()
//    }
//}
//
//// Overlay
//extension BasePlayer {
//    func overlayConfig() {
//        isShowOverlay = true
//        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.overlayOnPress(sender:)))
//        vOverlay.addGestureRecognizer(gesture)
//
//        btnBackWhenError.setTitle("", for: .normal)
//        btnBackWhenError.setImage(UIImage(named: "ic_back"), for: .normal)
//        btnBackWhenError.backgroundColor = .clear
//        btnBackWhenError.tintColor = .white
//
//        btnShare.setTitle("", for: .normal)
//        btnShare.setImage(UIImage(named: "share-icon"), for: .normal)
//        btnShare.backgroundColor = .clear
//        btnShare.tintColor = .white
//
//        lbTotalTime.text = ""
//        lbTotalTime.font =  AppFont.regular.of(style: .caption2)
//        lbTotalTime.textColor = .white
//
//        lbCurrentTime.text = ""
//        lbCurrentTime.font =  AppFont.regular.of(style: .caption2)
//        lbCurrentTime.textColor = .white
//        brightnessSlider.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi/2))
//        brightnessSlider.minimumTrackTintColor = .white87
//        brightnessSlider.maximumTrackTintColor = .white38
//        brightnessSlider.setValue(Float(UIScreen.main.brightness), animated: true)
//        brightnessSlider.setThumbImage(UIImage(), for: .normal)
//        vDenied.isHidden = true
//        vErrorVideo.isHidden = true
//        imvLive.layer.cornerRadius = 4
//
//        self.btnNext.isHidden = true
//        self.btnPrev.isHidden = true
//
//        vOverlay.addObserver(self, forKeyPath: "hidden", options:  [.old, .new], context: nil)
//
//    }
//
//    func sliderConfig() {
//        timeSlider.setThumbImage(UIImage(named: "ic_thumb"), for: .normal)
//        timeSlider.maximumTrackTintColor = .white.withAlphaComponent(0.6)
//        timeSlider.minimumTrackTintColor = .redError
//
//        timeSlider.addTarget(self, action: #selector(progressSliderTouchBegan(_:)),
//                             for: .touchDown)
//
//        timeSlider.addTarget(self, action: #selector(progressSliderValueChanged(_:)),
//                             for: .valueChanged)
//
//        timeSlider.addTarget(self, action: #selector(progressSliderTouchEnded(_:)),
//                             for: [.touchUpInside,.touchCancel, .touchUpOutside])
//        let longPress                  = UILongPressGestureRecognizer(target: timeSlider, action: #selector(timeSlider.tapAndSlide(gesture:)))
//        longPress.minimumPressDuration = 0
//        timeSlider.addGestureRecognizer(longPress)
//        // seek
//        timeSlider.valueChange = { value in
//            self.isShowOverlay = true
//            if self.isVod {
//                if self.totalTime != nil {
//                    let target = self.totalTime * Double(value)
//                    self.playTimeDidChange(currentTime: target, totalTime: self.totalTime)
//                    guard let avPlayer = self.getAVPlayer() else {
//                        return
//                    }
//                    avPlayer.seek(to: CMTime(seconds: target, preferredTimescale: CMTimeScale(1.0))) { complete in
//                        self.isSliderSliding = false
//                    }
//                }
//                else {
//                    self.timeSlider.value = 1
//                }
//            } else {
//                //====== END HEAD
//                guard let avPlayer = self.getAVPlayer() else {
//                    return
//                }
//                if let items = avPlayer.currentItem?.seekableTimeRanges {
//
//                    if(!items.isEmpty) {
//                        let range = items[items.count - 1]
//                        let timeRange = range.timeRangeValue
//                        let startSeconds = CMTimeGetSeconds(timeRange.start)
//                        let durationSeconds = CMTimeGetSeconds(timeRange.duration)
//                        let result = (startSeconds + durationSeconds)
//                        let target = result * Double(value)
//                        avPlayer.seek(to: CMTime(seconds: target, preferredTimescale: CMTimeScale(1.0))) { complete in
////                            avPlayer.play()
//                            self.isSliderSliding = false
//                        }
//                    }
//                }
//                //====== END HEAD
//            }
//        }
//    }
//
//
//    @objc func overlayOnPress(sender : UITapGestureRecognizer) {
//        isShowOverlay = !isShowOverlay
//    }
//
//    @objc func hideOverlay() {
//        isShowOverlay = false
//        timerAutoHideOverlay?.invalidate()
//    }
//
//    func playTimeDidChange(currentTime: TimeInterval, totalTime: TimeInterval) {
//        timeSlider.value = Float(currentTime) / Float(totalTime)
//        self.totalTime = totalTime
//        lbTotalTime.text = "/\(Utils.formatSecondsToString(totalTime))"
//        lbCurrentTime.text = "\(Utils.formatSecondsToString(currentTime))"
//    }
//
//    func showSeekToView(to toSecound: TimeInterval, total totalDuration:TimeInterval, isAdd: Bool) {
//        timeSlider.value = Float(toSecound / totalDuration)
//    }
//}
//
//// Slider
//extension BasePlayer {
//    @objc func progressSliderTouchBegan(_ sender: UISlider)  {
//        print("progressSliderTouchBegan")
//        handleSlide(slider: sender, event: .touchDown)
//    }
//
//    @objc func progressSliderValueChanged(_ sender: UISlider)  {
//        guard let time = totalTime else {
//            return
//        }
//        let currentTime = Double(sender.value) * time
//        lbCurrentTime.text = "\(Utils.formatSecondsToString(currentTime))"
//        handleSlide(slider: sender, event: .valueChanged)
//    }
//
//    @objc func progressSliderTouchEnded(_ sender: UISlider)  {
//        print("progressSliderTouchEnded")
//        handleSlide(slider: sender, event: .touchUpInside)
//    }
//
//    func handleSlide(slider: UISlider, event: UIControl.Event) {
//        switch event {
//        case .touchDown:
//            timer?.invalidate()
//            isSliderSliding = true
//            break
//
//        case .touchUpInside :
//            timer?.invalidate()
//            if isVod {
//                if self.totalTime != nil {
//                    let target = self.totalTime * Double(slider.value)
//                    guard let avPlayer = getAVPlayer() else {
//                        return
//                    }
//                    avPlayer.seek(to: CMTime(seconds: target, preferredTimescale: CMTimeScale(1.0))) { complete in
//                        avPlayer.play()
//                        self.isSliderSliding = false
//                    }
//                }
//                else {
//                    slider.value = 1
//                }
//            }
//            break
//        case .touchUpOutside:
//            if self.totalTime == nil {
//                slider.value = 1
//            }
//            break
//
//        default:
//            break
//        }
//    }
//
//    func setupTimer() {
//        timer?.invalidate()
//        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(playerTimerAction), userInfo: nil, repeats: true)
//        timer?.fireDate = Date()
//    }
//
//    @objc fileprivate func playerTimerAction() {
//        if (!self.activityIndicator.isAnimating) {
//            guard let playerItem = getAVPlayer()?.currentItem else {
//                //                isVod = false
//                //                timeSlider.value = 1
//                return
//            }
//
//            if playerItem.duration.timescale != 0 {
//                if (!isSliderSliding) {
//                    isVod = true
//                    let currentTime = CMTimeGetSeconds(self.getAVPlayer()!.currentTime())
//                    let totalTime   = TimeInterval(playerItem.duration.value) / TimeInterval(playerItem.duration.timescale)
//                    playTimeDidChange(currentTime: currentTime, totalTime: totalTime)
//                }
//            } else {
//                isVod = false
//                //====== HEAD
////                timeSlider.value = 1
//                //====== END HEAD
//                guard let avPlayer = self.getAVPlayer() else {
//                    return
//                }
//                if let items = avPlayer.currentItem?.seekableTimeRanges {
//
//                    if(!items.isEmpty) {
//                        let range = items[items.count - 1]
//                        let timeRange = range.timeRangeValue
//                        let startSeconds = CMTimeGetSeconds(timeRange.start)
//                        let durationSeconds = CMTimeGetSeconds(timeRange.duration)
//                        let result = (startSeconds + durationSeconds)
//                        let isLive = (result - 20 <= avPlayer.currentTime().seconds)
//                        btnSeekToLive.isHidden = !self.isShowOverlay || isLive
//                        stackLive.isHidden = !self.isShowOverlay || !isLive
//                        playTimeDidChange(currentTime: avPlayer.currentTime().seconds, totalTime: result)
//
//                    }
//                }
//                //====== END HEAD
//            }
//        }
//    }
//}
//
//// player action
//extension BasePlayer {
//
//    func getAVPlayer() -> AVPlayer? {
//        return player?.playerLayer()?.player
//    }
//
//    func play() {
//        if let player = getAVPlayer() {
//            player.play()
//        }
//    }
//
//    func pause() {
//        getAVPlayer()?.pause()
//    }
//}
//
//
//// MARK: - Fullscreen
//
//extension BasePlayer {
//    @IBAction fileprivate func fullScreenOnPress(_ sender: UIButton) {
//        if isFullScreen {
//            isFullScreen = false
//            NotificationCenter.default.post(name: Notification.Name("OnNotFullScreen"), object: nil)
//            NotificationCenter.default.post(name: Notification.Name("fullscreenoff"), object: nil)
//        }
//        else {
//            isFullScreen = true
//            NotificationCenter.default.post(name: Notification.Name("OnFullScreen"), object: nil)
//        }
//        isShowOverlay = true
//        layoutSubviews()
//    }
//
//    @IBAction fileprivate func playPauseOnPress(_ sender: UIButton) {
//        if player != nil {
//            if isPlaying {
//                pause()
//            } else {
//                play()
//            }
//        }
//    }
//
//    @IBAction fileprivate func goHomeOnPress(_ sender: UIButton) {
//        if UIDevice.current.userInterfaceIdiom == .phone {
//            AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
//        }
//        self.backAction?()
//    }
//
//    @objc func seekAction() {
//        if let avplayer = self.getAVPlayer() {
//            avplayer.seek(to: CMTime(seconds: cacheTime, preferredTimescale: CMTimeScale(1.0)), toleranceBefore: CMTime.zero, toleranceAfter: CMTime.zero) { complete in
//                self.activityIndicator.stopAnimating()
//                self.cacheTime = -1.0
//                //                avplayer.play()
//            }
//        }
//    }
//
//    @IBAction fileprivate func nextOnPress(_ sender: UIButton) {
//        isShowOverlay = true
//        if player != nil {
//            if let avplayer = self.getAVPlayer() {
//                let time1 = CMTimeGetSeconds(avplayer.currentTime())
//                var time = time1
//                if (cacheTime >= 0) {
//                    time = cacheTime + 10
//                }
//                else {
//                    time = time + 10
//                }
//                cacheTime = time
//                print("cacheTime \(cacheTime)")
//                self.activityIndicator.startAnimating()
//                //            NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(seekAction), object: nil)
//                //            perform(#selector(seekAction), with: nil, afterDelay: (cacheTime-time1)/100)
//                seekAction()
//            }
//        }
//    }
//
//    @IBAction fileprivate func preOnPress(_ sender: UIButton) {
//        isShowOverlay = true
//        if player != nil {
//            if let avplayer = self.getAVPlayer() {
//                let time1 = CMTimeGetSeconds(avplayer.currentTime())
//                var time = time1 - 10
//                if (cacheTime >= 0.0) {
//                    time = cacheTime - 10
//                }
//                else {
//                    time = time - 10
//                }
//                time = max(time, 0)
//                cacheTime = time
//                self.activityIndicator.startAnimating()
//                //            NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(seekAction), object: nil)
//                //            perform(#selector(seekAction), with: nil, afterDelay: (cacheTime-time1)/100)
//                seekAction()
//            }
//        }
//    }
//
//    func onBackAction() {
//        if (!self.isFullScreen) {
//            isVisible = false
//            self.backAction?()
//        }
//        else {
//            NotificationCenter.default.post(name: Notification.Name("OnBackFullScreen"), object: nil)
//            isFullScreen = false
//            layoutSubviews()
//        }
//        if UIDevice.current.userInterfaceIdiom == .phone {
//            AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
//        }
//    }
//
//    @IBAction fileprivate func backOnPress(_ sender: UIButton) {
//        print("back")
//        onBackAction()
//    }
//
//    @IBAction fileprivate func seekToLive(_ sender: UIButton) {
//        guard let avPlayer = self.getAVPlayer() else {
//            return
//        }
//        if let items = avPlayer.currentItem?.seekableTimeRanges {
//
//            if(!items.isEmpty) {
//                let range = items[items.count - 1]
//                let timeRange = range.timeRangeValue
//                let startSeconds = CMTimeGetSeconds(timeRange.start)
//                let durationSeconds = CMTimeGetSeconds(timeRange.duration)
//                let result = (startSeconds + durationSeconds)
//                let target = result
//                avPlayer.seek(to: CMTime(seconds: target, preferredTimescale: CMTimeScale(1.0))) { complete in
//                    print(complete)
//                }
//            }
//        }
//    }
//}
//
//extension BasePlayer: PlayerPlaybackDelegate, PlayerDelegate {
//    func playerCurrentTimeDidChange(_ player: Player) {
//    }
//
//    func playerPlaybackWillStartFromBeginning(_ player: Player) {
//        print("playerPlaybackWillStartFromBeginning")
//    }
//
//    func playerPlaybackDidEnd(_ player: Player) {
//        print("playerPlaybackDidEnd")
//    }
//
//    func playerPlaybackWillLoop(_ player: Player) {
//        print("playerPlaybackWillLoop")
//    }
//
//    func playerPlaybackDidLoop(_ player: Player) {
//        print("playerPlaybackDidLoop")
//    }
//
//    func playerReady(_ player: Player) {
//        print("playerReady")
//    }
//
//    func playerPlaybackStateDidChange(_ player: Player) {
//        print("Baseplayer switchlink playbackstate: \(player.playbackState)")
//        vOverlay.isHidden = false
//        if player.playbackState == .failed {
//
//        } else if player.playbackState == .playing {
//            isPlaying = true
//            onVideoSuccess()
//        } else if ( player.playbackState == .paused || player.playbackState == .stopped ) {
//            isPlaying = false
//        }
//    }
//
//    func playerBufferingStateDidChange(_ player: Player) {
//        print("playerBufferingStateDidChange")
//    }
//
//    func playerBufferTimeDidChange(_ bufferTime: Double) {
//        print("playerBufferTimeDidChange")
//    }
//
//    func player(_ player: Player, didFailWithError error: Error?) {
//        print("didFailWithError \(String(describing: error))")
//        if let error = error {
//            if let avError = error as? AVError {
//                if avError.code == AVError.contentIsNotAuthorized ||
//                    avError.code == AVError.contentIsProtected {
//                    print("signkey invalid")
//                    if self.isStarted {
//                        return
//                    }
//                    UserDefaults.standard.removeObject(forKey: SIGNKEY_VALUE_KEY)
//                    UserDefaults.standard.removeObject(forKey: SIGNKEY_EXP_KEY)
//                    UserDefaults.standard.synchronize()
//                    playVideoWithUrl(url: model.url, isProtected: model.isProtected)
//                } else if avError.code == AVError.failedToParse {
//                    onVideoFailed()
//                }
//            }
//        }
//    }
//}
//
//// MARK: - IMAAdsLoaderDelegate
//extension BasePlayer: IMAAdsLoaderDelegate {
//    func adsLoader(_ loader: IMAAdsLoader, adsLoadedWith adsLoadedData: IMAAdsLoadedData) {
//        adsManager = adsLoadedData.adsManager
//        adsManager.delegate = self
//        adsManager.initialize(with: nil)
//    }
//
//    func adsLoader(_ loader: IMAAdsLoader, failedWith adErrorData: IMAAdLoadingErrorData) {
//        if let msg = adErrorData.adError.message {
//            print("AdsLoader Error loading ads: " + msg)
//        }
//        play()
//    }
//}
//
//// MARK: - IMAAdsManagerDelegate
//extension BasePlayer: IMAAdsManagerDelegate {
//    func adsManager(_ adsManager: IMAAdsManager, didReceive event: IMAAdEvent) {
//        // Play each ad once it has been loaded
//        if event.type == IMAAdEventType.LOADED {
//            adsManager.start()
//        } else if event.type == IMAAdEventType.STARTED {
//            if adsManager.adPlaybackInfo.totalMediaTime > 6 {
//                addSubview(skipView)
//                skipView.anchor(bottom: bottomAnchor, right: rightAnchor, paddingBottom: 11, width: 83, height: 26)
//
//                skipView.addSubview(skipAdsLabel)
//                skipAdsLabel.text = "Bỏ qua (5)"
//                skipAdsLabel.anchor(bottom: skipView.bottomAnchor, right: skipView.rightAnchor)
//                skipAdsLabel.centerY(inView: skipView, leftAnchor: skipView.leftAnchor, paddingLeft: 8, constant: 0)
//
//                skipView.addSubview(skipAdsIcon)
//                skipAdsIcon.centerY(inView: skipView)
//                skipAdsIcon.anchor(right: skipView.rightAnchor, paddingRight: 15)
//                skipAdsIcon.isHidden = true
//
//                addSubview(skipAdsButton)
//                skipAdsButton.anchor(top: skipView.topAnchor, left: skipView.leftAnchor, bottom: skipView.bottomAnchor, right: skipView.rightAnchor)
//                skipAdsButton.addTarget(self, action: #selector(skipAds), for: .touchUpInside)
//
//                timerAds?.invalidate()
//                timerAds = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(changeAdTimeLabel), userInfo: nil, repeats: true)
//            }
//        }
//    }
//
//    @objc func skipAds() {
//        if adsManager.adPlaybackInfo.currentMediaTime >= 5 {
//            adsManager.destroy()
//            play()
//            skipView.removeFromSuperview()
//            skipAdsButton.removeFromSuperview()
//            timerAds?.invalidate()
//        }
//    }
//
//    @objc func changeAdTimeLabel() {
//        let timeLeft = Int(round(5 - adsManager.adPlaybackInfo.currentMediaTime))
//        if timeLeft > 0 {
//            skipAdsLabel.text = "Bỏ qua (\(Int(round(5 - adsManager.adPlaybackInfo.currentMediaTime))))"
//        } else {
//            skipAdsLabel.text = "Bỏ qua"
//            skipAdsIcon.isHidden = false
//        }
//    }
//
//    func adsManager(_ adsManager: IMAAdsManager, didReceive error: IMAAdError) {
//        // Fall back to playing content
//        if let msg = error.message {
//            print("AdsManager Error loading ads: " + msg)
//        }
//        play()
//    }
//
//    func adsManagerDidRequestContentPause(_ adsManager: IMAAdsManager) {
//        // Pause the content for the SDK to play ads.
//        pause()
//    }
//
//    func adsManagerDidRequestContentResume(_ adsManager: IMAAdsManager) {
//        // Resume the content since the SDK is done playing ads (at least for now).
//        skipView.removeFromSuperview()
//        skipAdsButton.removeFromSuperview()
//        timerAds?.invalidate()
//        play()
//    }
//}
//
//extension BasePlayer {
//    func destroyAds() {
//        if let adsManager = adsManager {
//            adsManager.initialize(with: nil)
//            skipView.removeFromSuperview()
//            skipAdsButton.removeFromSuperview()
//            timerAds?.invalidate()
//            adsManager.pause()
//            adsManager.destroy()
//        }
//    }
//
//    func pauseAds() {
//        if let adsManager = adsManager {
//            adsManager.initialize(with: nil)
//            adsManager.pause()
//        }
//    }
//
//    func resumeAds() {
//        guard let adsManager = adsManager else {
//            requestAds() // initialize adsManager
//            return
//        }
//        if !adsManager.adPlaybackInfo.isPlaying {
//            adsManager.resume()
//        }
//    }
//}
