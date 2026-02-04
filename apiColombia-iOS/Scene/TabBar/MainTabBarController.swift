//
//  MainTabBarController.swift
//  apiColombia-iOS
//
//  Created by Joan on 3/02/26.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupAppearance()
    }
    
    private func setup() {
        let home = createTab(viewController: HomeViewController(), title: "Inicio", img: "house")
        
        let departments = createTab(viewController: DepartmentsViewController(), title: "Departamentos", img: "list.bullet")
        
        let region = createTab(viewController: RegionViewController(), title: "Region", img: "list.bullet")
        
        self.viewControllers = [home, departments, region]
    }
    
    private func createTab(viewController: UIViewController, title: String, img: String) -> UIViewController {
        
        let nav = UINavigationController(rootViewController: viewController)
        nav.tabBarItem.image = UIImage(named: img)?.withRenderingMode(.alwaysOriginal)

        nav.tabBarItem.image = UIImage(systemName: img)
        nav.tabBarItem.selectedImage = UIImage(systemName: img + ".fill")
        viewController.title = title
        viewController.view.backgroundColor = .white
        return nav
    }
    
    private func setupAppearance() {
        tabBar.tintColor = .systemBlue
        tabBar.backgroundColor = .systemBackground
    }
}
