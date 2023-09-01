//
//  Images.swift
//  Posts_TestAssignment
//
//  Created by Maxym Bilyk on 01.09.2023.
//

import Foundation

enum Images {
    case heart
    case calendar

    var name: String {
        switch self {
        case .heart:
            return "heart"
        case .calendar:
            return "calendar"
        }
    }
}
