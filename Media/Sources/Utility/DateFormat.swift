//
//  DateFormat.swift
//  Media
//
//  Created by gnksbm on 6/10/24.
//

import Foundation

enum DateFormat: String {
    private static var cachedStorage = [DateFormat: DateFormatter]()
    
    case trendingItemInput = "yyyy-MM-dd"
    case trendingItemOutput = "MM/dd/yyyy"
    
    var formatter: DateFormatter {
        if let formatter = Self.cachedStorage[self] {
            return formatter
        } else {
            let newFormatter = DateFormatter()
            newFormatter.dateFormat = self.rawValue
            newFormatter.locale = Locale(identifier: "ko_KR")
            Self.cachedStorage[self] = newFormatter
            return newFormatter
        }
    }
}

extension String {
    func formatted(dateFormat: DateFormat) -> Date? {
        dateFormat.formatter.date(from: self)
    }
    
    func formatted(input: DateFormat, output: DateFormat) -> Self? {
        formatted(dateFormat: input)?.formatted(dateFormat: output)
    }
}

extension Date {
    func formatted(dateFormat: DateFormat) -> String {
        dateFormat.formatter.string(from: self)
    }
}

