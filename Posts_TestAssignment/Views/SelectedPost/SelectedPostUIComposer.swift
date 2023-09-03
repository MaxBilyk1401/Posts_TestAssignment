//
//  SelectedPostUIComposer.swift
//  Posts_TestAssignment
//
//  Created by Maxym Bilyk on 03.09.2023.
//

import UIKit

enum SelectedPostUIComposer {
    
    static func build(router: Router, postId: String) -> UIViewController {
        let service = NetworkSelectedPostService()
        let viewModel = SelectedPostViewModel(selectedPostService: service, postId: postId)
        return SelectedPostViewController(router: router, viewModel: viewModel)
    }
}
