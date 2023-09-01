//
//  PostsUIComposer.swift
//  Posts_TestAssignment
//
//  Created by Maxym Bilyk on 30.08.2023.
//

import UIKit

enum PostsUIComposer {
    
    static func build(router: Router) -> UIViewController {
        let service = NetworkPostsService()
        let viewModel = PostsViewModel(postsService: service)
        return PostsViewController(router: router, viewModel: viewModel)
    }
}
