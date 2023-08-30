//
//  NetworkPostsResponse.swift
//  Posts_TestAssignment
//
//  Created by Maxym Bilyk on 30.08.2023.
//

import Foundation

struct NetworkPostsResponse: Decodable {
    let posts: [PostModel]
}
