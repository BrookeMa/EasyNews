//
//  Localized+TopHeadlineViewModel.swift
//  EasyNews
//
//  Created by Ye Ma on 05/02/2023.
//

import Foundation

extension Localized {
    enum TopHeadline {
        static var table: String { "TopHeadline" }
        
        static var title: String {
            NSLocalizedString("TOPHEADLINE_VIEW_TITLE",
                              tableName: table,
                              bundle: bundle,
                              comment: "Title for the top headlines view")

        }
        
        static var loadError: String {
            NSLocalizedString("TOPHEADLINE_VIEW_CONNECTION_ERROR",
                              tableName: table,
                              bundle: bundle,
                              comment: "Error message displayed when we can't load the articles from the server")
        }
    }
}
