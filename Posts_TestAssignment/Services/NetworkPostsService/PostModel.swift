//
//  PostsModel.swift
//  Posts_TestAssignment
//
//  Created by Maxym Bilyk on 30.08.2023.
//

import Foundation

struct PostModel: Decodable {
    let postId: Int
    let timeshamp: Int
    let title: String
    let previewText: String
    let likesCpunt: Int
    
    enum CodingKeys: String, CodingKey {
        case postId, timeshamp, title
        case previewText = "preview_text"
        case likesCpunt = "likes_count"
    }
}
