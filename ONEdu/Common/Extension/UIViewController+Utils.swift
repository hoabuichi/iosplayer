//
//  UIViewController+Utils.swift
//  ONSports
//
//  Created by Steve on 11/07/2021.
//

import Foundation
import UIKit
@nonobjc extension UIViewController {
    func add(_ child: UIViewController, frame: CGRect? = nil) {
        addChild(child)

        if let frame = frame {
            child.view.frame = frame
        }

        view.addSubview(child.view)
        child.didMove(toParent: self)
    }

    func remove() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
    
    func navigationViewTabbar(selectedIndex: Int) {
        let tabBarController = UIApplication.shared.keyWindow?.rootViewController as! UITabBarController
        tabBarController.selectedIndex = selectedIndex
        self.presentingViewController?.presentingViewController!.dismiss(animated: true, completion: {})
    }
        
    func openModal(_ modalView: UIView) {
        self.view.addSubview(modalView)
        modalView.anchor(top: self.view.safeTopAnchor, left: self.view.safeLeftAnchor, bottom: self.view.safeBottomAnchor, right: self.view.safeRightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: -1000, paddingRight: 0)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            modalView.anchor(top: self.view.safeTopAnchor, left: self.view.safeLeftAnchor, bottom: self.view.safeBottomAnchor, right: self.view.safeRightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        }, completion: nil)
    }
    
    func hideModal(_ modalView: UIView) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            modalView.anchor(top: self.view.safeTopAnchor, left: self.view.safeLeftAnchor, bottom: self.view.safeBottomAnchor, right: self.view.safeRightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: -1000, paddingRight: 0)
            modalView.removeFromSuperview()
        }, completion: nil)
    }
}

@nonobjc extension UIView {
    func add(_ vc: UIViewController, child: UIViewController, frame: CGRect? = nil) {
        vc.addChild(child)

        if let frame = frame {
            child.view.frame = frame
        }  else {
            child.view.frame = self.bounds
        }

        self.addSubview(child.view)
        child.didMove(toParent: vc)
    }

    func remove(_ vc: UIViewController) {
        vc.willMove(toParent: nil)
        self.removeFromSuperview()
        vc.removeFromParent()
    }
}
