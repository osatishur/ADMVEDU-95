//
//  SearchResponceTableViewCell.swift
//  FirstWorkProject
//
//  Created by Satsishur on 13.04.2021.
//

import UIKit

class SearchResponceTableViewCell: UITableViewCell {
    struct Constants {
        static let sideConstraint: CGFloat = 8
        static let kindLabelTopConstraint: CGFloat = 16
        static let artistLabelTopConstraint: CGFloat = 24
        static let artistLabelBottomConstraint: CGFloat = 24
        static let kindLabelFontSize: CGFloat = 12
        static let artistLabelFontSize: CGFloat = 16
    }
    
    private lazy var kindLabel: UILabel = {
        let label = createLabel(fontSize: Constants.kindLabelFontSize, numberOfLines: 0)
        return label
    }()
    
    private lazy var artistAndTrackNameLabel: UILabel = {
        let label = createLabel(fontSize: Constants.artistLabelFontSize, numberOfLines: 0)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
     }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: Setup View
    private func setupView() {
        setSubviews()
        setupConstraints()
    }
    
    private func setSubviews() {
        contentView.addSubview(kindLabel)
        contentView.addSubview(artistAndTrackNameLabel)
    }
    
    private func setupConstraints() {
        kindLabel.anchor(top: contentView.topAnchor,
                         paddingTop: Constants.kindLabelTopConstraint,
                         left: contentView.leftAnchor,
                         paddingLeft: Constants.sideConstraint,
                         right: contentView.rightAnchor,
                         paddingRight: Constants.sideConstraint)
                
        artistAndTrackNameLabel.anchor(top: kindLabel.bottomAnchor,
                                       paddingTop: Constants.artistLabelTopConstraint,
                                       bottom: contentView.bottomAnchor,
                                       paddingBottom: Constants.artistLabelBottomConstraint,
                                       left: contentView.leftAnchor,
                                       paddingLeft: Constants.sideConstraint,
                                       right: contentView.rightAnchor,
                                       paddingRight: Constants.sideConstraint)
    }
    
    private func createLabel(fontSize: CGFloat, numberOfLines: Int) -> UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: fontSize)
        label.numberOfLines = numberOfLines
        return label
    }
    // MARK: - Model configure
    public func configure(model: ApiResult) {
        let kindLabelText = model.kind ?? "no info"
        kindLabel.text = kindLabelText.localized()
        artistAndTrackNameLabel.text = "\(model.artistName ?? "no info") - \(model.trackName ?? "no info")"
    }
}
