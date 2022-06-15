////
////  ScreenRecordingProtoector.swift
////  ONSports
////
////  Created by thuydd on 11/08/2021.
////
//
//import UIKit
//final class ScreenRecordingProtector {
//
//    public var callback: ((Bool) -> Void)?
//
//    private var window: UIWindow? {
//        if #available(iOS 13.0, *) {
//            return (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window
//        }
//        return (UIApplication.shared.delegate as? AppDelegate)?.window
//    }
//
//    func startPreventing() {
//        NotificationCenter.default.addObserver(self, selector: #selector(didDetectRecording), name: UIScreen.capturedDidChangeNotification, object: nil)
//    }
//
//    @objc private func didDetectRecording() {
//        DispatchQueue.main.async {
//            self.callback?(!UIScreen.main.isCaptured)
//        }
//    }
//
//    // MARK: - Deinit
//    deinit {
//        NotificationCenter.default.removeObserver(self)
//    }
//}
