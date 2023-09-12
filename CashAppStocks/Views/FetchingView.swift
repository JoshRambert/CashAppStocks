//
//  FetchingView.swift
//  CashAppStocks
//
//  Created by Joshua Rambert on 9/9/23.
//

import SwiftUI

struct FetchingView: View {
    
    var body: some View {
        VStack {
           ProgressView("Loading...")
                .progressViewStyle(CircularProgressViewStyle(tint: .green))
                .scaleEffect(3)
        }
    }
}

struct FetchingView_Previews: PreviewProvider {
    static var previews: some View {
        FetchingView()
    }
}
