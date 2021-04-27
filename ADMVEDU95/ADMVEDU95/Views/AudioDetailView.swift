//
//  SongDetailView.swift
//  FirstWorkProject
//
//  Created by Satsishur on 13.04.2021.
//

import UIKit

class AudioDetailView: UIView {
    private struct Constants {
        static let nibName = "AudioDetailView"
    }
    
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var playPauseButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit(nibName: Constants.nibName)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit(nibName: Constants.nibName)
    }
}
