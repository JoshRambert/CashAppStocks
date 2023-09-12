//
//  CashAppStocksApp.swift
//  CashAppStocks
//
//  Created by Joshua Rambert on 9/9/23.
//

import SwiftUI

@main
struct CashAppStocksApp: App {
    private let portfolioService = HTTPService()
    let store = CashAppStocksStore(
        state: CashAppStocksState(),
        reducer: cashAppStocksReducer,
        middlewares: [stocksMiddleware])
    
     init() {
        store.dispatch(.launch)
        
         portfolioService.retrievePortfolio(for: .healthy, { [self] (stocksCompletion) in
            switch stocksCompletion {
            case .success(let _stocks):
                store.dispatch(.setupRetrieved(_stocks))
            case .failure(let _error):
                store.dispatch(.setupFailed(_error))
            }
        })
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(store)
        }
    }
}
