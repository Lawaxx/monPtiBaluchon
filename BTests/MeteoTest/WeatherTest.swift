//
//  WeatherTest.swift
//  monPtiBaluchon
//
//  Created by Aurelien Waxin on 08/01/2022.
//

import XCTest
@testable import monPtiBaluchon

class WeatherServiceTest: XCTestCase {
    

    let sut: WeatherServices = .init()
    // MARK: - Tests
    private let sessionConfiguration: URLSessionConfiguration = {
        let sessionConfiguration = URLSessionConfiguration.ephemeral
        sessionConfiguration.protocolClasses = [URLProtocolFake.self]
        return sessionConfiguration
    }()
    
    // MARK: - Tests
    func tests_getData_WhenFakeSessionWithErrorIsPassed_ThenShouldReturnAnError() {
        URLProtocolFake.fakeURLs = [FakeResponseWeatherData.weatherURL: (nil, nil, FakeResponseWeatherData.error)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut: WeatherServices = .init(session: fakeSession)

        let expectation = XCTestExpectation(description: "Waiting...")
        sut.getWeather(){ result in
            guard case .failure(let error) = result else {
                XCTFail("Test failed: \(#function)")
                return
            }
            XCTAssertTrue(error == .dataError)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func tests_getData_WhenFakeSessionWithRatesCorrectDataAndInvalidResponseArePassed_ThenShouldReturnAnError() {
        URLProtocolFake.fakeURLs = [FakeResponseWeatherData.weatherURL: (FakeResponseWeatherData.correctDataWeather, FakeResponseWeatherData.responseKO, nil)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut: WeatherServices = .init(session: fakeSession)

        let expectation = XCTestExpectation(description: "Waiting...")
        sut.getWeather(){ result in
            guard case .failure(let error) = result else {
                XCTFail("Test failed: \(#function)")
                return
            }
            XCTAssertTrue(error == .serverResponseError)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func tests_getData_WhenFakeSessionWithRatesIncorrectDataAndValidResponseArePassed_ThenShouldReturnAnError() {
        URLProtocolFake.fakeURLs = [FakeResponseWeatherData.weatherURL: (FakeResponseWeatherData.incorrectDataWeather, FakeResponseWeatherData.responseOK, nil)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut: WeatherServices = .init(session: fakeSession)

        let expectation = XCTestExpectation(description: "Waiting...")
        sut.getWeather(){ result in
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
        URLProtocolFake.fakeURLs = [FakeResponseWeatherData.weatherURL: (FakeResponseWeatherData.correctDataWeather, FakeResponseWeatherData.responseOK, nil)]
        let fakeSession = URLSession(configuration: sessionConfiguration)
        let sut: WeatherServices = .init(session: fakeSession)

        let expectation = XCTestExpectation(description: "Waiting...")
        sut.getWeather(){ result in
            guard case .success(let weatherOK) = result else {
                XCTFail("Test failed: \(#function)")
                return
            }
            
            let description = "ciel dégagé"
            
            XCTAssertTrue(description == weatherOK.list[0].weather[0].weatherDescription)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}
