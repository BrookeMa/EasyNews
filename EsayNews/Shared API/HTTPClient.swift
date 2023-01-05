//
//  HTTPClient.swift
//  EsayNews
//
//  Created by Ye Ma on 05/01/2023.
//

import Foundation

public protocol HTTPClient {
    typealias Result = Swift.Result<(Data, HTTPURLResponse), Error>
    
    func get(from url: URL, completion: @escaping (Result) -> Void)
}
