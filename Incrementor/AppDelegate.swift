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
    
    lazy private var assembler = makeAssembler()

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
        ) -> Bool
    {
        let r = assembler.resolver
        let rootViewController = UINavigationController()
        rootViewController.viewControllers = [r.resolve(MenuViewControllering.self)!.controller]
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

extension AppDelegate {
    func makeAssembler() -> Assembler {
        return Assembler([
            ServicesAssembley(),
            MenuAssembley(),
            IncrementAssembley(),
            ConfigurationAssembley(),
        ])
    }
}

