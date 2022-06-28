//
//  MarketService.swift
//  YHFinance
//
//  Created by Aljon Antiola on 6/26/22.
//

import UIKit
import RxAlamofire
import Alamofire
import RxSwift

protocol MarketServiceProtocol {
    func getMarketSummary() -> Observable<[Market]>
    func getStockDetails(stockSymbol: String) -> Observable<Stock?>
    func searchStock(searchString: String) -> Observable<Stock?>
}

class MarketService: MarketServiceProtocol {
    
    /**
     Get live summary information of market by region
     - Returns Observable<[Market]>
     */
    func getMarketSummary() -> Observable<[Market]> {
        
        return RxAlamofire.requestData(ServiceRouter.getMarketSummary).compactMap { (response, data) -> [Market] in
            do {
                let val = try JSONDecoder().decode(MarketSummary.self, from: data)
                return val.marketSummaryAndSparkResponse.result
            } catch {
                debugPrint("Error is \(error)")
            }
            return []
        }
    }
    
    /**
     Get information of stock by symbol
     - Returns Observable<[Stock]>
     */
    func getStockDetails(stockSymbol: String) -> Observable<Stock?> {
        
        return RxAlamofire.requestData(ServiceRouter.getStocksDetails(stockSymbol)).compactMap { (response, data) -> Stock? in
            do {
                let val = try JSONDecoder().decode(Stock.self, from: data)
                return val
            } catch {
                debugPrint("Error is \(error)")
            }
            return nil
        }
    }
    
    /**
     Get information of stock by search string
     - Returns Observable<[Stock]>
     */
    func searchStock(searchString: String) -> Observable<Stock?> {
        
        return RxAlamofire.requestData(ServiceRouter.autoComplete(searchString)).compactMap { (response, data) -> Stock? in
            do {
                let val = try JSONDecoder().decode(Stock.self, from: data)
                return val
            } catch {
                debugPrint("Error is \(error)")
            }
            return nil
        }
    }
}
