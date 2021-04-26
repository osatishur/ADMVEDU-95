//
//  SearchTableViewCell.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 26.04.2021.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var kindLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    public func configure(model: ApiResult) {
        kindLabel.text = model.kind ?? "no info".localized()
        infoLabel.text = "\(model.artistName ?? "no info".localized()) - \(model.trackName ?? "no info".localized())"
    }
}
