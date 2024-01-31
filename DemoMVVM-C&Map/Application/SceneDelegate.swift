//
//  SceneDelegate.swift
//  DemoMVVM-C&Map
//
//  Created by Oleksandr Seminov on 1/26/24.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var appCoordinator: AppCoordinator?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        
        let appCoordinator = AppCoordinator(window: window)
        appCoordinator.start()
        
        self.appCoordinator = appCoordinator
        window.makeKeyAndVisible()
    }
}

