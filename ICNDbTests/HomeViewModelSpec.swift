//
//  HomeViewModelSpec.swift
//  ICNDbTests
//
//  Created by Zak Barlow on 25/09/2021.
//

import XCTest
@testable import ICNDb

class HomeViewModelSpec: XCTestCase {
    
    var viewModel: HomeViewModel!
    var mockDataService: MockDataService!

    override func setUp() {
        mockDataService = MockDataService()
        viewModel = .init(dataFetchable: mockDataService)
    }
    
    func testJokeSuccessCase() {
        mockDataService.joke = "Test Joke"
        
        viewModel.fetchJoke()
        
        XCTAssertNotNil(viewModel.joke)
        XCTAssertNil(viewModel.error)
        XCTAssertEqual(viewModel.joke, mockDataService.joke)
        XCTAssertEqual(viewModel.error?.localizedDescription, mockDataService.error?.localizedDescription)
    }
    
    func testJokeErrorCase() {
        mockDataService.error = NSError(domain: "Test Error", code: 0, userInfo: nil)
        
        viewModel.fetchJoke()
        
        XCTAssertNotNil(viewModel.error)
        XCTAssertNil(viewModel.joke)
        XCTAssertEqual(viewModel.joke, mockDataService.joke)
        XCTAssertEqual(viewModel.error?.localizedDescription, mockDataService.error?.localizedDescription)
    }
}
