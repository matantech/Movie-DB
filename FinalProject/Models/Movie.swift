//
//  Movie.swift
//  FinalProject
//
//  Created by Matan Levi on 8.11.2017.
//  Copyright © 2017 Matan Levi. All rights reserved.
//

import Foundation

class Movie
{
    var voteCount : Int
    var id : Int
    var video : Bool
    var voteAverege : Double
    var title : String
    var popularity : Float
    var posterPath : String
    var originalLanguage : String
    var originalTitle : String
    var genreIds : [Int]
    var backdropPath : String
    var adult : Bool
    var overview : String
    var releaseDate : String
    
    init(voteCount : Int, id : Int, video : Bool, voteAverege : Double, title : String, popularity : Float, posterPath : String, originalLanguage : String, originalTitle : String, genreIds : [Int], backdropPath : String, adult : Bool, overview : String, releaseDate : String) {
        
        self.voteCount = voteCount
        self.id = id
        self.video = video
        self.voteAverege = voteAverege
        self.title = title
        self.popularity = popularity
        self.posterPath = posterPath
        self.originalLanguage = originalLanguage
        self.originalTitle = originalTitle
        self.genreIds = genreIds
        self.backdropPath = backdropPath
        self.adult = adult
        self.overview = overview
        self.releaseDate = releaseDate
        
        
    }
    

}
