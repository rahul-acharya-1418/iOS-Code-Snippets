//
//  APPTabBarController.swift
//  TabbarDemo
//
//  Created by Rahul Acharya on 20/08/26.
//

import UIKit

class APPTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
//        configureTabBar()
        setUpTabs()
    }
    
    
    private func configureTabBar() {
        if #available(iOS 26.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithTransparentBackground()
            appearance.backgroundColor = .clear
            appearance.backgroundEffect = nil
            appearance.shadowColor = .clear

            tabBar.standardAppearance = appearance
            tabBar.scrollEdgeAppearance = appearance

            tabBar.isTranslucent = true
            tabBar.backgroundColor = .clear
            tabBar.barTintColor = .clear
        } else {
            tabBar.isTranslucent = true
            tabBar.backgroundImage = UIImage()
            tabBar.shadowImage = UIImage()
            tabBar.backgroundColor = .clear
        }
    }
    
    private func setUpTabs() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc1 = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        let vc2 = storyBoard.instantiateViewController(withIdentifier: "ViewController2") as! ViewController2
        
        vc1.navigationItem.largeTitleDisplayMode = .automatic
        vc2.navigationItem.largeTitleDisplayMode = .automatic
        
        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        
        nav1.tabBarItem = UITabBarItem(
            title: "Characters",
            image: UIImage(systemName: "person"),
            tag: 1
        )
        nav2.tabBarItem = UITabBarItem(
            title: "Locations",
            image: UIImage(systemName: "globe"),
            tag: 2
        )
        
        for nav in [nav1, nav2] {
            nav.navigationBar.prefersLargeTitles = true
        }
        setViewControllers(
            [nav1, nav2],
            animated: true
        )
    }
}
