//
//  String+Extensions.swift
//  Rest API
//
//  Created by Matheus Ribeiro on 16/02/22.
//

import Foundation

extension String {
    func convertDateFormater() -> String {
        var fixDate = ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let newDate = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = "dd.MM.yyyy"
            fixDate = dateFormatter.string(from: newDate)
        }
        return fixDate
    }
}
