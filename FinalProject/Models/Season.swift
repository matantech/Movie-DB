//
//  Season.swift
//  FinalProject
//
//  Created by Matan Levi on 22.11.2017.
//  Copyright © 2017 Matan Levi. All rights reserved.
//

import Foundation

class Season
{
    var seasonName : String
    var seasonNumber : Int
    var episodes : [Episode]
    var posterPath : String
    init(seasonName : String, seasonNumber : Int, episodes : [Episode], posterPath : String)
    {
        self.seasonName = seasonName
        self.seasonNumber = seasonNumber
        self.episodes = episodes
        self.posterPath = posterPath
    }
}
