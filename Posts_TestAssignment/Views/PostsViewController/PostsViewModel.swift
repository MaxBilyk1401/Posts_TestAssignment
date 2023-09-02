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
    
    private var posts: [PostModel] = []
    private var isSortDescendingByLike = false
    private var isSortDescendingByDate = false
    
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
                    self.posts = success
                case .failure:
                    self.onFailure?("OK")
                }
                self.onLoading?(false)
            }
        }
    }
    
    func reloadFilterDataByLikesDescending() {
        let results = sortPostsByLikesDescending(posts)
        onLoadSuccess?(results)
    }
    
    func reloadFilterDataByTimestampDescending() {
        let results = sortPostsByTimestampDescending(posts)
        onLoadSuccess?(results)
    }
    
    
    
    private func sortPostsByLikesDescending(_ posts: [PostModel]) -> [PostModel] {
        isSortDescendingByLike.toggle()
        
        if isSortDescendingByLike {
            return posts.sorted { $0.likesCount > $1.likesCount }
        } else {
            return posts.sorted { $0.likesCount < $1.likesCount }
        }
    }
    
    private func sortPostsByTimestampDescending(_ posts: [PostModel]) -> [PostModel] {
        isSortDescendingByDate.toggle()
        
        if isSortDescendingByDate {
            return posts.sorted { $0.timeshamp > $1.timeshamp }
        } else {
            return posts.sorted { $0.timeshamp < $1.timeshamp }
        }
    }
}
