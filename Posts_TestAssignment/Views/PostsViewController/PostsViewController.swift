//
//  PostsViewController.swift
//  Posts_TestAssignment
//
//  Created by Maxym Bilyk on 30.08.2023.
//

import UIKit

final class PostsViewController: UIViewController {
    private var router: Router
    private var viewModel: PostsViewModel
    
    init(router: Router, viewModel: PostsViewModel) {
        self.router = router
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
}
