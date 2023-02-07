//
//  UIRefreshControl+TestHelpers.swift
//  EasyNewsTests
//
//  Created by Ye Ma on 07/02/2023.
//

import UIKit

extension UIRefreshControl {
    func simulatePullToRefresh() {
        simulate(event: .valueChanged)
    }
}
