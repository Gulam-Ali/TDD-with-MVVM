//
//  EndpointTest.swift
//  MVVMTests
//
//  Created by Gulam Ali on 31/03/22.
//

import XCTest
@testable import MVVM

class EndpointTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_BaseUrl(){
        XCTAssertEqual(Endpoints.baseurl, "https://api.themoviedb.org/3/")
    }
 
    func test_API_Key(){
        XCTAssertEqual(Api_Key.key, "a07e22bc18f5cb106bfe4cc1f83ad8ed")
    }
    

}
