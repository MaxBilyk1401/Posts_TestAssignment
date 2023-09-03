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
}
