//
//  CurrencyFormatterTests.swift
//  BankeyUnitTests
//
//  Created by Mac on 19.10.22.
//

import Foundation
import XCTest

@testable import Bankey

class Test: XCTestCase {
    var formatter: CurrencyFormatter!
    
    override func setUp() {
        super.setUp()
        print("setUp is runned")
        formatter = CurrencyFormatter()
    }
    
    func testShouldBeVisible() throws {
        let result = formatter.breakIntoDollarsAndCents(929466.23)
        XCTAssertEqual(result.0, "929,466")
        XCTAssertEqual(result.1, "23")
    }
    
    func testDollarsFormatted() throws {
        let result = formatter.dollarsFormatted(929466.23)
        XCTAssertEqual(result, "$929,466.23")
    }
    
    func testZeroDollarsFormatted() throws {
        let result = formatter.dollarsFormatted(0.00)
        XCTAssertEqual(result, "$0.00")
    }
    
//    func testDollarsFormattedWithCurrencySymbol() throws {
//        let locale = Locale.current
//        let currentSymbol = locale.currencySymbol!
//        
//        let result = formatter.dollarsFormatted(929466.23)
//        XCTAssertEqual(result, "\(currentSymbol)929,466.23")
//    }
}
