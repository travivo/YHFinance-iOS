//
//  StockDetailsViewModel.swift
//  YHFinance
//
//  Created by Aljon Antiola on 6/27/22.
//

import UIKit
import RxSwift
import RxCocoa


class StockDetailsViewModel {
    
    let webService = MarketService()
    let stock: BehaviorRelay<Stock?> = BehaviorRelay(value: nil)
    let disposeBag = DisposeBag()
    
    /**
     Fetch stock details.
     */
    func fetchStockDetails(symbol: String) {
        webService.getStockDetails(stockSymbol: symbol).bind(to: stock).disposed(by: disposeBag)
    }
    
}
