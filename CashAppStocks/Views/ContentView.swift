//
//  ContentView.swift
//  CashAppStocks
//
//  Created by Joshua Rambert on 9/9/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var store: CashAppStocksStore
    
    var body: some View {
        switch store.state.stocksState {
        case .fetching:
            // show the loading screen
            FetchingView()
        case .retrieved(let stocks):
            // show the tableView of stocks
            StocksListView(stocks: stocks)
        case .error(let error):
            // Show the error state
            ErrorView(error: error)
        case .empty:
            // Show the empty state
            Text("There are no stocks at this time.")
                .fontWeight(.bold)
                .font(.system(size: 30))
                .frame(
                        minWidth: 0,
                        maxWidth: .infinity,
                        minHeight: 0,
                        maxHeight: .infinity,
                        alignment: .center
                    )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let store = CashAppStocksStore(
            state: CashAppStocksState(),
            reducer: cashAppStocksReducer,
            middlewares: [stocksMiddleware])
        
        ContentView()
            .environmentObject(store)
    }
}
