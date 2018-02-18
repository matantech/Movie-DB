//
//  FirstTableViewCell.swift
//  FinalProject
//
//  Created by Matan Levi on 20.11.2017.
//  Copyright © 2017 Matan Levi. All rights reserved.
//

import UIKit

class FirstTableViewCell: UITableViewCell {

    @IBOutlet weak var mainLabel: UILabel!
    
    
    @IBOutlet weak var imageViewOne: UIImageView!
    
    @IBOutlet weak var imageViewTwo: UIImageView!
    
    @IBOutlet weak var names: UILabel!
    
    @IBOutlet weak var mainViewOutletNew: UIView!
    
    @IBOutlet weak var mainViewShadowOutletNew: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
