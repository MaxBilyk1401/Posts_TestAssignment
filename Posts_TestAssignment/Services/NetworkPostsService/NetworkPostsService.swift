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
                } catch {
                    print(error)
                }
            case let .failure(error):
                print(error)
            }
    }
        
        
        
        //        provider.request(.posts) { result in
        //            switch result {
        //            case .success(let result):
        //                do {
        //                    let result = try JSONDecoder().decode(NetworkPostsResponse.self, from: result.data)
        //                    let buissnesModel = result.result.map { model in PostsModel(from: model as! Decoder) }
        //                    completion(.success(buissnesModel))
        //                } catch {
        //                    completion(.failure(error))
        //                }
        //            case .failure(let error):
        //                completion(.failure(error))
        //            }
        //        }
    }
}
