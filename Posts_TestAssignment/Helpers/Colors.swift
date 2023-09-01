//
//  Colors.swift
//  Posts_TestAssignment
//
//  Created by Maxym Bilyk on 01.09.2023.
//

import Foundation

enum Colors {
    case title
    case subTitle
    case plainText
    case accent
    case calendar
    
    var name: String {
        switch self {
        case .title:
            return "000000"
        case .subTitle:
            return "0F1419"
        case .plainText:
            return "536471"
        case .accent:
            return "E90808"
        case .calendar:
            return "027BCD"
        }
    }
}
