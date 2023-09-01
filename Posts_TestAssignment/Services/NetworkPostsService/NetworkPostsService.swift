//
//  NetworkPostsService.swift
//  Posts_TestAssignment
//
//  Created by Maxym Bilyk on 30.08.2023.
//

import Foundation
import Moya

struct NetworkPostsService: PostsService {
    let provider = MoyaProvider<LoadService>()
    
    func loadData(completion: @escaping (Result<[PostModel], Error>) -> Void) {
        self.provider.request(.posts) { result in
            switch result {
            case let .success(response):
                do {
                    let posts = try JSONDecoder().decode(NetworkPostsResponse.self, from: response.data)
                    let postsResponse = posts.posts
                    print(postsResponse)
                    completion(.success(postsResponse))
                } catch {
                    print(error)
                    completion(.failure(error))
                }
            case let .failure(error):
                print(error)
                completion(.failure(error))
            }
        }
    }
}
