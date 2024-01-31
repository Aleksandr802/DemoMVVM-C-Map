//
//  ApplicationCoordinator.swift
//  DemoMVVM-C&Map
//
//  Created by Oleksandr Seminov on 1/26/24.
//

import Combine
import UIKit
import SwiftUI

class AppCoordinator: TabCoordinatorProtocol {
    let window: UIWindow
    
    var childCoordinators = [TabCoordinatorProtocol]()
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let mainCoordinator = TabCoordinator()
        mainCoordinator.start()
        childCoordinators = [mainCoordinator]
        window.rootViewController = mainCoordinator.rootViewController
    }
}
