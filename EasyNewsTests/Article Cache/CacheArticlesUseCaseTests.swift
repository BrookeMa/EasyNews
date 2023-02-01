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
    
    func test_save_requestsCacheDeletion() {
        let (sut, store) = makeSUT()
        
        sut.save(uniqueArticleItem().model) { _ in }
        
        XCTAssertEqual(store.receivedMessages, [.deleteCachedArticle])
    }
    
    func test_save_doesNotRequestsCacheInsertionOnDeletionError() {
        let (sut, store) = makeSUT()
        let deletionError = anyNSError()
        
        sut.save(uniqueArticleItem().model) { _ in }
        store.completeDeletion(with: deletionError)
        
        XCTAssertEqual(store.receivedMessages, [.deleteCachedArticle])
    }
    
    func test_save_requestsNewCacheInsertionWithTimestampOnSuccessfulDeletion() {
        let timestamp = Date()
        let articles = uniqueArticleItem()
        let (sut, store) = makeSUT(currentDate: { timestamp })
        
        sut.save(articles.model) { _ in }
        store.completeDeletionSuccessfully()

        XCTAssertEqual(store.receivedMessages, [.deleteCachedArticle, .insert(articles.local, timestamp)])
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
