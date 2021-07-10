//
//  AppDelegate.swift
//  GitHub-API
//
//  Created by Yudai Fujioka on 2021/07/10.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //StoryboardからViewControllerをインスタンス化
        guard let initialViewController = UIStoryboard.init(name: "Initial", bundle: nil).instantiateInitialViewController() as? InitialViewController else {
            fatalError()
        }
        
        //InitialViewControllerをNavigationControllerの最初に指定
        let navigationViewController = UINavigationController.init(rootViewController: initialViewController)
        let window = UIWindow()
        window.rootViewController = navigationViewController
        window.makeKeyAndVisible()
        
        self.window = window
        
        return true
    }
}

