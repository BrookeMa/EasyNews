//
//  URLSessionHTTPClientTests.swift
//  EsayNewsTests
//
//  Created by Ye Ma on 05/01/2023.
//

import XCTest
import EsayNews

final class URLSessionHTTPClientTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Helpers
    
    private func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> HTTPClient {
        let sut = URLSessionHTTPClient()
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }
    
    
}
