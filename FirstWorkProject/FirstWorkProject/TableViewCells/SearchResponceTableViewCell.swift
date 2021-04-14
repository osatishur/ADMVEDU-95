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
        kindLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.kindLabelTopConstraint).isActive = true
        kindLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: Constants.sideConstraint).isActive = true
        kindLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -Constants.sideConstraint).isActive = true
        
        artistAndTrackNameLabel.topAnchor.constraint(equalTo: kindLabel.bottomAnchor, constant: Constants.artistLabelTopConstraint).isActive = true
        artistAndTrackNameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: Constants.sideConstraint).isActive = true
        artistAndTrackNameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -Constants.sideConstraint).isActive = true
        artistAndTrackNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -Constants.artistLabelBottomConstraint).isActive = true
    }
    
    private func createLabel(fontSize: CGFloat, numberOfLines: Int) -> UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: fontSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = numberOfLines
        return label
    }
    // MARK: - Model configure
    public func configure(model: iTunesResult) {
        kindLabel.text = model.kind ?? "no info"
        artistAndTrackNameLabel.text = "\(model.artistName ?? "no info") - \(model.trackName ?? "no info")"
    }
}
