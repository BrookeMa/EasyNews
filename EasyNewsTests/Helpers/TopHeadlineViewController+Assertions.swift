//
//  TopHeadlinesViewController+Assertions.swift
//  EasyNewsTests
//
//  Created by Ye Ma on 13/02/2023.
//

import XCTest
import EasyNews
import EasyNewsFeature

extension TopHeadlineUIIntegrationTests {
    
    func assertThat(_ sut: TopHeadlineViewController, isRendering articles: [Article], file: StaticString = #filePath, line: UInt = #line) {
        guard sut.numberOfRenderedArticleViews() == articles.count else {
            return XCTFail("Expected \(articles.count) articles, got\(sut.numberOfRenderedArticleViews()) instead", file: file, line: line)
        }
        
        articles.enumerated().forEach { index, article in
            assertThat(sut, hasViewConfiguredFor: article, at: index, file: file, line: line)
        }
    }
    
    func assertThat(_ sut: TopHeadlineViewController, hasViewConfiguredFor article: Article, at index: Int, file: StaticString = #filePath, line: UInt = #line) {
        let view = sut.articleView(at: index)
        
        guard let cell = view as? TopHeadlineCollectionViewCell else {
            return XCTFail("Expected \(TopHeadlineCollectionViewCell.self) instance, got\(String(describing: view)) instead", file: file, line: line)
        }
        
        XCTAssertEqual(cell.authorLabel.text, article.author, "Expected author name to be \(String(describing: article.author)) for view at index (\(index))", file: file, line: line)
        
        XCTAssertEqual(cell.descriptionLabel.text, article.description, "Expected description name to be \(String(describing: article.description)) for the view at index \(index)", file: file, line: line)
        
        XCTAssertEqual(cell.dateLabel.text, article.published.timeAgoDisplay(), "Expected date label text to be \(String(describing: article.published.timeAgoDisplay())) for the view at index \(index)", file: file, line: line)
    }
}
