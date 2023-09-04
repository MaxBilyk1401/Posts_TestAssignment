//
//  SelectedPostModel.swift
//  Posts_TestAssignment
//
//  Created by Maxym Bilyk on 03.09.2023.
//

import Foundation

struct SelectedPostModel: Decodable {
    let postId: Int
    let timeshamp: Date
    let title: String
    let text: String
    let postImage: String
    let likesCount: Int

    enum CodingKeys: String, CodingKey {
        case postId
        case timeshamp
        case title
        case text
        case postImage
        case likesCount = "likes_count"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.postId = try container.decode(Int.self, forKey: .postId)
        self.title = try container.decode(String.self, forKey: .title)
        self.text = try container.decode(String.self, forKey: .text)
        self.postImage = try container.decode(String.self, forKey: .postImage)
        self.likesCount = try container.decode(Int.self, forKey: .likesCount)
        
        let timeshampValue = try container.decode(Int.self, forKey: .timeshamp)
        timeshamp = Date(timeIntervalSince1970: TimeInterval(timeshampValue))
    }
}
