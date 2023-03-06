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
    
    func test_loadArticleCompletion_rendersSuccessfullyLoadedArticle() {
        let article0 = makeArticle(author: "author", title: "a title", description: "a descrption", url: anyURL(), source: "a source", image: anyURL())
        let article1 = makeArticle(author: nil, title: "a title", description: "a descrption", url: anyURL(), source: "a source", image: anyURL())
        let article2 = makeArticle(author: "author", title: "a title", description: "a descrption", url: anyURL(), source: "a source", image: nil)
        let article3 = makeArticle(author: nil, title: "a title", description: "a descrption", url: anyURL(), source: "a source", image: nil)
        
        let (sut, loader) = makeSUT()
        
        sut.loadViewIfNeeded()
        assertThat(sut, isRendering: [])
        
        loader.completeArticleLoading(with: [article0], at: 0)
        assertThat(sut, isRendering: [article0])
        
        sut.simulateUserInitiatedArticlesReload()
        loader.completeArticleLoading(with: [article0, article1, article2, article3], at: 1)
        assertThat(sut, isRendering: [article0, article1, article2, article3])
    }
    
    func test_loadArticleCompletion_doesNotAlterCurrentRenderingStateOnError() {
        let article = makeArticle()
        let (sut, loader) = makeSUT()
        
        sut.loadViewIfNeeded()
        loader.completeArticleLoading(with: [article], at: 0)
        assertThat(sut, isRendering: [article])
        
        sut.simulateUserInitiatedArticlesReload()
        loader.completeArticleLoadingWithError(at: 1)
        assertThat(sut, isRendering: [article])
    }
    
    func test_articleImageView_loadsImageURLWhenVisible() {
        let article0 = makeArticle(image: anyURL())
        let article1 = makeArticle(image: anyURL())
        let (sut, loader) = makeSUT()
        
        sut.loadViewIfNeeded()
        loader.completeArticleLoading(with: [article0, article1])
        
        XCTAssertEqual(loader.loadedImageURLs, [], "Expected no image URL request until views become visible")
        
        sut.simulateArticleImageViewVisible(at: 0)
        XCTAssertEqual(loader.loadedImageURLs, [article0.image], "Expected first image URL requet once first view becomes visible")
        
        sut.simulateArticleImageViewVisible(at: 1)
        XCTAssertEqual(loader.loadedImageURLs, [article0.image, article1.image], "Expected second article URL request once second view also ")
    }
    
    func test_articleWithoutImageView_loadsWithoutImageURLWhenVisible() {
        let article0 = makeArticle(image: nil)
        let article1 = makeArticle(image: nil)
        let (sut, loader) = makeSUT()
        
        sut.loadViewIfNeeded()
        loader.completeArticleLoading(with: [article0, article1])
        
        XCTAssertEqual(loader.loadedImageURLs, [], "Expected no image URL request until views become visible")
        
        sut.simulateArticleWithouImageVIewVisiblbe(at: 0)
        XCTAssertEqual(loader.loadedImageURLs, [], "Expected first without image URL requet once first view becomes visible")
        
        sut.simulateArticleWithouImageVIewVisiblbe(at: 1)
        XCTAssertEqual(loader.loadedImageURLs, [], "Expected second article URL request once second view also ")
    }
    
    func test_articleImageView_cancelsImageLoadingWhenNotVisibleAnymore() {
        
        let article0 = makeArticle()
        let article1 = makeArticle()
        let (sut, loader) = makeSUT()
        
        sut.loadViewIfNeeded()
        loader.completeArticleLoading(with: [article0, article1])
        XCTAssertEqual(loader.cancelledImageURLs, [], "Expected no cannelled image URL requests until image is not visible")
        
        sut.simulateArticleImageViewNotVisble(at: 0)
        XCTAssertEqual(loader.cancelledImageURLs, [article0.image], "Expected one cannelled image URL requests once first image is not visible")

        sut.simulateArticleImageViewNotVisble(at: 1)
        XCTAssertEqual(loader.cancelledImageURLs, [article0.image, article1.image], "Expected tow canneled image URL requests once seccond image is also not visible anymore")
    }
    
    func test_aritcleImageView_rendersImageLoadedFromURL() {
        let (sut, loader) = makeSUT()
        
        sut.loadViewIfNeeded()
        loader.completeArticleLoading(with: [makeArticle(), makeArticle()])
        
        let view0 = sut.simulateArticleImageViewVisible(at: 0)
        let view1 = sut.simulateArticleImageViewVisible(at: 1)
        
        XCTAssertEqual(view0?.renderedImage, .none, "Expected no image for first view while loading first image")
        XCTAssertEqual(view1?.renderedImage, .none, "Expected no image for first view while loading first image")

        let imageData0  = UIImage.make(withColor: .blue).pngData()!
        loader.completeImageLoading(with: imageData0, at: 0)
        XCTAssertEqual(view0?.renderedImage, imageData0, "Expected image for first view once first image loading completes successfully")
        XCTAssertEqual(view1?.renderedImage, .none, "Expected no image state change for second view once first image loading completes successfully")
        
        let imageData1 = UIImage.make(withColor: .green).pngData()!
        loader.completeImageLoading(with: imageData1, at: 1)
        XCTAssertEqual(view0?.renderedImage, imageData0, "Expected image for first view once first image loading completes successfully")
        XCTAssertEqual(view1?.renderedImage, imageData1, "Expected no image state change for second view once first image loading completes successfully")
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
    
    func makeArticle(author: String? = nil, title: String = "a title", description: String = "a description \(UUID())", url: URL = anyURL(), source: String = "a source", image: URL? = anyURL(), published: Date = Date()) -> Article {
        return Article(author: author, title: title, description: description, url: url, source: source, image: image, published: published)
    }
    
    private func anyImageData() -> Data {
        return UIImage.make(withColor: .red).pngData()!
    }
}


