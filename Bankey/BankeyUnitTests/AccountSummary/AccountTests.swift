//
//  AccountTests.swift
//  BankeyUnitTests
//
//  Created by Mac on 27.10.22.
//

import Foundation
import XCTest

@testable import Bankey

class AccountTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    func testCanParse() throws {
        let json = """
         [
           {
             "id": "1",
             "type": "Banking",
             "name": "Basic Savings",
             "amount": 929466.23,
             "createdDateTime" : "2010-06-21T15:29:32Z"
           },
           {
             "id": "2",
             "type": "Banking",
             "name": "No-Fee All-In Chequing",
             "amount": 17562.44,
             "createdDateTime" : "2011-06-21T15:29:32Z"
           },
          ]
        """

        // Game on here 🕹
        let data = json.data(using: .utf8)!
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let accounts = try! decoder.decode([Account].self, from: data)
        
        XCTAssertEqual(accounts.count, 2)
        
        XCTAssertEqual(accounts[0].id, "1")
        XCTAssertEqual(accounts[0].type, AccountType.Banking)
        XCTAssertEqual(accounts[0].name, "Basic Savings")
        XCTAssertEqual(accounts[0].amount, 929466.23)
        XCTAssertEqual(accounts[0].createdDateTime.monthDayYearString, "июня 21, 2010")
        
        
    }
}
