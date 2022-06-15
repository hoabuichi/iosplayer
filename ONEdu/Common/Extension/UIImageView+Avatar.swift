//
//  UIImageView+Avatar.swift
//  ONSports
//
//  Created by Steve on 11/07/2021.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    func makeCircleRounded() {
        self.layer.borderWidth = 1
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
    
    func setRemoteImg(url: String) {
        if let convertUrl = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) {
            self.kf.setImage(with: URL(string: convertUrl))
        } else {
            self.kf.setImage(with: URL(string: url))
        }
    }
}

extension UIView {
    func roundedPolygonPath(
        rect: CGRect,
        lineWidth: CGFloat,
        sides: NSInteger,
        cornerRadius: CGFloat,
        rotationOffset: CGFloat = 0
    ) -> UIBezierPath {

        let path = UIBezierPath()
        let theta: CGFloat = CGFloat(2.0 * Double.pi) / CGFloat(sides) // How much to turn at every corner
        let width = min(rect.size.width, rect.size.height)             // Width of the square

        let center = CGPoint(x: rect.origin.x + width / 2.0, y: rect.origin.y + width / 2.0)

        // Radius of the circle that encircles the polygon
        // Notice that the radius is adjusted for the corners, that way the largest outer
        // dimension of the resulting shape is always exactly the width - linewidth
        let radius = (width - lineWidth + cornerRadius - (cos(theta) * cornerRadius)) / 2.0

        // Start drawing at a point, which by default is at the right hand edge
        // but can be offset
        var angle = CGFloat(rotationOffset)

        let corner = CGPoint(x: center.x + (radius - cornerRadius) * cos(angle), y: center.y + (radius - cornerRadius) * sin(angle))
        path.move(to: CGPoint(x: corner.x + cornerRadius * cos(angle + theta), y: corner.y + cornerRadius * sin(angle + theta)))

        (0..<sides).forEach { _ in
          angle += theta

          let corner = CGPoint(x: center.x + (radius - cornerRadius) * cos(angle), y: center.y + (radius - cornerRadius) * sin(angle))
          let tip = CGPoint(x: center.x + radius * cos(angle), y: center.y + radius * sin(angle))
          let start = CGPoint(x: corner.x + cornerRadius * cos(angle - theta), y: corner.y + cornerRadius * sin(angle - theta))
          let end = CGPoint(x: corner.x + cornerRadius * cos(angle + theta), y: corner.y + cornerRadius * sin(angle + theta))

          path.addLine(to: start)
          path.addQuadCurve(to: end, controlPoint: tip)
        }

        path.close()

        // Move the path to the correct origins
        let bounds = path.bounds
        let transform = CGAffineTransform(translationX: -bounds.origin.x + rect.origin.x + lineWidth / 2.0,
                                          y: -bounds.origin.y + rect.origin.y + lineWidth / 2.0)
        path.apply(transform)

        return path
    }
}

