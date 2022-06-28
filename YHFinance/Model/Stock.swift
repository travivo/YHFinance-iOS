//
//  Stock.swift
//  YHFinance
//
//  Created by Aljon Antiola on 6/27/22.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Stock
struct Stock: Codable {
    let summaryProfile: SummaryProfile?
    let price: Price
    let pageViews: PageViews
}

// MARK: - PageViews
struct PageViews: Codable {
    let shortTermTrend, midTermTrend, longTermTrend: String
    let maxAge: Int
}

// MARK: - Price
struct Price: Codable {
    let quoteSourceName: String?
    let regularMarketOpen: RegularMarket?
    let exchange: String?
    let regularMarketDayHigh: RegularMarket?
    let longName: String?
    let regularMarketChange: RegularMarket?
    let currencySymbol, currency: String
    let regularMarketPrice: RegularMarket?
    let symbol: String?
    let regularMarketChangePercent: RegularMarket?
}

// MARK: - SummaryProfile
struct SummaryProfile: Codable {
    let sector, longBusinessSummary, city, phone: String?
    let state, country: String?
    let website: String?
    let address1, industry: String?
}
