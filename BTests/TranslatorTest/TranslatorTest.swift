//
//  TranslatorTest.swift
//  monPtiBaluchon
//
//  Created by Aurelien Waxin on 08/01/2022.
//

import XCTest

@testable import monPtiBaluchon

class translatorServiceTest: XCTestCase {
    
    let sut: TranslateService = .init()
    var target : String = "en"
    var source : String = "fr"
    var text : String = "Bonjour"
    
    private let sessionConfiguration: URLSessionConfiguration = {
            let sessionConfiguration = URLSessionConfiguration.ephemeral
            sessionConfiguration.protocolClasses = [URLProtocolFake.self]
            return sessionConfiguration
        }()
//    MARK: - Testing test

    
    func tests_getData_WhenFakeSessionWithErrorIsPassed_ThenShouldReturnAnError() {
        URLProtocolFake.fakeURLs = [FakeResponseTranslatorData.translatorUrl: (nil, nil, FakeResponseTranslatorData.error)]
           let fakeSession = URLSession(configuration: sessionConfiguration)
           let sut: TranslateService = .init(session: fakeSession)

           let expectation = XCTestExpectation(description: "Waiting...")
        sut.getTranslation(text: text, target: target, source: source) { result in
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
           URLProtocolFake.fakeURLs = [FakeResponseTranslatorData.translatorUrl: (FakeResponseTranslatorData.correctDataTranslator, FakeResponseTranslatorData.responseKO, nil)]
           let fakeSession = URLSession(configuration: sessionConfiguration)
           let sut: TranslateService = .init(session: fakeSession)
           
           let expectation = XCTestExpectation(description: "Waiting...")
           sut.getTranslation(text: text, target: target, source:source) { result in
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
           URLProtocolFake.fakeURLs = [FakeResponseTranslatorData.translatorUrl: (FakeResponseTranslatorData.incorrectDataTranslator, FakeResponseTranslatorData.responseOK, nil)]
           let fakeSession = URLSession(configuration: sessionConfiguration)
           let sut: TranslateService = .init(session: fakeSession)

           let expectation = XCTestExpectation(description: "Waiting...")
           sut.getTranslation(text: text, target: target, source: source){ result in
               guard case .failure(let error) = result else {
                   XCTFail("Test failed: \(#function)")
                   return
               }
               XCTAssertTrue(error == .decodeError)
               expectation.fulfill()
           }
           wait(for: [expectation], timeout: 0.01)
       }

       func tests_getData_WhenFakeSessionWithCorrectDataAndValidResponseArePassed_ThenShouldReturnACorrectTranslation() {
           URLProtocolFake.fakeURLs = [FakeResponseTranslatorData.translatorUrl: (FakeResponseTranslatorData.correctDataTranslator, FakeResponseTranslatorData.responseOK, nil)]
           let fakeSession = URLSession(configuration: sessionConfiguration)
           let sut: TranslateService = .init(session: fakeSession)

           let expectation = XCTestExpectation(description: "Waiting...")
           sut.getTranslation(text: text, target: target, source: source) { result in
               guard case .success(let response) = result else {
                   XCTFail("Test failed: \(#function)")
                   return
               }
               let text = "Hello"
               XCTAssertTrue(text == response.data.translations[0].translatedText)
               expectation.fulfill()
           }
           wait(for: [expectation], timeout: 0.01)
       }
   }
