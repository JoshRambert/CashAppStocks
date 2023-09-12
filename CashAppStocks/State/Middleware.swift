//
//  Middleware.swift
//  CashAppStocks
//
//  Created by Joshua Rambert on 9/9/23.
//

import Combine

typealias Middleware<State, Action> = (State, Action) -> AnyPublisher<Action, Never>

