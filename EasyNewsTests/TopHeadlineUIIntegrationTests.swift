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
    
    // MARK: Helpers
    
    private func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> (sut: TopHeadlineViewController, loader: LoaderSpy) {
        let loader = LoaderSpy()
        let sut = TopHeadlineUIComposer.topHeadlineComposedWith(articleLoader: loader, imageLoader: loader)
        trackForMemoryLeaks(loader, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        return (sut, loader)
    }
    
    class LoaderSpy: ArticleLoader, ImageDataLoader {
        private var feedRequests = [(ArticleLoader.Result) -> Void]()

        var loadFeedCallCount: Int {
            return feedRequests.count
        }

        func load(completion: @escaping (ArticleLoader.Result) -> Void) {
            feedRequests.append(completion)
        }

        func completeFeedLoading(with articles: [Article] = [], at index: Int = 0) {
            feedRequests[index](.success(articles))
        }

        func completeFeedLoadingWithError(at index: Int = 0) {
            let error = NSError(domain: "an error", code: 0)
            feedRequests[index](.failure(error))
        }
        
        // MARK: ImageDataLoader
        
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


