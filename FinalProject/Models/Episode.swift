//
//  Episode.swift
//  FinalProject
//
//  Created by Matan Levi on 22.11.2017.
//  Copyright © 2017 Matan Levi. All rights reserved.
//

import Foundation

class Episode
{
    var number : Int
    var name : String
    var airDate : String
    var stillPath : String
    var overview : String
    init(number : Int, name : String, airDate : String, stillPath : String, overview : String) {
        self.number = number
        self.name = name
        self.airDate = airDate
        self.stillPath = stillPath
        self.overview = overview
    }
    
}
