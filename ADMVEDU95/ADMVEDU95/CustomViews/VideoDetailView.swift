//
//  MovieDetail.swift
//  FirstWorkProject
//
//  Created by Satsishur on 13.04.2021.
//

import UIKit

class VideoDetailView: UIView {
    private struct Constants {
        static let nibName = "VideoDetailView"
    }
    
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var directorNameLabel: UILabel!
    @IBOutlet weak var movieNameLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit(nibName: Constants.nibName)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit(nibName: Constants.nibName)
    }
}
