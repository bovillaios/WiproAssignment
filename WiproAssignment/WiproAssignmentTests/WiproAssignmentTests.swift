//
//  WiproAssignmentTests.swift
//  WiproAssignmentTests
//
//  Created by GGKU5MACBOOK003 on 09/03/19.
//  Copyright © 2019 Ramgopal. All rights reserved.
//

import XCTest
@testable import WiproAssignment

class WiproAssignmentTests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testFetchFactDataFromAPI() {
        
        let expectations = expectation(description: "Response result matched")
        
        FactService.fetchFactData {(success, fact) in
            
            if !success {
                XCTFail()
            }
            
            if success {
                XCTAssertNotNil(fact, "Data is nil")
            }
            expectations.fulfill()
        }
        
        waitForExpectations(timeout: 2) { (error) in
            if error != nil {
                XCTFail()
            }
        }
    }
}
