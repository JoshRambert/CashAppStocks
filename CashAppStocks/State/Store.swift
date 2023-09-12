//
//  Store.swift
//  CashAppStocks
//
//  Created by Joshua Rambert on 9/9/23.
//

import Foundation
import Combine

typealias CashAppStocksStore = Store<CashAppStocksState, CashAppStocksAction>

class Store<State, Action>: ObservableObject {
    @Published private(set) var state: State
    private let reducer: Reducer<State, Action>
    private let middlewares: [Middleware<State, Action>]
    private let queue = DispatchQueue(label: "com.CashAppStocks.store", qos: .userInitiated)
    private var subscriptions: Set<AnyCancellable> = []
    
    init(state: State, reducer: @escaping Reducer<State, Action>, middlewares: [Middleware<State, Action>]) {
        self.state = state
        self.reducer = reducer
        self.middlewares = middlewares
    }
    
    func dispatch(_ action: Action) {
        queue.sync {
            self.dispatch(self.state, action)
        }
    }
    
    // The internal work for dispatching actions
    private func dispatch(_ currentState: State, _ action: Action) {
        let newState = reducer(currentState, action)
        
        middlewares.forEach { middleware in
          let publisher = middleware(newState, action)
          publisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: dispatch)
            .store(in: &subscriptions)
        }
        
        state = newState
    }
    
}

extension CashAppStocksStore {
    static var preview: CashAppStocksStore {
        CashAppStocksStore(
        state: CashAppStocksState(),
        reducer: cashAppStocksReducer,
        middlewares: [stocksMiddleware])
    }
}
