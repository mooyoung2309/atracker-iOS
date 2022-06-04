//
//  AppDelegate.swift
//  Atracker
//
//  Created by 송영모 on 2022/05/18.
//

import UIKit
import RIBs

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

            let window = UIWindow(frame: UIScreen.main.bounds)
            self.window = window

            let launchRouter = RootBuilder(dependency: AppComponent()).build()
            self.launchRouter = launchRouter

            launchRouter.launch(from: window)

            return true
        }

        // MARK: - Private

        private var launchRouter: LaunchRouting?
    
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        // Override point for customization after application launch.
//        if #available(iOS 15.0, *) {
//                let appearance = UITabBarAppearance()
//                appearance.configureWithOpaqueBackground()
//
//                //바꾸고 싶은 색으로 backgroundColor를 설정
//            UITabBar.appearance().backgroundColor = .backgroundGray
//                }
//                return true
//        return true
//    }
//
//    // MARK: UISceneSession Lifecycle
//
//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//    }
//
//    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//
//    }


}

