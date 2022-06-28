//
//  StockDetailsViewController.swift
//  YHFinance
//
//  Created by Aljon Antiola on 6/27/22.
//

import UIKit
import RxSwift

class StockDetailsViewController: UIViewController {

    var symbolString: String?
    
    @IBOutlet weak var stockNameLabel: UILabel!
    @IBOutlet weak var sectorLabel: UILabel!
    @IBOutlet weak var currentPriceLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var changeLabel: UILabel!
    
    @IBOutlet weak var businessSummaryLabel: UILabel!
    
    @IBOutlet weak var loadingView: UIView!
    
    let disposeBag = DisposeBag()
    let viewModel = StockDetailsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setReactive()
        fetchData()
    }
 
    
    func fetchData() {
        viewModel.fetchStockDetails(symbol: self.symbolString!)
    }
    
    func setReactive() {
        
        viewModel.stock.subscribe(onNext: { (stock) in
            self.stockNameLabel.text = stock?.price.longName
            self.sectorLabel.text = stock?.summaryProfile?.sector
            self.businessSummaryLabel.text = stock?.summaryProfile?.longBusinessSummary
            self.currentPriceLabel.text = "\(stock?.price.regularMarketPrice!.raw ?? 0.00)"
            
            let valueChange = stock?.price.regularMarketChange!.raw
            let percentChange = stock?.price.regularMarketChangePercent!.fmt
            
            self.changeLabel.text = "\(valueChange ?? 0.00)" + "(" + "\(percentChange ?? "")" + ")"
            self.changeLabel.textColor = stock?.price.regularMarketChange!.raw ?? 0.0 > 0.0 ? .green : .red
            self.currencyLabel.text = stock?.price.currency
            if (stock != nil) {
                self.loadingView.isHidden = true
            }
          }).disposed(by: disposeBag)
        
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

