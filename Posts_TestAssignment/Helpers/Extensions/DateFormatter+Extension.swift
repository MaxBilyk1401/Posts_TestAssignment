//
//  DateFormatter+Extension.swift
//  Posts_TestAssignment
//
//  Created by Maxym Bilyk on 01.09.2023.
//

import Foundation

extension Date {
   func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}
