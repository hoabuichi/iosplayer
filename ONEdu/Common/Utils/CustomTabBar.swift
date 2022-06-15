//
//  Tabbar.swift
//  ONSports
//
//  Created by Steve on 05/07/2021.
//
import UIKit
class CustomTabBar : UITabBar {
    static var topBorder: CALayer? = nil
    let borderHeight: CGFloat = 1
    @IBInspectable var height: CGFloat = 44.0

    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        guard let window = UIApplication.shared.keyWindow else {
            return super.sizeThatFits(size)
        }
        var sizeThatFits = super.sizeThatFits(size)
        if height > 0.0 {

            if #available(iOS 11.0, *) {
                sizeThatFits.height = height + window.safeAreaInsets.bottom
            } else {
                sizeThatFits.height = height
            }
        }
        return sizeThatFits
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        if CustomTabBar.topBorder == nil {
            let border = CALayer()
            border.borderWidth = borderHeight
            border.borderColor = UIColor.white08.cgColor
            border.frame = CGRect(x: 0, y: -1, width: self.frame.width, height: borderHeight)
            CustomTabBar.topBorder = border
            self.layer.addSublayer(border)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
          super.init(coder: aDecoder)
        let frost: UIVisualEffectView
        if #available(iOS 13.0, *) {
            frost = UIVisualEffectView(effect: UIBlurEffect(style: .systemMaterialLight))
        } else {
            frost = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        }
          frost.frame = bounds
          frost.autoresizingMask = .flexibleWidth
          insertSubview(frost, at: 0)
      }
}
