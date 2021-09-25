//
//  JokesListViewModelSpec.swift
//  ICNDbTests
//
//  Created by Zak Barlow on 25/09/2021.
//

import XCTest
@testable import ICNDb

class JokesListViewModelSpec: XCTestCase {
    
    var viewModel: JokesListViewModel!
    var mockDataService: MockDataService!

    override func setUp() {
        mockDataService = MockDataService()
        viewModel = .init(dataFetchable: mockDataService)
    }
    
    func testJokeSuccessCase() {
        mockDataService.joke = "Test Joke"
        
        viewModel.fetchMoreJokes()
        
        XCTAssertTrue(!viewModel.jokes.isEmpty)
        XCTAssertNil(viewModel.error)
        XCTAssertEqual(viewModel.jokes.first, mockDataService.joke)
        XCTAssertEqual(viewModel.error?.localizedDescription, mockDataService.error?.localizedDescription)
    }
    
    func testJokeErrorCase() {
        mockDataService.error = NSError(domain: "Test Error", code: 0, userInfo: nil)

        viewModel.fetchMoreJokes()

        XCTAssertNotNil(viewModel.error)
        XCTAssertTrue(viewModel.jokes.isEmpty)
        XCTAssertEqual(viewModel.jokes.first, mockDataService.joke)
        XCTAssertEqual(viewModel.error?.localizedDescription, mockDataService.error?.localizedDescription)
    }
}
