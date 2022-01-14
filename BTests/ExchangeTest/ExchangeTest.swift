//
//  ExchangeTest.swift
//  monPtiBaluchon
//
//  Created by Aurelien Waxin on 06/01/2022.
//

import XCTest

@testable import monPtiBaluchon

class ConvertorRatesServiceTests: XCTestCase {

    // MARK: - Properties
    private let sut: ExchangeService = .init()

    // MARK: - Tests
    private let sessionConfiguration: URLSessionConfiguration = {
        let sessionConfiguration = URLSessionConfiguration.ephemeral
        sessionConfiguration.protocolClasses = [URLProtocolFake.self]
        return sessionConfiguration
    }()
    
    // MARK: - Tests
    func tests_getData_WhenFakeSessionWithErrorIsPassed_ThenShouldReturnAnError() {
        URLProtocolFake.fakeURLs = [FakeResponseConvertorData.exchangeUrl: (nil, nil, FakeResponseConvertorData.error)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut: ExchangeService = .init(session: fakeSession)

        let expectation = XCTestExpectation(description: "Waiting...")
        sut.getExchange() { result in
            guard case .failure(let error) = result else {
                XCTFail("Test failed: \(#function)")
                return
            }
            XCTAssertTrue(error == .dataError)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func tests_getData_WhenFakeSessionWithRatesCorrectDataAndInvalidResponseArePassed_ThenShouldReturnAServerResponseError() {
        URLProtocolFake.fakeURLs = [FakeResponseConvertorData.exchangeUrl: (FakeResponseConvertorData.correctDataConvertor, FakeResponseConvertorData.responseKO, nil)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut: ExchangeService = .init(session: fakeSession)

        let expectation = XCTestExpectation(description: "Waiting...")
        sut.getExchange() { result in
            guard case .failure(let error) = result else {
                XCTFail("Test failed: \(#function)")
                return
            }
            XCTAssertTrue(error == .serverResponseError)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func tests_getData_WhenFakeSessionWithRatesIncorrectDataAndValidResponseArePassed_ThenShouldReturnADecodeError() {
        URLProtocolFake.fakeURLs = [FakeResponseConvertorData.exchangeUrl: (FakeResponseConvertorData.incorrectDataConvertor, FakeResponseConvertorData.responseOK, nil)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut: ExchangeService = .init(session: fakeSession)

        let expectation = XCTestExpectation(description: "Waiting...")
        sut.getExchange() { result in
            guard case .failure(let error) = result else {
                XCTFail("Test failed: \(#function)")
                return
            }
            XCTAssertTrue(error == .decodeError)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func tests_getData_WhenFakeSessionWithCorrectDataAndValidResponseArePassed_ThenShouldACorrectConvertion() {
        URLProtocolFake.fakeURLs = [FakeResponseConvertorData.exchangeUrl: (FakeResponseConvertorData.correctDataConvertor, FakeResponseConvertorData.responseOK, nil)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut: ExchangeService = .init(session: fakeSession)

        let expectation = XCTestExpectation(description: "Waiting...")
        sut.getExchange() { result in
            guard case .success(let rates) = result else {
                XCTFail("Test failed: \(#function)")
                return
            }
            let rate = rates.rates["USD"]
            XCTAssertTrue(rates.base == "EUR")
            XCTAssertTrue(rate == rates.rates["USD"])
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}
