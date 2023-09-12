//
//  Stock.swift
//  CashAppStocks
//
//  Created by Joshua Rambert on 9/9/23.
//

import Foundation

struct Stock: Decodable, Identifiable, Hashable {
    let id: UUID
    
    var ticker: String
    var name: String
    var currency: String
    var priceCents: Int
    var quantity: Int?
    var priceTimestamp: Int
    
    var priceUsd: String {
        "price: $\(Double(priceCents / 100))"
    }
    
    var shares: String {
        guard let quantity = quantity else {
            return "0 shares"
        }
        return "\(quantity) shares"
    }
    
    enum CodingKeys: String, CodingKey {
        case ticker
        case name
        case currency
        case priceCents = "current_price_cents"
        case quantity
        case priceTimestamp = "current_price_timestamp"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.ticker = try container.decode(String.self, forKey: .ticker)
        self.name = try container.decode(String.self, forKey: .name)
        self.currency = try container.decode(String.self, forKey: .currency)
        self.priceCents = try container.decode(Int.self, forKey: .priceCents)
        self.quantity = try container.decodeIfPresent(Int.self, forKey: .quantity)
        self.priceTimestamp = try container.decode(Int.self, forKey: .priceTimestamp)
        
        self.id = UUID()
    }
    
    static func == (lhs: Stock, rhs: Stock) -> Bool {
        return lhs.ticker == rhs.ticker && lhs.name == rhs.name && lhs.currency == rhs.currency &&
        lhs.priceCents == rhs.priceCents && lhs.quantity == rhs.quantity && lhs.priceTimestamp == rhs.priceTimestamp
    }
}

struct Stocks: Decodable {
    var array: [Stock]
    
    enum CodingKeys: String, CodingKey {
        case stocks
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.array = try container.decode([Stock].self, forKey: .stocks)
    }
    
    // Helper functions
    static func loadMock() -> [Stock]? {
        guard let url = Bundle.main.url(forResource: "MockStocks", withExtension: "json") else {
            print("Shit broken")
            return nil
        }
        
        let data = try? Data(contentsOf: url)
        let decoder = JSONDecoder()
        let mockStocks = try? decoder.decode(Stocks.self, from: data!)
        
        return mockStocks?.array
    }
}
