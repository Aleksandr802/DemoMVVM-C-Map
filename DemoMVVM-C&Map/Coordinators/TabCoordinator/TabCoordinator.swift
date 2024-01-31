//
//  MainCoordinator.swift
//  DemoMVVM-C&Map
//
//  Created by Oleksandr Seminov on 1/26/24.
//

import UIKit

protocol TabCoordinatorProtocol {
    func start()
}

class TabCoordinator: TabCoordinatorProtocol {
    var rootViewController = UITabBarController()
    
    var childCoordinatr = [TabCoordinatorProtocol]()
    
    init() {
        self.rootViewController = UITabBarController()
        rootViewController.tabBar.isTranslucent = true
        rootViewController.tabBar.backgroundColor = .lightGray
    }
    
    func start() {
        let mapCoordinator = RecreationMapTabCoordinator()
        mapCoordinator.start()
        self.childCoordinatr.append(mapCoordinator)
        let mapViewController = mapCoordinator.rootViewController
        setup(vc: mapViewController,
              title: "Map",
              imageName: "map",
              selectedImageName: "map.fill")
        
        let listCoordinator = ListTabCoordinator()
        listCoordinator.start()
        self.childCoordinatr.append(listCoordinator)
        let listViewController = listCoordinator.rootViewController
        listViewController.view.backgroundColor = .green
        setup(vc: listViewController,
              title: "List",
              imageName: "paperplane",
              selectedImageName: "paperplane.fill")
        
        let profileCoordinator = ProfileTabCoordinator()
        profileCoordinator.start()
        self.childCoordinatr.append(profileCoordinator)
        let profileViewController = profileCoordinator.rootViewController
        profileViewController.view.backgroundColor = .blue
        setup(vc: profileViewController,
              title: "Profile",
              imageName: "gearshape",
              selectedImageName: "gearshape.fill")
        
        self.rootViewController.viewControllers = [mapViewController,
                                                   listViewController,
                                                   profileViewController]
    }
    
    func setup(vc: UIViewController, title: String, imageName: String, selectedImageName: String) {
        let defaultImage = UIImage(systemName: imageName)
        let selectedImage = UIImage(systemName: selectedImageName)
        let tabBarItem = UITabBarItem(title: title, image: defaultImage, selectedImage: selectedImage)
        
        vc.tabBarItem = tabBarItem
        
    }
}
