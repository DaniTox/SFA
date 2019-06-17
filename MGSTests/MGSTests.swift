//
//  MGSTests.swift
//  MGSTests
//
//  Created by Dani Tox on 17/06/2019.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import XCTest

class MGSTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetDiocesi() {
        let siteLocalizer = SiteLocalizer()
        siteLocalizer.getDiocesi { (diocesi) in
            XCTAssert(diocesi.count > 0)
        }
    }
    
    func testGetCities() {
        let siteLocalizer = SiteLocalizer()
        siteLocalizer.getCitta { (cities) in
            XCTAssert(cities.count > 0)
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
