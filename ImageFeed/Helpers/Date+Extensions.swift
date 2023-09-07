//
//  Date+Extensions.swift
//  ImageFeed
//
//  Created by Iurii on 18.07.23.
//

import Foundation

var dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .none
    return formatter
}()

extension Date {
    var dateTimeString: String { dateFormatter.string(from: self) }
}
