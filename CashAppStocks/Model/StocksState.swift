//
//  StocksState.swift
//  CashAppStocks
//
//  Created by Joshua Rambert on 9/9/23.
//

import Foundation
import HTTPLibrary

enum StocksState {
    case fetching
    case retrieved([Stock])
    case empty
    case error(HTTPError)
}
