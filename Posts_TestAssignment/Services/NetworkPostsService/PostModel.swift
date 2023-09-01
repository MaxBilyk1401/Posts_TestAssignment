//
//  PostsModel.swift
//  Posts_TestAssignment
//
//  Created by Maxym Bilyk on 30.08.2023.
//

import Foundation

struct PostModel: Decodable {
    let id = UUID()
    let postId: Int
    let timeshamp: Date
    let title: String
    let previewText: String
    let likesCount: Int
    
    enum CodingKeys: String, CodingKey {
        case postId, timeshamp, title
        case previewText = "preview_text"
        case likesCount = "likes_count"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        postId = try container.decode(Int.self, forKey: .postId)
        title = try container.decode(String.self, forKey: .title)
        previewText = try container.decode(String.self, forKey: .previewText)
        likesCount = try container.decode(Int.self, forKey: .likesCount)
        
        let timestampValue = try container.decode(Int.self, forKey: .timeshamp)
        timeshamp = Date(timeIntervalSince1970: TimeInterval(timestampValue))
    }
}
