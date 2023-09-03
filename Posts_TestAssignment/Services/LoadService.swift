//
//  LoadService.swift
//  Posts_TestAssignment
//
//  Created by Maxym Bilyk on 30.08.2023.
//

import Foundation
import Moya

enum LoadService {
    case posts
    case selectedPost(postId: String)
}

extension LoadService: TargetType {
    var baseURL: URL {
        guard let url = URL(string: "https://raw.githubusercontent.com/anton-natife/jsons/master/api") else {
            fatalError("Invalid URL")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .posts:
            return "/main.json"
        case .selectedPost(let postId):
            return "/posts/\(postId).json"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .posts, .selectedPost:
                return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .posts:
            return .requestPlain
        case .selectedPost:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
