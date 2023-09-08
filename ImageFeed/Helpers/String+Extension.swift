//
//  String+Extension.swift
//  ImageFeed
//
//  Created by Iurii on 04.09.23.
//

import Foundation

extension String {
    var dateTimeString: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter.date(from: self)
    }
}
