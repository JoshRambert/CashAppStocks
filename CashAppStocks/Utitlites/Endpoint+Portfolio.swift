//
//  Endpoint+Portfolio.swift
//  CashAppStocks
//
//  Created by Joshua Rambert on 9/9/23.
//

import Foundation
import HTTPLibrary

extension Endpoint {
    
    struct PortfolioEndpoint {
        static let healthy = "portfolio.json"
        static let malformed = "portfolio_malformed.json"
        static let empty = "portfolio_empty.json"
    }
    
    static let healthy = Endpoint(path: PortfolioEndpoint.healthy,
                                           method: .get,
                                           encoding: HTTPURLEncoding.default,
                                           parameters: [:],
                                           headers: [:])
    
    static let malformed = Endpoint(path: PortfolioEndpoint.malformed,
                                             method: .get,
                                             encoding: HTTPURLEncoding.default,
                                             parameters: [:],
                                             headers: [:])
    
    static let empty = Endpoint(path: PortfolioEndpoint.empty,
                                         method: .get,
                                         encoding: HTTPURLEncoding.default,
                                         parameters: [:],
                                         headers: [:])
    
}
