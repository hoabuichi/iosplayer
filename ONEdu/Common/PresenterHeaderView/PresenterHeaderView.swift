////
//// PresenterHeaderView.swift
//// ONSports
////
//// Created by will on 20/05/2022.
////
//import UIKit
//class PresenterHeaderView: UIView {
//  private let headerBar: HeaderBar = {
//    let headerBar = HeaderBar()
//    headerBar.titleLabel.text = ""
//    return headerBar
//  }()
//
//    func hideBackButton(isBackButton: Bool) {
//        headerBar.backButton.isHidden = isBackButton
//    }
//  func setBackBtnContoller(vc: UIViewController) {
//    headerBar.backButton.vc = vc
//  }
//  public func setHeaderTitle(text: String) {
//    headerBar.titleLabel.text = text
//  }
//  private let opacityView: UIView = {
//    let opacityView = UIView()
//    opacityView.backgroundColor = .bkgDark.withAlphaComponent(0.3)
//    return opacityView
//  }()
//  private let blurView: UIVisualEffectView = {
//    if #available(iOS 13.0, *) {
//      let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark))
//      return blurView
//    } else {
//      let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
//      return blurView
//    }
//  }()
//  override init(frame: CGRect) {
//    super.init(frame: frame)
//  }
//  required init() {
//    super.init(frame: .zero)
//    style()
//    setupView()
//  }
//  func style() {
//    self.backgroundColor = .clear
//    self.clipsToBounds = true
//  }
//  required init?(coder: NSCoder) {
//    fatalError("init(coder): Not implemented")
//  }
//  func setupView() {
//    self.addSubview(blurView)
//    blurView.anchor(top: self.safeTopAnchor, left: self.safeLeftAnchor, bottom: self.safeBottomAnchor, right: self.safeRightAnchor, paddingTop: -80)
//    self.addSubview(opacityView)
//    opacityView.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor)
//    self.addSubview(headerBar)
//    headerBar.anchor(top: self.safeTopAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor)
//  }
//}
