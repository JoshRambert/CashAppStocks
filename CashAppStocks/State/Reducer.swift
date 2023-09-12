//
//  Reducer.swift
//  CashAppStocks
//
//  Created by Joshua Rambert on 9/9/23.
//

typealias Reducer<State, Action> = (State, Action) -> State

let cashAppStocksReducer: Reducer<CashAppStocksState, CashAppStocksAction> = { state, action in
    var mutatingState = state

    switch action {
    case .launch:
        mutatingState.stocksState = .fetching
    
    case .setupRetrieved(let stocks):
        mutatingState.stocksState = !stocks.array.isEmpty ? .retrieved(stocks.array) : .empty
        
    case .setupFailed(let error):
        mutatingState.stocksState = .error(error)
        
    default:
        break
    }
    
    return mutatingState
}
