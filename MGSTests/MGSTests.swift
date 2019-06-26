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
        siteLocalizer.getDiocesi(saveRecords: false) { (diocesi) in
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
        
        siteLocalizer.getCitta(saveRecords: false) { (cities) in
            arr = cities
            expect.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        print(arr.count)
        XCTAssert(arr.count > 0)
    }

    func testPathGen() {
        let baseUrl: String = "http://localhost:5000/example"
        
        let right1 = "http://localhost:5000/example?testKey=testValue&key2=0"
        let right2 = "http://localhost:5000/example?key2=0&testKey=testValue"
        
        let args: [String: String] = ["testKey":"testValue", "key2":"0" ]
        
        let fullPath = NetworkAgent<String>.getFullPath(from: baseUrl, with: args)
        
        print(fullPath)
        XCTAssert(fullPath == right1 || fullPath == right2)
        
    }
    
    func testPathGenEmptyArgs() {
        let baseUrl: String = "http://localhost:5000/example"
        
        let right1 = "http://localhost:5000/example?key=value"
        
        let args: [String: String] = ["key":"value", "":"0" ]
        
        let fullPath = NetworkAgent<String>.getFullPath(from: baseUrl, with: args)
        
        print(fullPath)
        XCTAssert(fullPath == right1)
    }
    
    func testPathGenEmptyArgs2() {
        let baseUrl: String = "http://localhost:5000/example"
        
        let right1 = "http://localhost:5000/example"
        
        let args: [String: String] = ["key":"", "":"0" ]
        
        let fullPath = NetworkAgent<String>.getFullPath(from: baseUrl, with: args)
        
        print(fullPath)
        XCTAssert(fullPath == right1)
    }
    
    func testListYears() {
        let agent = TSFAgent()
        let dates = agent.getYearsList(basedOn: Date())
        
        XCTAssert(dates.count == 1)
        
        let dates2 = agent.getYearsList(basedOn: Date.create(from: "17/10/2000")!)
        XCTAssert(dates2.count == 20)
        
    }
    
    func testListMonths() {
        let agent = TSFAgent()
        
        let thisYear = Calendar.current.component(.year, from: Date())
        
        let list1 = agent.getMonthsList(for: thisYear)
        XCTAssert((list1.last ?? 0) ==  Calendar.current.component(.month, from: Date()))
        
        let list2 = agent.getMonthsList(for: (thisYear + 1))
        XCTAssert(list2.isEmpty)
        
        let list3 = agent.getMonthsList(for: 2018)
        XCTAssert(list3.count == 12)
    }
    
}
