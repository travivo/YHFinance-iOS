//
//  MarketSummaryViewController.swift
//  YHFinance
//
//  Created by Aljon Antiola on 6/26/22.
//

import UIKit
import RxSwift

class MarketSummaryViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var refreshControl = UIRefreshControl()
    let viewModel = MarketSummaryViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        setReactive()
        fetchData()
    }
    
    func setUI() {
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    func setReactive() {
        tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        viewModel
            .markets
            .bind(to: tableView.rx.items(cellIdentifier: MarketSummaryCell.identifier, cellType: MarketSummaryCell.self)) {(index, item, cell) in
                cell.configure(market: item)
            }.disposed(by: disposeBag)
        
        tableView.rx.itemSelected.subscribe(onNext: { [weak self] idx in
            
            self?.tableView.deselectRow(at: idx, animated: true)
            
            if let model = self?.viewModel.markets.value[idx.row] {
                self?.didTapStock(stockSymbol: model.fullExchangeName!)
            }
            
        }).disposed(by: disposeBag)
        
        viewModel.markets.compactMap({ $0.count }).subscribe(onNext: { [weak self] count in
            if count == 0 {
                print("No data")
            }
            
            self?.refreshControl.endRefreshing()
            self?.tableView.reloadData()
        }).disposed(by: disposeBag)
        
        Observable<Int>.interval(.seconds(8), scheduler: MainScheduler.instance)
            .subscribe(onNext: { _ in
                self.fetchData()
            })
            .disposed(by: disposeBag)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        fetchData()
    }
    
    func fetchData() {
        self.viewModel.fetchData()
    }
}

extension MarketSummaryViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}


extension MarketSummaryViewController {
    func didTapStock(stockSymbol: String) {
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "StockDetailsViewController") as? StockDetailsViewController
        vc!.symbolString = stockSymbol
        
        self.present(vc!, animated: true)
    }
}
