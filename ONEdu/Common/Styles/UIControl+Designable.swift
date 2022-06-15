//
//  UIControl+Designable.swift
//  ONSports
//
//  Created by Dao Thuy on 7/5/21.
//

import UIKit
@IBDesignable
public class DesignableView: UIControl {
    // MARK: - Corners
    @IBInspectable
    open var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    // MARK: - Border
    @IBInspectable
    open var borderColor: UIColor = .clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    @IBInspectable
    open var borderWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    // MARK: - Shadow
    @IBInspectable
    open var shadowColor: UIColor = .clear {
        didSet {
            layer.shadowColor = shadowColor.cgColor
        }
    }
    @IBInspectable
    open var shadowOffset: CGSize = .zero {
        didSet {
            layer.shadowOffset = shadowOffset
        }
    }
    @IBInspectable
    open var shadowOpacity: Float = 0.0 {
        didSet {
            layer.shadowOpacity = shadowOpacity
        }
    }
    @IBInspectable
    open var shadowRadius: CGFloat = 0.0 {
        didSet {
            layer.shadowRadius = shadowRadius
        }
    }
    // MARK: - Gradient
    @IBInspectable
    open var gradientStartColor: UIColor = .clear {
        didSet {
            guard let layer = layer as? CAGradientLayer else {
                return
            }

            layer.colors = [gradientStartColor.cgColor, gradientEndColor.cgColor]
        }
    }
    @IBInspectable
    open var gradientStartPoint: CGPoint = CGPoint(x: 0.5, y: 0.0) {
        didSet {
            guard let layer = layer as? CAGradientLayer else {
                return
            }

            layer.startPoint = gradientStartPoint
        }
    }
    @IBInspectable
    open var gradientEndColor: UIColor = .clear {
        didSet {
            guard let layer = layer as? CAGradientLayer else {
                return
            }

            layer.colors = [gradientStartColor.cgColor, gradientEndColor.cgColor]
        }
    }
    @IBInspectable
    open var gradientEndPoint: CGPoint = CGPoint(x: 0.5, y: 1.0) {
        didSet {
            guard let layer = layer as? CAGradientLayer else {
                return
            }

            layer.endPoint = gradientEndPoint
        }
    }
    // MARK: - Highlighting
    @IBInspectable
    open var highlightAlpha: CGFloat = 1.0

    open var highlightViews: [UIView] {
        []
    }
    override open var isHighlighted: Bool {
        didSet {
            if !highlightViews.isEmpty {
                highlightViews.forEach { $0.alpha = isHighlighted ? highlightAlpha : 1.0 }
            } else {
                self.alpha = isHighlighted ? highlightAlpha : 1.0
            }
        }
    }
    // MARK: - View
    override open class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    override public func layoutSubviews() {
        super.layoutSubviews()

        layer.shouldRasterize = shadowColor != .clear && shadowOpacity != 0.0
    }
}
