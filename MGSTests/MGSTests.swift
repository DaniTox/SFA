//
//  MGSTests.swift
//  MGSTests
//
//  Created by Dani Tox on 17/06/2019.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

@testable import MGS
import XCTest

class MGSTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetDiocesi() {
        let semaphore = DispatchSemaphore(value: 1)
        
        let siteLocalizer = SiteLocalizer()
        siteLocalizer.getDiocesi { (diocesi) in
            print(diocesi.count)
            XCTAssert(diocesi.count > 0)
            semaphore.signal()
        }
        semaphore.wait()
        
    }
    
    func testGetCities() {
        var arr: [CityCodable] = []
        
        let siteLocalizer = SiteLocalizer()
        let expect = self.expectation(description: "Fetching")
        
        siteLocalizer.errorHandler = { err in
            XCTFail("SiteLocalizer ha ritornato un errore: \(err)")
        }
        
        siteLocalizer.getCitta { (cities) in
            arr = cities
            expect.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        print(arr.count)
        XCTAssert(arr.count > 0)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
