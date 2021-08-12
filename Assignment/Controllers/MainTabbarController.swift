//
//  MainTabbarController.swift
//  Assignment
//
//  Created by Shreyak Godala on 12/08/21.
//

import UIKit

class MainTabbarController: UITabBarController {
    
    override func viewDidLoad() {
        
        
        viewControllers = [
            createNavController(for: SearchController(), image: UIImage(named: "search")!, title: "Search"),
          createNavController(for: WatchListController(), image: UIImage(named: "downloads")!, title: "WatchList")
            
        ]
        
    }
    
    func createNavController(for rootViewController:UIViewController, image: UIImage, title: String) -> UIViewController {
        
       let navController = UINavigationController(rootViewController: rootViewController)
       rootViewController.navigationItem.title = title
       navController.navigationBar.prefersLargeTitles = true
       navController.tabBarItem.title = title
       navController.tabBarItem.image = image
       return navController
        
    }
    
    
}
