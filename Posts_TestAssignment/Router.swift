//
//  Router.swift
//  Posts_TestAssignment
//
//  Created by Maxym Bilyk on 30.08.2023.
//

import UIKit

final class Router {
    private weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController? = nil) {
        self.navigationController = navigationController
    }
    
    func showPostsScreenAsRootController() {
        navigationController?.setViewControllers([PostsUIComposer.build(router: self)], animated: true)
    }
}
