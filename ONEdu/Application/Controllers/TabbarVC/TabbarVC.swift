//
//  TabbarVC.swift
//  ONEdu
//
//  Created by Tran Dat on 31/05/2022.
//

import UIKit

class TabbarVC: UITabBarController {
    fileprivate lazy var defaultTabBarHeight = { tabBar.frame.size.height }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .clear
//        tabBar.backgroundImage = UIImage(named: "clear")
//        tabBar.barTintColor = .clear
//        tabBar.isTranslucent = true
        tabBar.backgroundColor = .white
        
        let vc1 = UINavigationController(rootViewController: HomeVC())
        let vc2 = UINavigationController(rootViewController: EducationVC())
        let vc3 = UINavigationController(rootViewController: MusicVC())
        let vc4 = UINavigationController(rootViewController: NewsVC())
        let vc5 = UINavigationController(rootViewController: MenuVC())
        
        vc1.tabBarItem.image = UIImage(named: "video-tabbar")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        vc1.tabBarItem.selectedImage = UIImage(named: "video-tabbar-active")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        vc1.tabBarItem.imageInsets = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        vc2.tabBarItem.image = UIImage(named: "learn-tabbar")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        vc2.tabBarItem.selectedImage = UIImage(named: "learn-tabbar-active")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        vc2.tabBarItem.imageInsets = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        vc3.tabBarItem.image = UIImage(named: "music-tabbar")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        vc3.tabBarItem.selectedImage = UIImage(named: "music-tabbar-active")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        vc3.tabBarItem.imageInsets = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        vc4.tabBarItem.image = UIImage(named: "books-tabbar")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        vc4.tabBarItem.selectedImage = UIImage(named: "books-tabbar-active")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        vc4.tabBarItem.imageInsets = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        vc5.tabBarItem.image = UIImage(named: "menu-tabbar")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        vc5.tabBarItem.selectedImage = UIImage(named: "menu-tabbar-active")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        vc5.tabBarItem.imageInsets = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        
        setViewControllers([vc1, vc2, vc3, vc4, vc5], animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
//        view.backgroundColor = .clear
        
        if #available(iOS 13, *) {
            let newTabBarHeight = defaultTabBarHeight - 12.0
            
            var newFrame = tabBar.frame
            newFrame.size.height = newTabBarHeight
            newFrame.origin.y = view.frame.size.height - newTabBarHeight
            
            tabBar.frame = newFrame
        }
    }
}
