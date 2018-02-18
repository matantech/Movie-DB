//
//  MoviesTableViewCell.swift
//  FinalProject
//
//  Created by Matan Levi on 19.11.2017.
//  Copyright © 2017 Matan Levi. All rights reserved.
//

import UIKit

class MoviesPlayNowTableViewCell: UITableViewCell {

    @IBOutlet weak var uiImageMoviePosterPicture: UIImageView!
    
    @IBOutlet weak var movieLabel: UILabel!
    
    @IBOutlet weak var movieRating: UILabel!
    
    @IBOutlet weak var movieDate: UILabel!
    
    
    @IBOutlet weak var moviesGenereLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
