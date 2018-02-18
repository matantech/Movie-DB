//
//  episodeTableViewCell.swift
//  FinalProject
//
//  Created by Matan Levi on 25.11.2017.
//  Copyright © 2017 Matan Levi. All rights reserved.
//

import UIKit

class EpisodeTableViewCell: UITableViewCell {

    @IBOutlet weak var episodeImage: UIImageView!
    
    @IBOutlet weak var episodeNumber: UILabel!
    
    @IBOutlet weak var episodeName: UILabel!
    
    @IBOutlet weak var episodeAirDate: UILabel!
    
    @IBOutlet weak var episodeOverview: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
