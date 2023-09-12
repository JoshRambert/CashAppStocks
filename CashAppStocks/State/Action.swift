//
//  Action.swift
//  CashAppStocks
//
//  Created by Joshua Rambert on 9/9/23.
//

import Foundation
import HTTPLibrary

enum CashAppStocksAction {
    case launch
    case setupRetrieved(Stocks)
    case setupFailed(HTTPError)
}
