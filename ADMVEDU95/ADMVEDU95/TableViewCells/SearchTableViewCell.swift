//
//  SearchTableViewCell.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 26.04.2021.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    @IBOutlet private var kindLabel: UILabel!
    @IBOutlet private var infoLabel: UILabel!

    func configure(model: ApiResult) {
        let noInfoString = R.string.localizable.noInfo()
        kindLabel.text = model.kind ?? noInfoString
        infoLabel.text = "\(model.artistName ?? noInfoString) - \(model.trackName ?? noInfoString)"
    }
}
