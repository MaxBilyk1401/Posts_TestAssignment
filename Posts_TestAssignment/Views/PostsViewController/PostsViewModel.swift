//
//  PostsViewModel.swift
//  Posts_TestAssignment
//
//  Created by Maxym Bilyk on 30.08.2023.
//

import Foundation

final class PostsViewModel {
    private let postsService: PostsService
    var onLoading: ((Bool) -> Void)?
    var onLoadSuccess: (([PostModel]) -> Void)?
    var onFailure: ((String?) -> Void)?
    
    init(postsService: PostsService) {
        self.postsService = postsService
    }
    
    func fetchData() {
        onLoading?(true)
        onFailure?(nil)
        postsService.loadData { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let success):
                    self.onLoadSuccess?(success)
                case .failure:
                    self.onFailure?("OK")
                }
                self.onLoading?(false)
            }
        }
    }
}
