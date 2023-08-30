//
//  PostsUIComposer.swift
//  Posts_TestAssignment
//
//  Created by Maxym Bilyk on 30.08.2023.
//

import UIKit

enum PostsUIComposer {
    
    static func build(router: Router) -> UIViewController {
        let viewModel = PostsViewModel()
        return PostsViewController(router: router, viewModel: viewModel)
    }
}
