//
//  StocksCompletion.swift
//  CashAppStocks
//
//  Created by Joshua Rambert on 9/9/23.
//

import Foundation
import HTTPLibrary

typealias StocksCompletion = (Result<Stocks, HTTPError>) -> Void
