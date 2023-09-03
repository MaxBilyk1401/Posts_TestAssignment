//
//  SelectedPostViewModel.swift
//  Posts_TestAssignment
//
//  Created by Maxym Bilyk on 03.09.2023.
//

import Foundation

final class SelectedPostViewModel {
    private let selectedPostService: SelectedPostService
    private let postId: String
    
    var onLoading: ((Bool) -> Void)?
    var onLoadSuccess: ((SelectedPostModel) -> Void)?
    var onFailure: ((String?) -> Void)?
    
    init(selectedPostService: SelectedPostService, postId: String) {
        self.selectedPostService = selectedPostService
        self.postId = postId
    }
    
    func fetchData() {
        onLoading?(true)
        onFailure?(nil)
        selectedPostService.loadData(postId: postId) { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let success):
                    self.onLoadSuccess?(success)
                    print(success)
//                    self.posts = success
                case .failure(let error):
                    print(error)
                    self.onFailure?("OK")
                }
                self.onLoading?(false)
            }
        }
    }
}
