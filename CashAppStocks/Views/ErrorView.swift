//
//  ErrorView.swift
//  CashAppStocks
//
//  Created by Joshua Rambert on 9/9/23.
//

import SwiftUI
import HTTPLibrary

struct ErrorView: View {
    
    var error: HTTPError
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Error Retrieving Stocks:")
                .fontWeight(.bold)
                .font(.system(size: 20))
                .frame(idealHeight: 25, maxHeight: 25, alignment: .center)
            Text(error.localizedDescription)
                .lineLimit(nil)
                .fontWeight(.medium)
                .font(.system(size: 15))
                .frame(
                        minWidth: 0,
                        maxWidth: .infinity,
                        minHeight: 0,
                        maxHeight: .infinity,
                        alignment: .center
                    )
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(10)
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        let error = HTTPError.invalidURL("www.venmo.com")
        ErrorView(error: error)
    }
}
