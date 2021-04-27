//
//  SearchTableViewCell.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 26.04.2021.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var kindLabel: UILabel!
    @IBOutlet private weak var infoLabel: UILabel!
    
    static let reuseIdentifire = "SearchTableViewCell"
        
    public func configure(model: ApiResult) {
        kindLabel.text = model.kind ?? "no info".localized()
        infoLabel.text = "\(model.artistName ?? "no info".localized()) - \(model.trackName ?? "no info".localized())"
    }
}
