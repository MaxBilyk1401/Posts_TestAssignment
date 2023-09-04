//
//  NetworkSelectedPostService.swift
//  Posts_TestAssignment
//
//  Created by Maxym Bilyk on 04.09.2023.
//

import Foundation
import Moya

struct NetworkSelectedPostService: SelectedPostService {
    let provider = MoyaProvider<LoadService>()
    
    func loadData(postId: String, completion: @escaping (Result<SelectedPostModel, Error>) -> Void) {
        self.provider.request(.selectedPost(postId: postId)) { result in
            switch result {
            case let .success(response):
                do {
                    let posts = try JSONDecoder().decode(NetworkSelectedPostsResponse.self, from: response.data)
                    let response = posts.post
//                    print(response)
                    completion(.success(response))
                } catch {
                    completion(.failure(error))
                    print(error)
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
