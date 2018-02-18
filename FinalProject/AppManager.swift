//
//  AppManager.swift
//  FinalProject
//
//  Created by Matan Levi on 8.11.2017.
//  Copyright © 2017 Matan Levi. All rights reserved.
//

import Foundation

enum MediaType {
    case movie
    case tvShow
}

class AppManager
{
    
    static var shared  = AppManager()
    private init(){}
    

    
    var mediaType : MediaType!
    var moviesGeneres : [Genere] = []
    var tvSeriesGeneres : [Genere] = []
    var movieVideos : [MovieVideo] = []
    var movieRuntime = 0
    var seasonsNumber = 0
    var nowPlayingMovies : [Movie] = []
    var onAirNow : [TvShow] = []
    var seasons : [Season] = []
    var seasontemp : Season! = nil
    var popularMovies : [Movie] = []
    var popularTvShows : [TvShow] = []
    var filteredMovies : [Movie] = []
    var filteredTvShows : [TvShow] = []

    
}
