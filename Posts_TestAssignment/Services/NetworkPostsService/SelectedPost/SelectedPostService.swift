//
//  SelectedPostService.swift
//  Posts_TestAssignment
//
//  Created by Maxym Bilyk on 04.09.2023.
//

import Foundation

protocol SelectedPostService {
    func loadData(postId: String, completion: @escaping (Result<SelectedPostModel, Error>) -> Void)
}
