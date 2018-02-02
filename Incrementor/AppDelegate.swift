//
//  AppDelegate.swift
//  Incrementor
//
//  Created by Богдан Маншилин on 01/02/2018.
//  Copyright © 2018 BManshilin. All rights reserved.
//

import UIKit
import Swinject
import Services
import Views
import ViewModels

enum InjectionError: Error {
    case noRegisteredServices(for: Any.Type)
}

extension Resolver {
    func resolve<T>() throws -> T {
        guard let service = resolve(T.self) else {
            throw InjectionError.noRegisteredServices(for: T.self)
        }
        return service
    }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let container = Container { container in
        // Models
        container.register(Storing.self) { _ in DiskStorage() }
        container.register(Config.self) { _ in
            return StoredConfig.stored ?? StoredConfig.default
        }
        container.register(Incrementing.self) { resolver in
            return try! Incrementor(config: resolver.resolve(), storage: resolver.resolve())
            
        }
        
        // View Models
        container.register(IncrementViewModelling.self) { resolver in
            return IncrementViewModel(incrementor: try! resolver.resolve())
        }
        
        container.register(ConfigViewModelling.self) { resolver in
            return ConfigViewModel(config: try! resolver.resolve())
            
        }
        
        // Views
        container.register(MenuViewControllering.self) { resolver in
            return MenuViewController(
                incrementor: { try! resolver.resolve()},
                config: { try! resolver.resolve()}
            )
        }
        
        container.register(ConfigViewControlling.self) { resolver in
            return ConfigViewController(viewModel: try! resolver.resolve(), style: .grouped)
        }
        
        container.register(IncrementViewControlling.self) { resolver in
            return IncrementViewController(viewModel: try! resolver.resolve())
        }

    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let rootViewController = UINavigationController()
        rootViewController.viewControllers = [container.resolve(MenuViewControllering.self)!.controller]
        rootViewController.isNavigationBarHidden = false
        rootViewController.navigationBar.prefersLargeTitles = true
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.backgroundColor = .white
        window!.rootViewController = rootViewController
        window!.makeKeyAndVisible()
        
        // Override point for customization after application launch.
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


}

