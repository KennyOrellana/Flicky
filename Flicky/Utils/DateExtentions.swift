//
//  DateExtentions.swift
//  Flicky
//
//  Created by Kenny Orellana on 9/18/20.
//  Copyright © 2020 Kenny Orellana. All rights reserved.
//

import Foundation

extension Double {
    func getDateStringFromUTC() -> String {
        let date = Date(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "MMM dd YYYY"

        return dateFormatter.string(from: date)
    }
}
