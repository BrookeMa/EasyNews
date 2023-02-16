//
//  Date+Helpers.swift
//  EasyNews
//
//  Created by Ye Ma on 16/02/2023.
//

import Foundation

public extension Date {
   func timeAgoDisplay() -> String {
       let formatter = RelativeDateTimeFormatter()
       formatter.unitsStyle = .full
       return formatter.localizedString(for: self, relativeTo: Date())
   }
}
