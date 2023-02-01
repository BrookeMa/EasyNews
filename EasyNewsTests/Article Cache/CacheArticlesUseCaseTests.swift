//
//  CacheArticlesUseCaseTests.swift
//  EasyNewsTests
//
//  Created by Ye Ma on 31/01/2023.
//

import XCTest
import EasyNews

class CacheArticlesUseCaseTests: XCTestCase {
    
    func test_init_doesNotMessageStoreUponCreation() {
        let (_, store) = makeSUT()
        
        XCTAssertEqual(store.receivedMessages, [])
    }
    
    // MARK: - Helpers
    
    private func makeSUT(currentDate: @escaping () -> Date = Date.init, file: StaticString = #filePath, line: UInt = #line) -> (sut: LocalArticlesLoader, store: ArticleStoreSpy) {
        let store = ArticleStoreSpy()
        let sut = LocalArticlesLoader(store: store, currentDate: currentDate)
        trackForMemoryLeaks(store, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        
        return (sut, store)
    }
}
