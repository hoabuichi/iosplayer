//
//  File.swift
//  ONSports
//
//  Created by Dao Thuy on 7/17/21.
//

import UIKit

class PagingView: UIView {
  private weak var parent: UIViewController?
  private var pageController: UIPageViewController?
  public var pages: [UIViewController] = [] {
    didSet {
      if pages.count > 0 {
        let initialVC = pages[0]
        self.pageController?.setViewControllers([initialVC], direction: .forward, animated: true, completion: nil)
      }
    }
  }
  private var currentIndex: Int = 0 {
    didSet {
      currentIndexChange?(currentIndex)
    }
  }
  var currentIndexChange: ((Int)->Void)?
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  required init() {
    super.init(frame: .zero)
    commonInit()
  }
  func setParentController(vc: UIViewController) {
    parent = vc
    setupPageController()
  }
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    commonInit()
  }
  func commonInit() {
    //    addNibView(from: PageController.self)
  }
  override func layoutSubviews() {
    super.layoutSubviews()
    self.pageController?.view.frame = CGRect(x: 0,y: 0,width: self.frame.width,height: self.frame.height)
  }
  private func setupPageController() {
    self.pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    self.pageController?.dataSource = self
    self.pageController?.delegate = self
    self.pageController?.view.backgroundColor = .clear
    parent?.addChild(self.pageController!)
    addSubview(self.pageController!.view)
    self.pageController?.didMove(toParent: parent)
  }
  func setCurrentIndex(_ index: Int) {
    if pages.count > index {
      let initialVC = pages[index]
      self.pageController?.setViewControllers([initialVC], direction:.forward, animated: false, completion: nil)
    }
  }
}
extension PagingView: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
    guard let pageIndex = pages.firstIndex(of: viewController) else { return nil }
    let previousIndex = pageIndex - 1
    guard previousIndex >= 0 else { return nil }
    guard pages.count > previousIndex else { return nil }
    return pages[previousIndex]
  }
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
    guard let pageIndex = pages.firstIndex(of: viewController) else { return nil }
    let nextIndex = pageIndex + 1
    let pageCount = pages.count
    guard pageCount > nextIndex else { return nil }
    return pages[nextIndex]
  }
  func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool)
  {
    if (!completed)
   {
    return
   }
    guard let pageIndex = pages.firstIndex(of: pageViewController.viewControllers!.first!) else { return }
   currentIndex = pageIndex
  }
}
