//
//  Utils.swift
//  ONSports
//
//  Created by Dao Thuy on 7/5/21.
//

import Foundation
import UIKit
import KeychainAccess

class Utils {
    public static let shared = Utils()
    public static func loadController<T>(from storyboard: String, of type: T.Type, with identifier: String? = nil) -> T {
        let storybroad = UIStoryboard(name: storyboard, bundle: Bundle.main)
        let identifier = identifier ?? String(describing: type.self)
        guard let vc = storybroad.instantiateViewController(withIdentifier: identifier) as? T else {
            fatalError("Cannot found viewcontroller with \(identifier)")
        }
        return vc
    }
    public static var keyWindow: UIWindow? {
        if #available(iOS 13, *) {
            return UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        } else {
            return UIApplication.shared.keyWindow
        }
    }
    public static var statusBarFrame: CGRect {
        if #available(iOS 13, *) {
            return keyWindow?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero
        } else {
            return UIApplication.shared.statusBarFrame
        }
    }
    public static var appDelegate: AppDelegate? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        return appDelegate
    }
}
// Handle change storyboard when handle session
extension Utils {
    public static var mostTopViewController: UIViewController? {
        get {
            return Utils.keyWindow?.rootViewController
        }
        set {
            guard let keyWindow = Utils.keyWindow else {
                return
            }
            keyWindow.rootViewController = newValue
            keyWindow.makeKeyAndVisible()
        }
    }
}

extension Utils {
    static func formatSecondsToString(_ seconds: TimeInterval) -> String {
           if seconds.isNaN {
               return "00:00"
           }
        var min = Int(seconds / 60)
        if (min <= 60) {
           let sec = Int(seconds.truncatingRemainder(dividingBy: 60))
           return String(format: "%02d:%02d", min, sec)
        } else {
            let hour = Int(min/60)
            min = Int(min%60)
            let sec = Int(seconds.truncatingRemainder(dividingBy: 60))
            return String(format: "%02d:%02d:%02d",hour, min, sec)
        }
       }
}

extension Utils {
    static func getIPAddress() -> String {
        var address: String?
        var ifaddr: UnsafeMutablePointer<ifaddrs>? = nil
        if getifaddrs(&ifaddr) == 0 {
            var ptr = ifaddr
            while ptr != nil {
                defer { ptr = ptr?.pointee.ifa_next }

                guard let interface = ptr?.pointee else { return "" }
                let addrFamily = interface.ifa_addr.pointee.sa_family
                if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {

                    // wifi = ["en0"]
                    // wired = ["en2", "en3", "en4"]
                    // cellular = ["pdp_ip0","pdp_ip1","pdp_ip2","pdp_ip3"]

                    let name: String = String(cString: (interface.ifa_name))
                    if  name == "en0" || name == "en2" || name == "en3" || name == "en4" || name == "pdp_ip0" || name == "pdp_ip1" || name == "pdp_ip2" || name == "pdp_ip3" {
                        var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                        getnameinfo(interface.ifa_addr, socklen_t((interface.ifa_addr.pointee.sa_len)), &hostname, socklen_t(hostname.count), nil, socklen_t(0), NI_NUMERICHOST)
                        address = String(cString: hostname)
                    }
                }
            }
            freeifaddrs(ifaddr)
        }
        return address ?? ""
    }
}

let keychain = Keychain(service: "com.vtvcab.onsports")
let accessTokenName = "accessToken"
let signKeyName = "signKey"
let refreshTokenName = "refreshToken"

func saveKeyChain(_ token: String, _ tokenName: String) {
    keychain[tokenName] = token
}

func deleteKeyChain(_ tokenName: String) {
    keychain[tokenName] = nil
}

func getKeyChain(_ tokenName: String) -> String? {
    return keychain[tokenName]
}

let userDefaults = UserDefaults.standard
