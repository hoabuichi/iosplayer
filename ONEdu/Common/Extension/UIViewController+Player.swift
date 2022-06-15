////
////  UIViewController+Player.swift
////  ONSports
////
////  Created by thuydd on 05/08/2021.
////
//
//import Foundation
//import UIKit
//
//let SIGNKEY_VALUE_KEY = "signkey"
//let SIGNKEY_EXP_KEY = "signkeyexp"
//
//enum Status {
//    case NoLogin
//    case ReadyToPlay
//    case Unknown
//}
//
//func validateSignKeyCommon(completed:  @escaping ((_ status: Status) -> Void)) {
//    let accessToken = getKeyChain(accessTokenName)
//    if ((accessToken) != nil) {
//        let exp = UserDefaults.standard.integer(forKey: SIGNKEY_EXP_KEY)
//        let expDate = Date(timeIntervalSince1970: TimeInterval(exp))
//        let interval = expDate - Date()
//        print("time interval \(interval)")
////         300 seconds
//        if (interval > 0) {
//            completed(.ReadyToPlay)
//        } else {
//            print("call new signkey")
//            let sevice = LoginService()
//            sevice.getSignkey().cloudResponse { (response) in
//                guard let state = response.status?.state else { return }
//                switch state {
//                case .success:
//                    UserDefaults.standard.setValue(response.signkey, forKey: SIGNKEY_VALUE_KEY)
//                    UserDefaults.standard.setValue(response.exp, forKey: SIGNKEY_EXP_KEY)
//                    UserDefaults.standard.synchronize()
//                    completed(.ReadyToPlay)
//                    break
//                case .error(code: let errCode):
//                    print(errCode)
//                    completed(.Unknown)
//                    break
//                }
//            }.cloudError {(errMsg, code: Int?) in
//                completed(.Unknown)
//            }
//        }
//    }
//    else {
//        completed(.NoLogin)
//    }
//}
//
//extension UIView {
//    func validateSignKey(completed:  @escaping ((_ status: Status) -> Void)) {
//        validateSignKeyCommon(completed: completed)
//    }
//}
//
//extension UIViewController: UNUserNotificationCenterDelegate {
//
//    func validateSignKey(completed:  @escaping ((_ status: Status) -> Void)) {
//        validateSignKeyCommon(completed: completed)
//    }
//
//    func checkVideoNotHappen(model: VODDetailModel, callback: () -> Void) {
//        if (model.type == .live || model.type == .live_show) {
//            if (model.status == .not_started) {
//                let components = model.startTime.get(.day, .month, .hour, .minute)
//                NotificationCenter.default.post(name: Notification.Name("VideoNotStarted"), object: nil)
//
//                let modalView = ModalDialog()
//                if let day = components.day, let month = components.month, let hour = components.hour, let minute = components.minute {
//                    let dayStr: String = day < 10 ? "0\(day)" : "\(day)"
//                    let monthStr: String = month < 10 ? "0\(month)" : "\(month)"
//                    let hourStr: String = hour < 10 ? "0\(hour)" : "\(hour)"
//                    let minuteStr: String = minute < 10 ? "0\(minute)" : "\(minute)"
//
//                    if model.isSetNoti {
//                        modalView.configureView(dialog: DialogObject(title: "", description: "\(model.name) sẽ diễn ra vào lúc \(hourStr):\(minuteStr) ngày \(dayStr)/\(monthStr)", titleButtonLeft: "Đóng", titleButtonRight: "Hủy nhắc tôi", colorButtonLeft: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), colorButtonRight: #colorLiteral(red: 0.937254902, green: 0.2509803922, blue: 0.2078431373, alpha: 1)))
//                    } else {
//                        modalView.configureView(dialog: DialogObject(title: "", description: "\(model.name) sẽ diễn ra vào lúc \(hourStr):\(minuteStr) ngày \(dayStr)/\(monthStr)", titleButtonLeft: "Đóng", titleButtonRight: "Nhắc tôi", colorButtonLeft: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), colorButtonRight: #colorLiteral(red: 0, green: 0.5960784314, blue: 0.8509803922, alpha: 1)))
//                    }
//                }
//                modalView.show(height: 150, disabledClickOutside: false)
//                modalView.buttonPressLeft = { [] in
//                    modalView.onClickTransparentView()
//                }
//                modalView.buttonPressRight = { [] in
//                    UNUserNotificationCenter.current().getNotificationSettings { (settings) in
//                        if settings.authorizationStatus == .authorized {
//                            let notificationService = NotificationService()
//                            if let deviceToken = UserDefaults.standard.string(forKey: "DeviceToken") {
//                                var newModel: VODDetailModel = model
//                                newModel.isSetNoti = !newModel.isSetNoti
//                                notificationService.setNotification(registrationToken: deviceToken, matchSyncId: model.matchSyncId, notify: newModel.isSetNoti).cloudResponse { [weak self](response) in
//                                    guard let state = response.status?.state, let `self` = self else { return }
//                                    switch state {
//                                    case .success:
//                                        NotificationCenter.default.post(name: Notification.Name("SetNotification"), object: newModel)
//                                        modalView.onClickTransparentView()
//                                        let viewNotifyBottom = NotificationBottom()
//                                        viewNotifyBottom.showNotiBottom(newModel.isSetNoti)
//                                    case .error(code: let errCode):
//                                    //handle login error
//                                        break
//                                    }
//                                }.cloudError { [weak self](errMsg, code: Int?) in
//                                    //handle login error
//                                }
//                            }
//                        } else {
//                            self.showSettingNotify()
//                        }
//                    }
//                }
//            } else {
//                callback()
//            }
//        } else {
//            callback()
//        }
//    }
//
//    func playVideo(model: VODDetailModel) {
//        checkVideoNotHappen(model: model, callback: { [weak self] in
//            guard let `self` = self else {
//                return
//            }
//            if model.isProtected {
//                self.handleProtectedVideo(model)
//            } else {
//                self.showVideo(model: model)
//            }
////            self.showVideo(model: model)
//        })
//    }
//
//    func showVideo(model: VODDetailModel) {
//        if UIDevice.current.userInterfaceIdiom == .phone {
//            AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
//        }
//        let vc = VODDetailVC.initializeVC()
////        vc.model = model
//        vc.videoId = model.id
//        vc.type = model.type.rawValue
//        vc.modalPresentationStyle = .fullScreen
//        self.present(vc, animated: true, completion: nil)
//
//    }
//
//    func showModal(_ model: VODDetailModel) {
//        let modalView = ModalDialog()
//        modalView.configureView(dialog: DialogObject(title: "Thông báo", description: "Bạn cần đăng nhập để sử dụng tính năng này.", titleButtonLeft: "Huỷ", titleButtonRight: "Đăng nhập", colorButtonLeft: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.8748447848), colorButtonRight: #colorLiteral(red: 0, green: 0.5960784314, blue: 0.8509803922, alpha: 1)))
//        modalView.show(height: 160, disabledClickOutside: true)
//
//        modalView.buttonPressLeft = { [] in
//            modalView.onClickTransparentView()
//        }
//        modalView.buttonPressRight = { [weak self] in
//            guard let `self` = self else {
//                return
//            }
//            modalView.onClickTransparentView()
//
//            let vc = Utils.loadController(from: Storyboard.Login, of: LoginVC.self)
//            vc.model = model
//            vc.callbackLogin = {
//                vc.dismiss(animated: false)
//            }
//            vc.callbackSuceessLogin = { [weak self] model in
//                guard let `self` = self else {
//                    return
//                }
//                vc.navigationController?.dismiss(animated: false) {
//                    self.showVideo(model: model)
//                }
//            }
//            let navVc = UINavigationController(rootViewController: vc)
//            navVc.isNavigationBarHidden = true
//            navVc.modalPresentationStyle = .fullScreen
//            self.present(navVc, animated: true, completion: nil)
//        }
//    }
//
//    func handleProtectedVideo(_ model: VODDetailModel) {
//        validateSignKey(completed:{ [weak self] status in
//            guard let `self` = self else {
//                return
//            }
//            switch status {
//            case .NoLogin:
////                self.showLogin()
//                self.showModal(model)
//                break
//            case .ReadyToPlay:
//                self.showVideo(model: model)
//                break
//            default:
//                break
//            }
//        })
//    }
//
//    func showSettingNotify() {
//        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
//            (granted, error) in
//              // add your own
//            UNUserNotificationCenter.current().delegate = self
//            let alertController = UIAlertController(title: "Thông báo", message: "Bạn cần bật thông báo của ứng dụng để thực hiện tính năng này.", preferredStyle: .alert)
//            let settingsAction = UIAlertAction(title: "Cài đặt", style: .default) { (_) -> Void in
//                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
//                    return
//                }
//                if UIApplication.shared.canOpenURL(settingsUrl) {
//                    UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
//                    })
//                }
//            }
//            let cancelAction = UIAlertAction(title: "Huỷ", style: .default, handler: nil)
//            alertController.addAction(cancelAction)
//            alertController.addAction(settingsAction)
//            DispatchQueue.main.async {
//                self.present(alertController, animated: true, completion: nil)
//            }
//        }
//    }
//}

import UIKit

extension UIViewController {
    func presentInFullScreen(_ viewController: UIViewController,
                             animated: Bool,
                             completion: (() -> Void)? = nil) {
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: animated, completion: completion)
    }
}
