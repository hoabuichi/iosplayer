//
//  UIView+CustomView.swift
//  ONSports
//
//  Created by Dao Thuy on 7/6/21.
//

import UIKit
extension UIView {
//    func nibView<T>(for: T.Type) -> UIView? {
//        let nib = UINib(nibName: String(describing: T.self), bundle: nil)
//        let view = nib.instantiate(withOwner: self, options: nil).first as? UIView
//        return view
//    }
//    
//    func addNibView<T>(from: T.Type) -> UIView? {
//        guard let nibView = nibView(for: T.self) else { return nil }
//        addSubview(nibView)
//        nibView.frame = bounds
//        return nibView
//    }
    
    func loadViewFromNib<T>(for: T.Type) -> UIView? {
        let nib = UINib(nibName: String(describing: T.self), bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    func addNibView<T>(from: T.Type) {
        guard let view = loadViewFromNib(for: T.self) else { return}
        view.frame = self.bounds
        self.addSubview(view)
    }
}


extension UIView {
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                left: NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                right: NSLayoutXAxisAnchor? = nil,
                paddingTop: CGFloat = 0,
                paddingLeft: CGFloat = 0,
                paddingBottom: CGFloat = 0,
                paddingRight: CGFloat = 0,
                width: CGFloat? = nil,
                height: CGFloat? = nil) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    func equalWidth(myView: UIView, view: UIView) {
        view.addConstraint(NSLayoutConstraint(item: myView, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1, constant: 0))
    }
    
    func center(inView view: UIView, yConstant: CGFloat? = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: yConstant!).isActive = true
    }
    
    func centerX(inView view: UIView, topAnchor: NSLayoutYAxisAnchor? = nil, paddingTop: CGFloat? = 0, constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: constant).isActive = true
        
        if let topAnchor = topAnchor {
            self.topAnchor.constraint(equalTo: topAnchor, constant: paddingTop!).isActive = true
        }
    }
    
    func centerY(inView view: UIView, leftAnchor: NSLayoutXAxisAnchor? = nil,
                 paddingLeft: CGFloat = 0, constant: CGFloat = 0) {
        
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant).isActive = true
        
        if let left = leftAnchor {
            anchor(left: left, paddingLeft: paddingLeft)
        }
    }
    
    func setDimensions(height: CGFloat, width: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    func setHeight(_ height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    func setWidth(_ width: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    func fillSuperview() {
        translatesAutoresizingMaskIntoConstraints = false
        guard let view = superview else { return }
        anchor(top: view.topAnchor, left: view.leftAnchor,
               bottom: view.bottomAnchor, right: view.rightAnchor)
    }
    
    var safeTopAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
          return safeAreaLayoutGuide.topAnchor
        }
        return topAnchor
      }
      var safeLeftAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *){
          return safeAreaLayoutGuide.leftAnchor
        }
        return leftAnchor
      }
      var safeRightAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *){
          return safeAreaLayoutGuide.rightAnchor
        }
        return rightAnchor
      }
      var safeBottomAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
          return safeAreaLayoutGuide.bottomAnchor
        }
        return bottomAnchor
      }
    
    func getViewsByType<T: UIView>(type _: T.Type) -> [T] {
        return getAllSubViews().compactMap { $0 as? T }
    }
    
    private func getAllSubViews() -> [UIView] {
        var subviews = self.subviews
        if subviews.isEmpty {
            return subviews
        }
        for view in subviews {
            subviews += view.getAllSubViews()
        }
        return subviews
    }
    
    func setHeightRatioWidth(with constraint: NSLayoutDimension, ratio: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalTo: constraint, multiplier: ratio).isActive = true
    }
}
