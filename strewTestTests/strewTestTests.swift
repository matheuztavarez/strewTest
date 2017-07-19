//
//  strewTestTests.swift
//  strewTestTests
//
//  Created by Matheus on 18/07/17.
//  Copyright © 2017 Matheus Tavares. All rights reserved.
//

import XCTest
import RealmSwift
@testable import strewTest

class strewTestTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
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
    
//    let testRealmURL = URL(fileURLWithPath: "...")
    
//    func testThatUserIsUpdatedFromServer() {
//        let config = Realm.Configuration(fileURL: testRealmURL)
//        let testRealm = try! Realm(configuration: config)
//        let jsonData = "{\"email\": \"help@realm.io\"}".data(using: .utf8)!
//        createOrUpdateUser(in: testRealm, with: jsonData)
//        let expectedUser = User()
//        expectedUser.email = "help@realm.io"
//        XCTAssertEqual(testRealm.objects(User.self).first!, expectedUser,
//                       "User was not properly updated from server.")
//    }
    
}
