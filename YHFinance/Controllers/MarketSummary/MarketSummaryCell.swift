//
//  MarketSummaryCell.swift
//  YHFinance
//
//  Created by Aljon Antiola on 6/26/22.
//

import UIKit

class MarketSummaryCell: UITableViewCell {

    static let identifier = "MarketSummaryCell"
    @IBOutlet weak var shortNameLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(market: Market) {

        if let shortName = market.shortName {
            shortNameLabel.text = shortName
        } else {
            shortNameLabel.text = "N/A"
        }
        
        if let previousClose = market.spark?.previousClose {
            subtitleLabel.text = "\(previousClose)"
        } else {
            subtitleLabel.text = "N/A"
        }
    }
}
