//
//  NightValeTests.swift
//  NightValeTests
//
//  Created by Brigitte Warner on 9/25/18.
//  Copyright © 2018 Brigitte Warner. All rights reserved.
//

import XCTest
@testable import NightVale

class NightValeTests: XCTestCase {
    
    static let testBundle = Bundle(for:NightValeTests.self)
    fileprivate var mockSession: MockSession!
    
    let weatherURL = testBundle.url(forResource: "weather", withExtension: "json")!
    
    func JSONData(from url: URL) -> Data? {
        do {
            return try Data(contentsOf: url)
        } catch {
            return nil
        }
    }
    
    var client: MockHTTPClient!
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testThatClientCanGETWeather() {
        guard let expectedData = JSONData(from: weatherURL) else {
            XCTFail("Failed to get people data.")
            return
        }
        var receivedData: Data!
        mockSession = mockSession(data: expectedData)
        client = MockHTTPClient(session: mockSession)
        
        client.get(.forecast) { (data, _, _) in
            receivedData = data
        }
        
        XCTAssertEqual(receivedData, expectedData, "The `Data` should match.")
    }
    
    fileprivate class MockSession: MockURLSession {
        let dataTask = MockDataTask()
        let data: Data
        
        init(data: Data) {
            self.data = data
        }
        
        fileprivate func dataTask(with url: URL,
                                  completionHandler: @escaping (Data?, URLResponse?, Error?)
            -> Void)
            -> MockURLSessionDataTask {
                completionHandler(data, nil, nil)
                return dataTask
        }
    }
    
    fileprivate class MockDataTask: MockURLSessionDataTask {
        func resume() {}
    }
}
