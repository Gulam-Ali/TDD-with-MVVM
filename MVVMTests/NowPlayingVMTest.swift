//
//  MVVMTests.swift
//  MVVMTests
//
//  Created by Gulam Ali on 31/03/22.
//

import XCTest
@testable import MVVM

class MVVMTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    

    func test_EmptyMovieArray(){
        let sut = NowPlayingVM(eligible: dummyEligibleCriteria())
        let mockResult = NowplayingModel(results: [])
        XCTAssertTrue(sut.checkifMovieArrayEmpty(movies: mockResult.results!))
    }
    
    func test_DescendingOrderMovies(){
        let sut = NowPlayingVM(eligible: dummyEligibleCriteria())
        sut.delegate = self
        let result1 = resultsModel(adult: nil, backdrop_path: nil, id: nil, overview: nil, poster_path: nil, title: nil, vote_average: 3.9, vote_count: nil)
        let result2 = resultsModel(adult: nil, backdrop_path: nil, id: nil, overview: nil, poster_path: nil, title: nil, vote_average: 5.5, vote_count: nil)
        let Mockresults : [resultsModel] = [result1,result2]
        XCTAssertEqual([result2,result1], sut.FilterMoviesByRating(movies: Mockresults))
    }
    
    func test_CheckTicketState(){
        let sut = NowPlayingVM(eligible: dummyEligibleCriteria())
        XCTAssertEqual("Sold Out", sut.checkTicketStatus())
    }
    
    
}


extension MVVMTests : NowPlayingProtocol{}

class dummyEligibleCriteria : EligibilityCriteriaProtocol{
    
    func checkIfUserIseligibletoBookTicket() -> Bool {
        return false
    }
    
    
}
