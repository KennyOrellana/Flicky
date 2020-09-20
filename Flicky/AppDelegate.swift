//
//  AppDelegate.swift
//  Flicky
//
//  Created by Kenny Orellana on 9/15/20.
//  Copyright © 2020 Kenny Orellana. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setupTabBarWithSearchContainerView()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func setupTabBarWithSearchContainerView() {
        if let tabBarController = window?.rootViewController as? UITabBarController {
            let feedViewController = tabBarController.viewControllers?[0] as? FeedViewController
            
            let searchController = UISearchController(searchResultsController: nil)
            searchController.searchBar.keyboardAppearance = UIKeyboardAppearance.dark
            searchController.searchResultsUpdater = feedViewController
            searchController.hidesNavigationBarDuringPresentation = false
            searchController.view.backgroundColor = UIColor.black
            
            let searchContainerViewController = UISearchContainerViewController(searchController: searchController)
            searchContainerViewController.title = "Search"
            
//            let searchNavController = UINavigationController(rootViewController: searchContainerViewController)
//            searchNavController.tabBarItem = UITabBarItem(title: "Search", image: UIImage(named: "searchIcon"), tag: 0)

//            tabBarController.viewControllers?.append(searchNavController)
            tabBarController.viewControllers?.append(searchContainerViewController)
        }

    }
}
