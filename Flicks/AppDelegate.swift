//
//  AppDelegate.swift
//  Flicks
//
//  Created by Josh Jeong on 3/29/17.
//  Copyright © 2017 JoshJeong. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        initTabBarController()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func initTabBarController() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let navigationVC1 = mainStoryboard.instantiateViewController(withIdentifier: "MainNavigationController") as! UINavigationController
        
        let vc1 = mainStoryboard.instantiateViewController(withIdentifier: "NowPlayingViewController") as! NowPlayingViewController
        navigationVC1.tabBarItem.title = "Now Playing"
        navigationVC1.tabBarItem.image = UIImage(named: "playing")
        navigationVC1.navigationBar.barTintColor = UIColor.black
        navigationVC1.navigationBar.tintColor = UIColor.yellow
        vc1.endpoint = "now_playing"
        
        let navigationVC2 = mainStoryboard.instantiateViewController(withIdentifier: "MainNavigationController") as! UINavigationController
        let vc2 = mainStoryboard.instantiateViewController(withIdentifier: "NowPlayingViewController") as! NowPlayingViewController
        navigationVC2.tabBarItem.title = "Top Rated"
        navigationVC2.tabBarItem.image = UIImage(named: "star")
        vc2.endpoint = "top_rated"
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [navigationVC1, navigationVC2]
        tabBarController.tabBar.barTintColor = UIColor.black
        tabBarController.tabBar.tintColor = UIColor.yellow
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        navigationVC1.pushViewController(vc1, animated: false)
        navigationVC2.pushViewController(vc2, animated: false)
    }


}

