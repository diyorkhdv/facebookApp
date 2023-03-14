//
//  TabBarController.swift
//  Facebook App
//
//  Created by Diyor Khalmukhamedov on 13/03/23.
//

import UIKit

final class TabBarController: UITabBarController {
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.hidesBackButton = true
        setupTabs()
    }
    // MARK: - Tabs Setup
    private func setupTabs() {
        let feedVC = FeedViewController()
        let profileVC = ProfileViewController()
        
        let nav1 = UINavigationController(rootViewController: feedVC)
        let nav2 = UINavigationController(rootViewController: profileVC)

        nav1.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "newspaper"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 2)
        
        let navArray = [nav1, nav2]
        setViewControllers(navArray, animated: true)
    }
}
