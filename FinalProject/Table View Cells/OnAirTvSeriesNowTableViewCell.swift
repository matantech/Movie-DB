//
//  OnAirTvSeriesNowTableViewCell.swift
//  FinalProject
//
//  Created by Matan Levi on 20.11.2017.
//  Copyright © 2017 Matan Levi. All rights reserved.
//

import UIKit

class OnAirTvSeriesNowTableViewCell: UITableViewCell {

    @IBOutlet weak var tvShowName: UILabel!
    
    @IBOutlet weak var tvShowImageView: UIImageView!
    
    @IBOutlet weak var tvShowRating: UILabel!
    
    @IBOutlet weak var tvShowOriginCountry: UILabel!
    
    @IBOutlet weak var tvShowOriginLanguage: UILabel!
    
    @IBOutlet weak var tvShowGeneres: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
