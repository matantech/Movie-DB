//
//  InTheatersViewController.swift
//  FinalProject
//
//  Created by Matan Levi on 19.11.2017.
//  Copyright © 2017 Matan Levi. All rights reserved.
//

import UIKit

class InTheatersOrOnAirNowViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var movieOrTvShow = 99
    var currentMovieOrTvShow = 0
    
    @IBOutlet weak var nowPlayingMoviesOrTvShowsTableViewOutlet: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch movieOrTvShow {
        case 0:
            title = "In Theaters"
        case 1:
            title = "On Air"
        default:
            break
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch movieOrTvShow {
        case 0:
            currentMovieOrTvShow = AppManager.shared.nowPlayingMovies.count
        case 1:
            currentMovieOrTvShow = AppManager.shared.onAirNow.count
        default:
            break
        }
        
        return currentMovieOrTvShow
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cellToReturn : UITableViewCell! = nil
        switch movieOrTvShow {
        case 0:
            let moviesPlayNowCell = tableView.dequeueReusableCell(withIdentifier: "moviesPlayNowTableViewCell") as! MoviesPlayNowTableViewCell
            moviesPlayNowCell.movieLabel.text = AppManager.shared.nowPlayingMovies[indexPath.row].title
            moviesPlayNowCell.movieRating.text = String(AppManager.shared.nowPlayingMovies[indexPath.row].voteAverege)
            moviesPlayNowCell.movieDate.text = AppManager.shared.nowPlayingMovies[indexPath.row].releaseDate
            let generes = ApiHandler.shared.getMoviesGeneresString(genereNumber: AppManager.shared.nowPlayingMovies[indexPath.row].genreIds)
            moviesPlayNowCell.moviesGenereLabel.text = generes
            moviesPlayNowCell.uiImageMoviePosterPicture.makeImageFromString(imageString: AppManager.shared.nowPlayingMovies[indexPath.row].posterPath)
            cellToReturn = moviesPlayNowCell
        case 1:
            let onAirTvShowSeriesNowCell = tableView.dequeueReusableCell(withIdentifier: "onAirTvSeriesNowTableViewCell") as! OnAirTvSeriesNowTableViewCell
            onAirTvShowSeriesNowCell.tvShowName.text = AppManager.shared.onAirNow[indexPath.row].name
            onAirTvShowSeriesNowCell.tvShowImageView.makeImageFromString(imageString: AppManager.shared.onAirNow[indexPath.row].posterPath)
            onAirTvShowSeriesNowCell.tvShowRating.text = String(AppManager.shared.onAirNow[indexPath.row].voteAverege)
            var originCountry = ""
            for country in AppManager.shared.onAirNow[indexPath.row].originCountry
            {
                originCountry += "\(country),"
            }
            onAirTvShowSeriesNowCell.tvShowOriginCountry.text = originCountry
            onAirTvShowSeriesNowCell.tvShowOriginLanguage.text = AppManager.shared.onAirNow[indexPath.row].originalLanguage
            let generes = ApiHandler.shared.getTvShowsGeneresString(genereNumber: AppManager.shared.onAirNow[indexPath.row].genreIds)
            onAirTvShowSeriesNowCell.tvShowGeneres.text = generes
            cellToReturn = onAirTvShowSeriesNowCell
            
        default:
            break
        }
        
        
        return cellToReturn!
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let selectedIndexPath = nowPlayingMoviesOrTvShowsTableViewOutlet.indexPathForSelectedRow
        {
            if let detailsViewController = segue.destination as? DetailsViewController
            {
                
                switch movieOrTvShow {
                case 0:
                    
                    AppManager.shared.mediaType = .movie
                    detailsViewController.currentMovie = AppManager.shared.nowPlayingMovies[selectedIndexPath.row]

                case 1:
                    AppManager.shared.mediaType =
                        .tvShow
                        detailsViewController.currentTvShow = AppManager.shared.onAirNow[selectedIndexPath.row]
                default:
                    break
                }
                
            }
        }
    }
}
