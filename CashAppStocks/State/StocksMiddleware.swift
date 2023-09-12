//
//  stocksMiddleware.swift
//  CashAppStocks
//
//  Created by Joshua Rambert on 9/9/23.
//

import Foundation
import Combine
import SwiftUI
import HTTPLibrary

let stocksMiddleware: Middleware<CashAppStocksState, CashAppStocksAction> = { state, action in
    // Nothing needs to be done here for now
    return Empty().eraseToAnyPublisher()
}
