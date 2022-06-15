//
//  TimeSlider.swift
//  ONSports
//
//  Created by Steve on 07/07/2021.
//

import Foundation
import UIKit

class TimeSlider: UISlider {
    public var valueChange:((Float)-> Void)?
    
    @objc func tapAndSlide(gesture: UILongPressGestureRecognizer)
    {
        let pt           = gesture.location(in: self)
        let thumbWidth   = self.thumbRect().size.width
        var value: Float = 0

        if (pt.x <= self.thumbRect().size.width / 2)
        {
            value = self.minimumValue
        }
        else if (pt.x >= self.bounds.size.width - thumbWidth / 2)
        {
            value = self.maximumValue
        }
        else
        {
            let percentage = Float((pt.x - thumbWidth / 2) / (self.bounds.size.width - thumbWidth))
            let delta      = percentage * (self.maximumValue - self.minimumValue)

            value          = self.minimumValue + delta
        }

        if (gesture.state == UIGestureRecognizer.State.began)
        {
            UIView.animate(withDuration: 0.35, delay: 0, options: UIView.AnimationOptions.curveEaseInOut,
            animations:
            {
                self.setValue(value, animated: false)
                self.valueChange?(value)
                super.sendActions(for: UIControl.Event.valueChanged)
            },
            completion: nil)
        }
        else
        {
            self.valueChange?(value)
            self.setValue(value, animated: false)
        }
    }

    func thumbRect() -> CGRect
    {
        return self.thumbRect(forBounds: self.bounds, trackRect: self.bounds, value: self.value)
    }
}
