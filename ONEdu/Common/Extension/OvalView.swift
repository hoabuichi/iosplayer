//
//  OvalView.swift
//  ONEdu
//
//  Created by Tran Dat on 02/06/2022.
//

import UIKit

class OvalView: UIView {
    var color: UIColor = .white

//    override func layoutSubviews() {
//        super.layoutSubviews()
//        layoutOvalMask()
//    }
//
//    private func layoutOvalMask() {
//        let mask = self.shapeMaskLayer()
//        let bounds = self.bounds
//        if mask.frame != bounds {
//            mask.frame = bounds
//            mask.path = CGPath(ellipseIn: bounds, transform: nil)
//        }
//    }
//
//    private func shapeMaskLayer() -> CAShapeLayer {
//        if let layer = self.layer.mask as? CAShapeLayer {
//            return layer
//        }
//        let layer = CAShapeLayer()
//        layer.fillColor = UIColor.black.cgColor
//        self.layer.mask = layer
//        return layer
//    }

    override func draw(_ rect: CGRect)
        {
            var ovalPath = UIBezierPath(ovalIn: rect)
            color.setFill()
            ovalPath.fill()
        }
    
}
