//
//  MapTabCoordinator.swift
//  DemoMVVM-C&Map
//
//  Created by Oleksandr Seminov on 1/26/24.
//

import UIKit
import SwiftUI

class RecreationMapTabCoordinator: NSObject, TabCoordinatorProtocol {
    var rootViewController = UIViewController()
    
    func start() {
        rootViewController = UIHostingController(rootView: RecreationMapView())
    }
}
