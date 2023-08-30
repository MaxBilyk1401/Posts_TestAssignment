//
//  PostsService.swift
//  Posts_TestAssignment
//
//  Created by Maxym Bilyk on 30.08.2023.
//

import Foundation

protocol PostsService {
    func loadData(completion: @escaping (Result<[PostModel], Error>) -> Void)
}
