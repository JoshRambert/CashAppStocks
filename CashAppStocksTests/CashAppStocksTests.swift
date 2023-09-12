//
//  CashAppStocksTests.swift
//  CashAppStocksTests
//
//  Created by Joshua Rambert on 9/9/23.
//

import XCTest
@testable import CashAppStocks

final class CashAppStocksTests: XCTestCase {

    var service: HTTPService?

    override func setUpWithError() throws {
        service = HTTPService()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        service = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testHealthyPortfolio() {
        
        service?.retrievePortfolio(for: .healthy, { (stocksCompletion) in
            switch stocksCompletion {
            case .success(let _stocks):
                XCTAssertNotNil(_stocks.stocks)
                XCTAssertFalse(_stocks.stocks.isEmpty)
            case .failure(let _error):
                XCTFail("Should have retrieved stocks \(_error.localizedDescription)")
            }
        })
    }
    
    func testMalformedPortfolio() {

        service?.retrievePortfolio(for: .malformed, { (stocksCompletion) in
            switch stocksCompletion {
            case .success(let _stocks):
                XCTFail("Should not have parsed this JSON \(_stocks)")
            case .failure(let _error):
                XCTAssertNotNil(_error)
                XCTAssertTrue(_error == .responseSerializationFailed(reason: .jsonSerializationFailed(error: _error)))
            }
        })
    }
    
    func testEmptyPortfolio() {
        
        service?.retrievePortfolio(for: .empty, { (stocksCompletion) in
            switch stocksCompletion {
            case .success(let _stocks):
                XCTAssertNotNil(_stocks.stocks)
                XCTAssertTrue(_stocks.stocks.isEmpty)
            case .failure(let _error):
                XCTFail("Should have retrieved empty stocks \(_error.localizedDescription)")
            }
        })
    }
}
