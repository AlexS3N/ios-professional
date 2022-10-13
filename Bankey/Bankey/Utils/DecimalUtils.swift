//
//  DecimalUtils.swift
//  Bankey
//
//  Created by Mac on 18.10.22.
//

import Foundation

extension Decimal {
    var doubleValue: Double {
        return NSDecimalNumber(decimal:self).doubleValue
    }
}
