import Alamofire

// MARK: NetworkReachability
let NETWORK_ONLINE = "NETWORK_ONLINE"
let NETWORK_OFFLINE = "NETWORK_OFFLINE"

final class NetworkMonitor {
    
    static let shared = NetworkMonitor()
    
    private let reachability = NetworkReachabilityManager()
    let reachabilityManager = Alamofire.NetworkReachabilityManager(host: "https://id.api.onsports.vn")
    
    
    public private(set) var isConnected: Bool = false {
        didSet {
            if (!isConnected) {
//                CustomToaster.showNotification(objNoti: NotificationObj(type: .error, message: "Mất kết nối mạng!"))
                NotificationCenter.default.post(name: Notification.Name(NETWORK_OFFLINE), object: nil)
                userDefaults.setValue(true, forKey: "DisconnectNetwork")
            } else {
                NotificationCenter.default.post(name: Notification.Name(NETWORK_ONLINE), object: nil)
                userDefaults.setValue(false, forKey: "DisconnectNetwork")
            }
        }
    }
    
    private init() {}
    
    func startListening() {
        reachabilityManager?.startListening { [weak self] status in
            guard let `self` = self else {
                return
            }
            switch status {
            case .notReachable:
                self.isConnected = false
                
            case .unknown,
                 .reachable(.ethernetOrWiFi),
                 .reachable(.cellular):
                self.isConnected = true
            }
        }
    }
    
    func stopListening() {
        reachabilityManager?.stopListening()
    }
    
    deinit {
        stopListening()
    }
}
