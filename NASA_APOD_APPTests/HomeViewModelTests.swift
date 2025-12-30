//
//  HomeViewModelTests.swift
//  NASA_APOD_APPTests
//
//  Created by admin34 on 30/12/25.
//

import XCTest
@testable import NASA_APOD_APP 

//  Create a Mock Service

class MockAPIService: APIService {
    var shouldReturnError = false
    
    override func fetchAPOD(date: Date? = nil) async throws -> APODItem {
        if shouldReturnError {
            throw URLError(.badServerResponse)
        }
        
        // Return a fake item immediately
        return APODItem(
            copyright: "Test Copyright",
            date: "2023-01-01",
            explanation: "This is a test explanation.",
            hdurl: "https://example.com/hd.jpg",
            mediaType: "image",
            serviceVersion: "v1",
            title: "Test Title",
            url: "https://example.com/sd.jpg"
        )
    }
}

// 2. The Test Class
@MainActor
final class HomeViewModelTests: XCTestCase {

    var viewModel: HomeViewModel!
    var mockService: MockAPIService!

    override func setUp() {
        super.setUp()
        // Here is where we inject the FAKE service
        mockService = MockAPIService()
        viewModel = HomeViewModel(service: mockService)
    }

    override func tearDown() {
        viewModel = nil
        mockService = nil
        super.tearDown()
    }

    func testLoadAPODSuccess() async {
        // Given: The network is working
        mockService.shouldReturnError = false
        
        // When: We ask for data
        await viewModel.loadAPOD()
        
        // Then: We should get our fake item and no errors
        XCTAssertNotNil(viewModel.apodItem)
        XCTAssertEqual(viewModel.apodItem?.title, "Test Title")
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertFalse(viewModel.isLoading)
    }
    
    func testLoadAPODFailure() async {
        // Given: The network is failing
        mockService.shouldReturnError = true
        
        // When: We ask for data
        await viewModel.loadAPOD()
        
        // Then: We should get an error message and NO item
        XCTAssertNil(viewModel.apodItem)
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertFalse(viewModel.isLoading)
    }
}
