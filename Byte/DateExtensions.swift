//
//  DateExtensions.swift
//  Byte
//
//  Created by Kyle McAlpine on 05/02/2017.
//  Copyright © 2017 Kyle McAlpine. All rights reserved.
//

import Foundation

let df: DateFormatter = {
    let df = DateFormatter()
    df.dateFormat = "yyyy-MM-dd"
    return df
}()

extension Date {
    var jsonString: String {
        return df.string(from: self)
    }
    
    init?(jsonString: String) {
        guard let date = df.date(from: jsonString) else { return nil }
        self = date
    }
}
