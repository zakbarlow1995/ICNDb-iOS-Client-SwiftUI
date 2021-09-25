//
//  CharacterInputViewModelSpec.swift
//  ICNDbTests
//
//  Created by Zak Barlow on 25/09/2021.
//

import XCTest
@testable import ICNDb

class CharacterInputViewModelSpec: XCTestCase {

    
    var viewModel: CharacterInputViewModel!
    var mockDataService: MockDataService!

    override func setUp() {
        mockDataService = MockDataService()
        viewModel = .init(dataFetchable: mockDataService)
    }
    
    func testJokeSuccessCase() {
        mockDataService.joke = "Test Joke"
        viewModel.firstName = "Test"
        viewModel.lastName = "Character"
        viewModel.fetchJoke()
        
        XCTAssertNotNil(viewModel.joke)
        XCTAssertNil(viewModel.error)
        XCTAssertEqual(viewModel.joke, mockDataService.joke)
        XCTAssertEqual(viewModel.error?.localizedDescription, mockDataService.error?.localizedDescription)
    }
    
    func testJokeErrorCase() {
        mockDataService.error = NSError(domain: "Test Error", code: 0, userInfo: nil)
        viewModel.firstName = "Test"
        viewModel.lastName = "Character"
        viewModel.fetchJoke()
        
        XCTAssertNotNil(viewModel.error)
        XCTAssertNil(viewModel.joke)
        XCTAssertEqual(viewModel.joke, mockDataService.joke)
        XCTAssertEqual(viewModel.error?.localizedDescription, mockDataService.error?.localizedDescription)
    }
    
    func testInvalidUserInputNeither() {
        mockDataService.joke = "Test Joke"
        viewModel.fetchJoke()
        
        XCTAssertNil(viewModel.joke)
        XCTAssertNotNil(viewModel.error)
        XCTAssertNotEqual(viewModel.joke, mockDataService.joke)
        XCTAssertNotEqual(viewModel.error?.localizedDescription, mockDataService.error?.localizedDescription)
    }
    
    func testInvalidUserInputNoFirstName() {
        mockDataService.joke = "Test Joke"
        viewModel.lastName = "Character"
        viewModel.fetchJoke()
        
        XCTAssertNil(viewModel.joke)
        XCTAssertNotNil(viewModel.error)
        XCTAssertNotEqual(viewModel.joke, mockDataService.joke)
        XCTAssertNotEqual(viewModel.error?.localizedDescription, mockDataService.error?.localizedDescription)
    }
    
    func testInvalidUserInputNoLastName() {
        mockDataService.joke = "Test Joke"
        viewModel.firstName = "Test"
        viewModel.fetchJoke()
        
        XCTAssertNil(viewModel.joke)
        XCTAssertNotNil(viewModel.error)
        XCTAssertNotEqual(viewModel.joke, mockDataService.joke)
        XCTAssertNotEqual(viewModel.error?.localizedDescription, mockDataService.error?.localizedDescription)
    }
    
    func testInvalidUserInputIllegalCharsFirstName() {
        mockDataService.joke = "Test Joke"
        viewModel.firstName = "!@£$%^&*()(*&^%$ Test"
        viewModel.lastName = "Character"
        viewModel.fetchJoke()
        
        XCTAssertNil(viewModel.joke)
        XCTAssertNotNil(viewModel.error)
        XCTAssertNotEqual(viewModel.joke, mockDataService.joke)
        XCTAssertNotEqual(viewModel.error?.localizedDescription, mockDataService.error?.localizedDescription)
    }
    
    func testInvalidUserInputIllegalCharsLastName() {
        mockDataService.joke = "Test Joke"
        viewModel.firstName = "Test"
        viewModel.lastName = "Character'"
        viewModel.fetchJoke()
        
        XCTAssertNil(viewModel.joke)
        XCTAssertNotNil(viewModel.error)
        XCTAssertNotEqual(viewModel.joke, mockDataService.joke)
        XCTAssertNotEqual(viewModel.error?.localizedDescription, mockDataService.error?.localizedDescription)
    }
}
