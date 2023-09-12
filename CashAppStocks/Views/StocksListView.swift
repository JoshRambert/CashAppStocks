//
//  StocksListView.swift
//  CashAppStocks
//
//  Created by Joshua Rambert on 9/9/23.
//

import SwiftUI

struct StocksListView: View {
    var stocks: [Stock]
    
    var body: some View {

        NavigationView {
            // Design this
            List(stocks, id: \.self) { stock in
                HStack {
                    VStack(alignment: .leading) {
                        Text(stock.ticker)
                            .fontWeight(.bold)
                            .font(.system(size: 18))
                            .frame(idealHeight: 25, maxHeight: 25, alignment: .leading)
                        Text(stock.shares)
                            .fontWeight(.medium)
                            .font(.system(size: 12))
                            .foregroundColor(stock.quantity != nil ? .green : .gray)
                            .frame(idealHeight: 25, maxHeight: 25, alignment: .leading)
                    }
                    Spacer()
                    Text(stock.priceUsd)
                        .frame(idealHeight: 25, maxHeight: 25, alignment: .trailing)
                }
            }
            .navigationBarTitle(Text("Portfolio Stocks"), displayMode: .large)
        }
    }
}

struct StocksListView_Previews: PreviewProvider {
    static var previews: some View {
        let stocks = Stocks.loadMock()
        StocksListView(stocks: stocks ?? [])
    }
}
