//
//  URLProtocolFake.swift
//  monPtiBaluchon
//
//  Created by Aurelien Waxin on 06/01/2022.
//

import Foundation

class URLProtocolFake: URLProtocol {
    static var fakeURLs = [URL?: (data: Data?, response: HTTPURLResponse?, error: Error?)]()

    override class func canInit(with request: URLRequest) -> Bool { true }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest { request }

    override func startLoading() {
        if let url = request.url {
            if let (data, response, error) = URLProtocolFake.fakeURLs[url] {
                if let responseStrong = response {
                    client?.urlProtocol(self, didReceive: responseStrong, cacheStoragePolicy: .notAllowed)
                }
                if let dataStrong = data {
                    client?.urlProtocol(self, didLoad: dataStrong)
                }
                if let errorStrong = error {
                    client?.urlProtocol(self, didFailWithError: errorStrong)
                }
            }
        }
        client?.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() { }
}
