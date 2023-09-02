//
//  BeautyDictionaryScreenCoordinator.swift
//  Sisters Staging
//
//  Created by Developer on 03.08.2023.
//

import UIKit

class BeautyDictionaryCoordinator: ChildCoordinator {
    
    var parentCoordinator: Coordinator
    var childCoordinators: [Coordinator]
    var navigationController: UINavigationController
    
    required init(parentCoordinator: Coordinator, parentNavigation: UINavigationController?) {
        self.parentCoordinator = parentCoordinator
        self.navigationController = parentNavigation ?? UINavigationController()
        childCoordinators = []
    }
    deinit {
        print("UserProfileCoordinator deinited")
    }
    
    func start() {
        let viewModel = BeautyDictionaryViewModel()
        let viewController = BeautyDictionaryViewController(viewModel: viewModel)
        viewModel.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func navidateToLoginedUserMenuScreen() {
        navigationController.popViewController(animated: true)
    }
}
