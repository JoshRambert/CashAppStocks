//
//  HTTPService.swift
//  CashAppStocks
//
//  Created by Joshua Rambert on 9/9/23.
//

import Foundation
import HTTPLibrary

public final class HTTPService {
    
    struct Constants {
        static let portfolioUrl = "https://storage.googleapis.com/cash-homework/cash-stocks-api/"
    }
    
    let portfolioNetworkClient = HTTPNetworkClient(for: Constants.portfolioUrl)
    static let shared = HTTPService()
    
    func retrievePortfolio(for endpoint: Endpoint, _ completion: @escaping StocksCompletion) {
        
        portfolioNetworkClient.request(endpoint: endpoint)
            .response { (response, data, error) in
                if let httpError = error {
                    switch httpError {
                    case .http(400):
                        debugPrint("\(error?.errorDescription ?? "")")
                        completion(.failure(HTTPError.couldNotFindHost))
                        return
                    case .http(403):
                        debugPrint("\(error?.errorDescription ?? "")")
                        completion(.failure(HTTPError.parameterEncodingFailed(reason: .missingParameters)))
                        return
                    case .http(404):
                        debugPrint("\(error?.errorDescription ?? "")")
                        completion(.failure(HTTPError.invalidURL(response?.url?.absoluteString ?? "")))
                        return
                    case .http(500):
                        debugPrint("\(error?.errorDescription ?? "")")
                        completion(.failure(HTTPError.unknown("500 ERROR SERVER DOWN")))
                        return
                    case .noInternetConnection:
                        debugPrint("\(error?.errorDescription ?? "")")
                        completion(.failure(HTTPError.noInternetConnection))
                        return
                    default:
                        debugPrint("\(error?.errorDescription ?? "")")
                        completion(.failure(HTTPError.unknown(httpError.localizedDescription)))
                        return
                    }
                }
                
                do {
                    let stocks: Stocks = try JSONDecoder().decode(Stocks.self, from: data)
                    completion(.success(stocks))
                } catch {
                    completion(.failure(.responseSerializationFailed(reason: .jsonSerializationFailed(error: error))))
                }
                
            }
    }
}
