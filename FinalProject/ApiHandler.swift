//
//  ApiHandler.swift
//  FinalProject
//
//  Created by Matan Levi on 15.11.2017.
//  Copyright © 2017 Matan Levi. All rights reserved.
//

import UIKit

extension UIImageView{
    
    func makeImageFromString(imageString : String)
    {
        var url : URL!
        if let newUrl = URL(string: imageString)
        {
            url = newUrl
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data
            {
                if let image = UIImage(data: data)
                {
                    DispatchQueue.main.async
                        {
                            self.image = image
                    }
                }
            }
            }.resume()
        
    }
    
    
}


class ApiHandler
{
    
    static var shared  = ApiHandler()
    private init(){}
    
    
    func searchMovies(searchString : String, completion : @escaping ()->())
    {
        let url  = "https://api.themoviedb.org/3/search/movie?api_key=d08168bdea162076c5d5bb799daac437&language=en-US&query=\(searchString)&page=1&include_adult=false"
        let urlNew = URL(string: url)
        URLSession.shared.dataTask(with: urlNew!) { (data, response, error) in
            if let data = data
            {
                let movies = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String : AnyObject]
                let results = movies!["results"] as! [[String : AnyObject]]
                for result in results
                {
                    let voteCount = result["vote_count"] as! Int
                    let id = result["id"] as! Int
                    let video = result["video"] as! Bool
                    let voteAverege = result["vote_average"] as! Double
                    let title = result["title"] as! String
                    let popularity = result["popularity"] as! Float
                    var posterPath = ""
                    if let posterPathNew =  result["poster_path"] as? String
                    {
                        posterPath = posterPathNew
                    }
                    let originalLanguage =  result["original_language"] as! String
                    let originalTitle = result["original_title"] as! String
                    let genreIds = result["genre_ids"] as! [Int]
                    var backDropPath = ""
                    if let backDropPathNew = result["backdrop_path"] as? String
                    {
                        backDropPath = backDropPathNew
                    }
                    let adult = result["adult"] as! Bool
                    let overview = result["overview"] as! String
                    let releaseDate = result["release_date"] as! String
                    
                    let newMovie = Movie(voteCount: voteCount, id: id, video: video, voteAverege: voteAverege, title: title, popularity: popularity, posterPath:"https://image.tmdb.org/t/p/w300\(posterPath)", originalLanguage: originalLanguage, originalTitle: originalTitle, genreIds: genreIds, backdropPath: "https://image.tmdb.org/t/p/w300\(backDropPath)", adult: adult, overview: overview, releaseDate: releaseDate)
                    AppManager.shared.filteredMovies.append(newMovie)
                }
                
                completion()
                
            }
        }.resume()
    }
    
    func searchTvShows(searchString : String, completion : @escaping ()->())
    {
        let url = "https://api.themoviedb.org/3/search/tv?api_key=d08168bdea162076c5d5bb799daac437&language=en-US&query=\(searchString)&page=1"
        let urlNew = URL(string: url)
        URLSession.shared.dataTask(with: urlNew!) { (data, response, error) in
            if let data = data
            {
                let tvShows = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String : AnyObject]
                let results = tvShows!["results"] as! [[String : AnyObject]]
                for result in results
                {
                    let originalName = result["original_name"] as! String
                    let genreIds = result["genre_ids"] as! [Int]
                    let name = result["name"] as! String
                    let popularity = result["popularity"] as! Float
                    let originCoutry = result["origin_country"] as! [String]
                    let voteCount = result["vote_count"] as! Int
                    let firstAirDate = result["first_air_date"] as! String
                    var backDropPath = ""
                    if let backDropPathNew = result["backdrop_path"] as? String
                    {
                        backDropPath = backDropPathNew
                    }
                    let originalLanguage = result["original_language"] as! String
                    let id = result["id"] as! Int
                    let voteAverege = result["vote_average"] as! Double
                    let overview = result["overview"] as! String
                    var posterPath = ""
                    if let posterPathNew = result["poster_path"] as? String
                    {
                        posterPath = posterPathNew
                    }
                    
                    let newTvShow = TvShow(originalName: originalName, genreIds: genreIds, name: name, popularity: popularity, originCountry: originCoutry, voteCount: voteCount, firstAirDate: firstAirDate, backdropPath: "https://image.tmdb.org/t/p/w300\(backDropPath)", originalLanguage: originalLanguage, id: id, voteAverege: voteAverege, overview: overview, posterPath:"https://image.tmdb.org/t/p/w300\(posterPath)")
                    AppManager.shared.filteredTvShows.append(newTvShow)
                }
                
                completion()
                
            }
        }.resume()
    }
    
    func getTvShowSeasonsNumber(tvShowId : Int, completion : @escaping ()->())
    {
        var seasons = 0
        let url = "https://api.themoviedb.org/3/tv/\(String(tvShowId))?api_key=d08168bdea162076c5d5bb799daac437&language=en-US"
        let urlNew = URL(string: url)
        URLSession.shared.dataTask(with: urlNew!) { (data, response, error) in
            if let data = data
            {
                let results = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String : AnyObject]
                seasons = results!["number_of_seasons"] as! Int
                AppManager.shared.seasonsNumber = seasons
            }
            
            completion()
            
            }.resume()
        
    }
    
    func getTvShowSeasons(tvShowId : Int, seasonNumber : Int, completion : @escaping ()->())
    {
        var episodes : [Episode] = []
        let url = "https://api.themoviedb.org/3/tv/\(String(tvShowId))/season/\(String(seasonNumber))?api_key=d08168bdea162076c5d5bb799daac437&language=en-US"
        let urlNew = URL(string: url)
        URLSession.shared.dataTask(with: urlNew!) { (data, response, error) in
            if let data = data
            {
                let season = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String : AnyObject]
                let seasonEpisodes = season!["episodes"] as? [[String : AnyObject]]
                for episode in seasonEpisodes!
                {
                    let episodeNumber = episode["episode_number"] as! Int
                    var episodeName = ""
                    if let episodeNameNew = episode["name"] as? String
                    {
                        episodeName = episodeNameNew
                    }
                    var episodeAirDate = ""
                    if let episodeAirDateNew = episode["air_date"] as? String
                    {
                        episodeAirDate = episodeAirDateNew
                    }
                    var episodeStillPath = ""
                    if let episodeStillPathNew = episode["still_path"] as? String
                    {
                        episodeStillPath = episodeStillPathNew
                    }
                    let episodeOverview = episode["overview"] as! String
                    let newEpisode = Episode(number: episodeNumber, name: episodeName, airDate: episodeAirDate, stillPath: "https://image.tmdb.org/t/p/w300/\(episodeStillPath)", overview: episodeOverview)
                    episodes.append(newEpisode)
                }
                var seasonName = ""
                if let seasonNameNew = season!["name"] as? String
                {
                    seasonName = seasonNameNew
                }
                var seasonPosterPath = ""
                if let seasonPosterPathNew = season!["poster_path"] as? String
                {
                    seasonPosterPath = seasonPosterPathNew
                }
                var seasonNumber = 0
                if let seasonNumberNew = season!["season_number"] as? Int
                {
                    seasonNumber = seasonNumberNew
                }
                let newSeason = Season(seasonName: seasonName, seasonNumber: seasonNumber, episodes: episodes, posterPath: "https://image.tmdb.org/t/p/w300/\(seasonPosterPath)")
                AppManager.shared.seasons.append(newSeason)
                
            }
            
            
            completion()
            
            }.resume()
    }
    
    func getPopularMovies(completion : @escaping ()->())
    {
        let url = "https://api.themoviedb.org/3/movie/popular?api_key=d08168bdea162076c5d5bb799daac437&language=en-US&page=1"
        let urlNew = URL(string: url)
        URLSession.shared.dataTask(with: urlNew!) { (data, response, error) in
            if let data = data
            {
                let results = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String : AnyObject]
                let popularMovies = results!["results"] as! [[String : AnyObject]]
                for movie in popularMovies
                {
                    let voteCount = movie["vote_count"] as! Int
                    let id = movie["id"] as! Int
                    let video = movie["video"] as! Bool
                    let voteAverege = movie["vote_average"] as! Double
                    let title = movie["title"] as! String
                    let popularity = movie["popularity"] as! Float
                    let posterPath =  movie["poster_path"] as! String
                    let originalLanguage =  movie["original_language"] as! String
                    let originalTitle = movie["original_title"] as! String
                    let genreIds = movie["genre_ids"] as! [Int]
                    let backDropPath = movie["backdrop_path"] as! String
                    let adult = movie["adult"] as! Bool
                    let overview = movie["overview"] as! String
                    let releaseDate = movie["release_date"] as! String
                    
                    let newMovie = Movie(voteCount: voteCount, id: id, video: video, voteAverege: voteAverege, title: title, popularity: popularity, posterPath:"https://image.tmdb.org/t/p/w300\(posterPath)", originalLanguage: originalLanguage, originalTitle: originalTitle, genreIds: genreIds, backdropPath: "https://image.tmdb.org/t/p/w300\(backDropPath)", adult: adult, overview: overview, releaseDate: releaseDate)
                    AppManager.shared.popularMovies.append(newMovie)
                }
            }
            
            completion()
            
            }.resume()
    }
    
    func getPopularTvShows(completion : @escaping ()->())
    {
        let url = "https://api.themoviedb.org/3/tv/popular?api_key=d08168bdea162076c5d5bb799daac437&language=en-US&page=1"
        let urlNew = URL(string: url)
        URLSession.shared.dataTask(with: urlNew!) { (data, response, error) in
            if let data = data
            {
                let results = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String : AnyObject]
                let popularTvShows = results!["results"] as! [[String : AnyObject]]
                for popularTvShow in popularTvShows
                {
                    let originalName = popularTvShow["original_name"] as! String
                    let genreIds = popularTvShow["genre_ids"] as! [Int]
                    let name = popularTvShow["name"] as! String
                    let popularity = popularTvShow["popularity"] as! Float
                    let originCoutry = popularTvShow["origin_country"] as! [String]
                    let voteCount = popularTvShow["vote_count"] as! Int
                    let firstAirDate = popularTvShow["first_air_date"] as! String
                    var backDropPath = ""
                    if let backDropPathNew = popularTvShow["backdrop_path"] as? String
                    {
                        backDropPath = backDropPathNew
                    }
                    let originalLanguage = popularTvShow["original_language"] as! String
                    let id = popularTvShow["id"] as! Int
                    let voteAverege = popularTvShow["vote_average"] as! Double
                    let overview = popularTvShow["overview"] as! String
                    var posterPath = ""
                    if let posterPathNew = popularTvShow["poster_path"] as? String
                    {
                        posterPath = posterPathNew
                    }
                    
                    let newTvShow = TvShow(originalName: originalName, genreIds: genreIds, name: name, popularity: popularity, originCountry: originCoutry, voteCount: voteCount, firstAirDate: firstAirDate, backdropPath: "https://image.tmdb.org/t/p/w300\(backDropPath)", originalLanguage: originalLanguage, id: id, voteAverege: voteAverege, overview: overview, posterPath:"https://image.tmdb.org/t/p/w300\(posterPath)")
                    AppManager.shared.popularTvShows.append(newTvShow)
                }
                completion()
            }
        }.resume()
    }
    
    
    func goToYoutubeVideo(videoKey : String)
    {
        
        let appURL = NSURL(string: "youtube://www.youtube.com/watch?v=\(videoKey)")!
        let webURL = NSURL(string: "https://www.youtube.com/watch?v=\(videoKey)")!
        let application = UIApplication.shared
        
        if application.canOpenURL(appURL as URL) {
            application.open(appURL as URL)
        } else {
            // if Youtube app is not installed, open URL inside Safari
            application.open(webURL as URL)
        }
        
    }
    
    func getMovieRunTime(movieId : Int, completion : @escaping ()->())
    {
        var runtime = 0
        let url = "https://api.themoviedb.org/3/movie/\(String(movieId))?api_key=d08168bdea162076c5d5bb799daac437&language=en-US"
        let urlNew = URL(string: url)
        URLSession.shared.dataTask(with: urlNew!) { (data, response, error) in
            if let data = data
            {
                let results = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String : AnyObject]
                runtime = results!["runtime"] as! Int
                AppManager.shared.movieRuntime = runtime
            }
            
            completion()
            
            }.resume()
        
    }
    
    func getMovieVideos(movieId : Int, completion : @escaping ()->())
    {
        let url = "https://api.themoviedb.org/3/movie/\(String(movieId))/videos?api_key=d08168bdea162076c5d5bb799daac437&language=en-US"
        let urlNew = URL(string: url)
        URLSession.shared.dataTask(with: urlNew!) { (data, response, error) in
            if let data = data
            {
                let results = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String : AnyObject]
                let videos = results!["results"] as! [[String : AnyObject]]
                for video in videos
                {
                    let videoName = video["name"] as! String
                    let videoKey = video["key"] as! String
                    let newVideo = MovieVideo(videoName: videoName, videoKey: videoKey)
                    AppManager.shared.movieVideos.append(newVideo)
                }
                completion()
            }
            }.resume()
    }
    
    
    func getMoviesGeners()
    {
        let url = "https://api.themoviedb.org/3/genre/movie/list?api_key=d08168bdea162076c5d5bb799daac437&language=en-US"
        
        let urlNew = URL(string: url)
        URLSession.shared.dataTask(with: urlNew!) { (data, response, error) in
            if let data = data
            {
                let genersMain = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String : AnyObject]
                let geners = genersMain!["genres"] as! [[String : AnyObject]]
                
                for genere in geners
                {
                    let genereId = genere["id"] as! Int
                    let genereName = genere["name"] as! String
                    let genereNew = Genere(id: genereId, name: genereName)
                    AppManager.shared.moviesGeneres.append(genereNew)
                }
            }
            }.resume()
        
    }
    
    func getTvShowsGeneres()
    {
        let url = "https://api.themoviedb.org/3/genre/tv/list?api_key=d08168bdea162076c5d5bb799daac437&language=en-US"
        
        let urlNew = URL(string: url)
        URLSession.shared.dataTask(with: urlNew!) { (data, response, error) in
            if let data = data
            {
                let genersMain = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String : AnyObject]
                let geners = genersMain!["genres"] as! [[String : AnyObject]]
                
                for genere in geners
                {
                    let genereId = genere["id"] as! Int
                    let genereName = genere["name"] as! String
                    let genereNew = Genere(id: genereId, name: genereName)
                    AppManager.shared.tvSeriesGeneres.append(genereNew)
                }
            }
            }.resume()
    }
    
    func getMoviesGeneresString(genereNumber:[Int])->String
    {
        var genereString = ""
        for genere in AppManager.shared.moviesGeneres
        {
            for i in stride(from: 0, to: genereNumber.count, by: 1)
            {
                if genere.id == genereNumber[i]
                {
                    genereString += "\(genere.name),"
                }
            }
        }
        return genereString
    }
    
    func getTvShowsGeneresString(genereNumber:[Int])->String
    {
        var genereString = ""
        for genere in AppManager.shared.tvSeriesGeneres
        {
            for i in stride(from: 0, to: genereNumber.count, by: 1)
            {
                if genere.id == genereNumber[i]
                {
                    genereString += "\(genere.name),"
                }
            }
        }
        return genereString
    }
    
    
    func getNowPlayingMovies(completion : @escaping ()->())
    {
        
        let url = "https://api.themoviedb.org/3/movie/now_playing?api_key=d08168bdea162076c5d5bb799daac437&language=en-US&page=1"
        
        let urlNew = URL(string: url)
        URLSession.shared.dataTask(with: urlNew!) { (data, response, error) in
            if let data = data
            {
                let nowPlayingMovies = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String : AnyObject]
                let movies = nowPlayingMovies!["results"] as! [[String : AnyObject]]
                
                for movie in movies
                {
                    let voteCount = movie["vote_count"] as! Int
                    let id = movie["id"] as! Int
                    let video = movie["video"] as! Bool
                    let voteAverege = movie["vote_average"] as! Double
                    let title = movie["title"] as! String
                    let popularity = movie["popularity"] as! Float
                    let posterPath =  movie["poster_path"] as! String
                    let originalLanguage =  movie["original_language"] as! String
                    let originalTitle = movie["original_title"] as! String
                    let genreIds = movie["genre_ids"] as! [Int]
                    let backDropPath = movie["backdrop_path"] as! String
                    let adult = movie["adult"] as! Bool
                    let overview = movie["overview"] as! String
                    let releaseDate = movie["release_date"] as! String
                    
                    let newMovie = Movie(voteCount: voteCount, id: id, video: video, voteAverege: voteAverege, title: title, popularity: popularity, posterPath:"https://image.tmdb.org/t/p/w300\(posterPath)", originalLanguage: originalLanguage, originalTitle: originalTitle, genreIds: genreIds, backdropPath: "https://image.tmdb.org/t/p/w300\(backDropPath)", adult: adult, overview: overview, releaseDate: releaseDate)
                    AppManager.shared.nowPlayingMovies.append(newMovie)
                }
                
                completion()
                
            }
            
            }.resume()
        
        
    }
    
    func getTvShowsAiringNow(completion : @escaping ()->())
    {
        let url = "https://api.themoviedb.org/3/tv/airing_today?api_key=d08168bdea162076c5d5bb799daac437&language=en-US&page=1"
        
        let urlNew = URL(string: url)
        URLSession.shared.dataTask(with: urlNew!) { (data, response, error) in
            if let data = data
            {
                let nowOnAirTvShows = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String : AnyObject]
                let tvShows = nowOnAirTvShows!["results"] as! [[String : AnyObject]]
                for tvShow in tvShows
                {
                    let originalName = tvShow["original_name"] as! String
                    let genreIds = tvShow["genre_ids"] as! [Int]
                    let name = tvShow["name"] as! String
                    let popularity = tvShow["popularity"] as! Float
                    let originCoutry = tvShow["origin_country"] as! [String]
                    let voteCount = tvShow["vote_count"] as! Int
                    let firstAirDate = tvShow["first_air_date"] as! String
                    var backDropPath = ""
                    if let backDropPathNew = tvShow["backdrop_path"] as? String
                    {
                        backDropPath = backDropPathNew
                    }
                    let originalLanguage = tvShow["original_language"] as! String
                    let id = tvShow["id"] as! Int
                    let voteAverege = tvShow["vote_average"] as! Double
                    let overview = tvShow["overview"] as! String
                    var posterPath = ""
                    if let posterPathNew = tvShow["poster_path"] as? String
                    {
                        posterPath = posterPathNew
                    }
                    
                    let newTvShow = TvShow(originalName: originalName, genreIds: genreIds, name: name, popularity: popularity, originCountry: originCoutry, voteCount: voteCount, firstAirDate: firstAirDate, backdropPath: "https://image.tmdb.org/t/p/w300\(backDropPath)", originalLanguage: originalLanguage, id: id, voteAverege: voteAverege, overview: overview, posterPath:"https://image.tmdb.org/t/p/w300\(posterPath)")
                    AppManager.shared.onAirNow.append(newTvShow)
                }
                
                completion()
                
            }
            }.resume()
        
    }
    
    
    
}
