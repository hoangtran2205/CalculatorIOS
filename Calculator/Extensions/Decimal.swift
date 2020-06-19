//
//  Decimal.swift
//  Calculator
//
//  Created by tmhoang1904 on 6/19/20.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation

extension Decimal {
    var int: Int {
        return NSDecimalNumber(decimal: self).intValue
    }
    
    var string: String {
        return NSDecimalNumber(decimal: self).stringValue
    }
    
    var double: Double {
        return NSDecimalNumber(decimal: self).doubleValue
    }
}
