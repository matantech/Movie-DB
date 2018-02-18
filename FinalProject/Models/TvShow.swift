//
//  TvShow.swift
//  FinalProject
//
//  Created by Matan Levi on 8.11.2017.
//  Copyright © 2017 Matan Levi. All rights reserved.
//

import Foundation

class TvShow
{
    var originalName : String
    var genreIds : [Int]
    var name : String
    var popularity : Float
    var originCountry : [String]
    var voteCount : Int
    var firstAirDate : String
    var backdropPath : String
    var originalLanguage : String
    var id : Int
    var voteAverege : Double
    var overview : String
    var posterPath : String
    
    init(originalName : String, genreIds : [Int], name : String, popularity : Float, originCountry : [String], voteCount : Int, firstAirDate : String, backdropPath : String, originalLanguage : String, id : Int, voteAverege : Double, overview : String, posterPath : String) {
        
        self.originalName = originalName
        self.genreIds = genreIds
        self.name = name
        self.popularity = popularity
        self.originCountry = originCountry
        self.voteCount = voteCount
        self.firstAirDate = firstAirDate
        self.backdropPath = backdropPath
        self.originalLanguage = originalLanguage
        self.id = id
        self.voteAverege = voteAverege
        self.overview = overview
        self.posterPath = posterPath
        
    }
    

}
