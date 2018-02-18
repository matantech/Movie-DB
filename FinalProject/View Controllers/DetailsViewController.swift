//
//  DetailsViewController.swift
//  FinalProject
//
//  Created by Matan Levi on 21.11.2017.
//  Copyright © 2017 Matan Levi. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    
    
    @IBOutlet weak var mainScrollView: UIScrollView!
    
    @IBOutlet weak var mainView: UIView!
    
    
    @IBOutlet weak var detailsImage: UIImageView!
    
    @IBOutlet weak var detailsName: UILabel!
    
    @IBOutlet weak var detailsRating: UILabel!
    
    
    @IBOutlet weak var detailsOverview: UITextView!
    
    @IBOutlet weak var movieRuntime: UILabel!
    
    @IBOutlet weak var movieRuntimeMins: UILabel!
    
    @IBOutlet weak var movieReleaseDateLabel: UILabel!
    
    @IBOutlet weak var movieReleaseDate: UILabel!
    
    @IBOutlet weak var detailsGeneres: UILabel!
    
    @IBOutlet weak var detailsTableViewLabel: UILabel!
    
    @IBOutlet weak var detailsTableViewOutlet: UITableView!
    
    
    
    var movieOrTvShowSeriesNow = 99
    
    var didGetVideos = false
    
    var didGetTvShowSeasons = false
    
    var didGetMovieRuntime = false
    
    var moviesSourceNumber = 99 // case 0 = moviesNowPlaying, case 1 = popularMovies
    
    var tvShowMain = false
    
    var currentTvShowSeasons : [Season] = []
    
    var currentMovieVideos : [MovieVideo] = []
    
    var currentMovie : Movie!
    
    var currentTvShow : TvShow!
    
    var movieNumber = -1
    
    var tvShowNumber = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch  AppManager.shared.mediaType{
        case .movie:
            getMoviesNow()
        case .tvShow:
            getTvShowsAiringNow()
            
        default:
            break
        }
        
        
        
        mainScrollView.addSubview(mainView)
        mainScrollView.contentSize = CGSize(width: self.mainView.frame.size.width, height: self.mainView.frame.size.height)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRowsToReturn = 0
        switch AppManager.shared.mediaType {
        case .movie:
            if didGetVideos == true
            {
                numberOfRowsToReturn = currentMovieVideos.count            }
        case .tvShow:
            if didGetTvShowSeasons == true
            {
                numberOfRowsToReturn = currentTvShowSeasons.count
            }
        default:
            break
        }
        
        return numberOfRowsToReturn
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cellToReturn : UITableViewCell! = nil
        switch AppManager.shared.mediaType {
        case .movie:
            if didGetVideos == true
            {
                let movieVideosCell = tableView.dequeueReusableCell(withIdentifier: "detailsTableViewCell")
                movieVideosCell?.textLabel?.text = "\(currentMovieVideos[indexPath.row].videoName) video"
                cellToReturn = movieVideosCell
            }
        case .tvShow:
            if didGetTvShowSeasons == true
            {
                let seasonsTvShowCell = tableView.dequeueReusableCell(withIdentifier: "detailsTableViewCell")
                if AppManager.shared.seasons[indexPath.row].seasonName.isEmpty == false
                {
                    seasonsTvShowCell?.textLabel?.text = "\(AppManager.shared.seasons[indexPath.row].seasonName)"
                }else
                {
                    seasonsTvShowCell?.textLabel?.text = "Season \(indexPath.row + 1)"
                }
                
                
                cellToReturn = seasonsTvShowCell
                
            }
        default:
            break
        }
        
        return cellToReturn
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch AppManager.shared.mediaType {
        case .movie:
            ApiHandler.shared.goToYoutubeVideo(videoKey: currentMovieVideos[indexPath.row].videoKey)
        case .tvShow:
            performSegue(withIdentifier: "seasonDetailsSegue", sender: nil)
        default:
            break
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let selectedIndexPath = detailsTableViewOutlet.indexPathForSelectedRow
        {
            if let tvShowSeasonViewController = segue.destination as? TvShowSeasonViewController
            {
                tvShowSeasonViewController.currentSeason = AppManager.shared.seasons[selectedIndexPath.row]
            }
        }
    }
    
    func makeMovieUi()
    {
        detailsName.text = currentMovie.title
        detailsImage.makeImageFromString(imageString: currentMovie.posterPath)
        detailsRating.text = String(currentMovie.voteAverege)
        ApiHandler.shared.getMovieRunTime(movieId: currentMovie.id)
        {
            DispatchQueue.main.async {
                self.movieRuntimeMins.text = "\(String(AppManager.shared.movieRuntime)) Mins"
            }
        }
        
        movieReleaseDate.text = currentMovie.releaseDate
        let generes = ApiHandler.shared.getMoviesGeneresString(genereNumber: currentMovie.genreIds)
        detailsGeneres.text = generes
        detailsOverview.text = currentMovie.overview
        detailsTableViewLabel.text = "Videos"
        
        
    }
    
    func makeTvShowUi()
    {
        movieReleaseDateLabel.isHidden = true
        movieReleaseDate.isHidden = true
        movieRuntime.isHidden = true
        movieRuntimeMins.isHidden = true
        detailsName.text = currentTvShow.name
        detailsImage.makeImageFromString(imageString: currentTvShow.posterPath)
        detailsRating.text = String(currentTvShow.voteAverege)
        let generes = ApiHandler.shared.getTvShowsGeneresString(genereNumber: currentTvShow.genreIds)
        detailsGeneres.text = generes
        detailsOverview.text = currentTvShow.overview
        detailsTableViewLabel.text = "Seasons"
        
    }
    
    func getMoviesNow()
    {
        if AppManager.shared.movieVideos.isEmpty == false
        {
            AppManager.shared.movieVideos.removeAll()
        }
        ApiHandler.shared.getMovieVideos(movieId: currentMovie.id)
        {
            if self.currentMovieVideos.isEmpty == false
            {
                self.currentMovieVideos.removeAll()
            }
            self.currentMovieVideos = AppManager.shared.movieVideos
            self.didGetVideos = true
            DispatchQueue.main.async
                {
                    self.makeMovieUi()
                    self.detailsTableViewOutlet.reloadData()
            }
        }
    }
    
    func getTvShowsAiringNow()
    {
        if AppManager.shared.seasons.isEmpty == false
        {
            AppManager.shared.seasons.removeAll()
        }
        ApiHandler.shared.getTvShowSeasonsNumber(tvShowId: currentTvShow.id)
        {
            for i in 0...AppManager.shared.seasonsNumber
            {
                ApiHandler.shared.getTvShowSeasons(tvShowId: self.currentTvShow.id, seasonNumber: i)
                {
                    self.didGetTvShowSeasons = true
                    DispatchQueue.main.async {
                        self.makeTvShowUi()
                        self.detailsTableViewOutlet.reloadData()
                        
                    }
                    
                    
                    
                    
                    
                    if self.currentTvShowSeasons.isEmpty == false
                    {
                        self.currentTvShowSeasons.removeAll()
                    }
                    self.currentTvShowSeasons = AppManager.shared.seasons
                    DispatchQueue.main.async
                        {
                            self.detailsTableViewOutlet.reloadData()
                    }
                }
            }
        }
    }
}




