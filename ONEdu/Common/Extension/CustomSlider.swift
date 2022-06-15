//
//  CustomSlider.swift
//  ONSports
//
//  Created by will on 27/09/2021.
//
import UIKit

class SliderView: UISlider {
     override func trackRect(forBounds bounds: CGRect) -> CGRect {
          var result = super.trackRect(forBounds: bounds)
          result.origin.x = 28
          result.size.width = bounds.size.width - 60
          result.size.height = 4
          return result
     }
}
