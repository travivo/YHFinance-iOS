//
//  MarketSummaryViewModel.swift
//  YHFinance
//
//  Created by Aljon Antiola on 6/26/22.
//

import UIKit
import RxSwift
import RxCocoa


class MarketSummaryViewModel {
    
    let webService = MarketService()
    let markets: BehaviorRelay<[Market]> = BehaviorRelay(value: [])
    let stocks: BehaviorRelay<[Stock]> = BehaviorRelay(value: [])
    let stockResult: BehaviorRelay<Stock?> = BehaviorRelay(value: nil)
    let disposeBag = DisposeBag()
    
    /**
     Fetch market summary.
     */
    func fetchData() {
        webService.getMarketSummary().bind(to: markets).disposed(by: disposeBag)
    }
    
    func searchStock(searchString : String) {
        webService.searchStock(searchString: searchString).bind(to: stockResult).disposed(by: disposeBag)
    }
}
