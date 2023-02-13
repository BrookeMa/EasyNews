//
//  EasyNewsTests.swift
//  EasyNewsTests
//
//  Created by Ye Ma on 03/02/2023.
//

import XCTest
import EasyNewsFeature
import EasyNews

final class TopHeadlineUIIntegrationTests: XCTestCase {
    
    func test_loadArticleActions_requestArticleFromLoader() {
        let (sut, loader) = makeSUT()
        XCTAssertEqual(loader.loadArticleCallCount, 0, "Expected no loading requests before view is loaded")

        sut.loadViewIfNeeded()
        XCTAssertEqual(loader.loadArticleCallCount, 1, "Expected a loading request once view is loaded")

        sut.simulateUserInitiatedArticlesReload()
        XCTAssertEqual(loader.loadArticleCallCount, 2, "Expected another loading request once user initiates a reload")

        sut.simulateUserInitiatedArticlesReload()
        XCTAssertEqual(loader.loadArticleCallCount, 3, "Expected yet another loading request once user initiates another reload")
    }
    
    func test_loadingTopHeadlinesIndicator_isVisibleLoadingArticle() {
        let (sut, loader) = makeSUT()
        
        sut.loadViewIfNeeded()
        XCTAssertTrue(sut.isShowingLoadingIndicator, "Expected loading indicator once view is loaded")
        
        loader.completeArticleLoading(at: 0)
        XCTAssertFalse(sut.isShowingLoadingIndicator, "Expected no loading indicator once loading completes successfully")
        
        sut.simulateUserInitiatedArticlesReload()
        XCTAssertTrue(sut.isShowingLoadingIndicator, "Expected loading indicator once user initiates a reload")
        
        loader.completeArticleLoadingWithError(at: 1)
        XCTAssertFalse(sut.isShowingLoadingIndicator, "Expected no loading indicator once user initiated loading completes with error")
    }
    
    // MARK: Helpers
    
    private func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> (sut: TopHeadlineViewController, loader: LoaderSpy) {
        let loader = LoaderSpy()
        let sut = TopHeadlineUIComposer.topHeadlineComposedWith(articleLoader: loader, imageLoader: loader)
        trackForMemoryLeaks(loader, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        return (sut, loader)
    }
    
    class LoaderSpy: ArticleLoader, ImageDataLoader {
        private var articleRequests = [(ArticleLoader.Result) -> Void]()

        var loadArticleCallCount: Int {
            return articleRequests.count
        }

        func load(completion: @escaping (ArticleLoader.Result) -> Void) {
            articleRequests.append(completion)
        }

        func completeArticleLoading(with articles: [Article] = [], at index: Int = 0) {
            articleRequests[index](.success(articles))
        }

        func completeArticleLoadingWithError(at index: Int = 0) {
            let error = NSError(domain: "an error", code: 0)
            articleRequests[index](.failure(error))
        }
        
        // MARK: - ImageDataLoader
        
        private struct TaskSpy: ImageDataLoaderTask {
            let cancelCallback: () -> Void
            func cancel() {
                cancelCallback()
            }
        }
        
        private var imageRequests = [(url: URL, completion: (ImageDataLoader.Result) -> Void)]()
        
        var loadedImageURLs: [URL] {
            return imageRequests.map { $0.url }
        }
        
        private(set) var cancelledImageURLs = [URL]()
        
        func loadImageData(from url: URL, completion: @escaping (ImageDataLoader.Result) -> Void) -> EasyNewsFeature.ImageDataLoaderTask {
            imageRequests.append((url, completion))
            return TaskSpy { [weak self] in self?.cancelledImageURLs.append(url)}
        }
        
        func completeImageLoading(with imageData: Data = Data(), at index: Int = 0) {
            imageRequests[index].completion(.success(imageData))
        }
        
        func completeImageLoadingWithError(at index: Int = 0) {
            let error = NSError(domain: "an error", code: 0)
            imageRequests[index].completion(.failure(error))
        }
    }
}


