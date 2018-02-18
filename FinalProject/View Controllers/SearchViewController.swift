//
//  SearchViewController.swift
//  FinalProject
//
//  Created by Matan Levi on 3.12.2017.
//  Copyright © 2017 Matan Levi. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    
    
    
    @IBOutlet weak var searchBarLabel: UISearchBar!
    
    @IBOutlet weak var searchTableViewOutlet: UITableView!
    
    
    let titles = ["Movies", "Tv Shows"]
    
    var searchString = ""
    
    var didEndSearch = false
    
    var filteredMovies : [Movie] = []
    
    var filteredTvShows : [TvShow] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func keyboardClose(_ sender: UITapGestureRecognizer) {
        
        view.endEditing(true)
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let returnedView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 30))
        returnedView.backgroundColor = UIColor(hue: 0.6667, saturation: 0.54, brightness: 0.99, alpha: 1.0)
        
        let label = UILabel(frame: CGRect(x: 8, y: 0, width: view.frame.size.width, height: 28))
        label.text = titles[section]
        label.textColor = .black
        returnedView.addSubview(label)
        
        return returnedView
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var cellToReturn = 0
        if didEndSearch == true
        {
            cellToReturn = titles.count
        }
        return cellToReturn
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title = ""
        if didEndSearch == true
        {
            title = titles[section]
        }
        return title
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRows = 0
        if didEndSearch == true
        {
            switch section {
            case 0:
                numberOfRows = filteredMovies.count
            case 1:
                numberOfRows = filteredTvShows.count
            default:
                break
            }
        }
        return numberOfRows
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var searchcell : UITableViewCell! = nil
        if didEndSearch == true
        {
            switch indexPath.section {
            case 0:
                let moviesCell = tableView.dequeueReusableCell(withIdentifier: "movieCell") as! MoviesPlayNowTableViewCell
                moviesCell.movieLabel.text = filteredMovies[indexPath.row].title
                moviesCell.movieRating.text = String(filteredMovies[indexPath.row].voteAverege)
                moviesCell.movieDate.text = filteredMovies[indexPath.row].releaseDate
                let generes = ApiHandler.shared.getMoviesGeneresString(genereNumber: filteredMovies[indexPath.row].genreIds)
                moviesCell.moviesGenereLabel.text = generes
                moviesCell.uiImageMoviePosterPicture.makeImageFromString(imageString: filteredMovies[indexPath.row].posterPath)
                searchcell = moviesCell
            case 1:
                let tvShowsCell = tableView.dequeueReusableCell(withIdentifier: "tvShowCell") as! OnAirTvSeriesNowTableViewCell
                tvShowsCell.tvShowName.text = filteredTvShows[indexPath.row].name
                tvShowsCell.tvShowImageView.makeImageFromString(imageString: filteredTvShows[indexPath.row].posterPath)
                tvShowsCell.tvShowRating.text = String(filteredTvShows[indexPath.row].voteAverege)
                var originCountry = ""
                for country in filteredTvShows[indexPath.row].originCountry
                {
                    originCountry += "\(country),"
                }
                tvShowsCell.tvShowOriginCountry.text = originCountry
                tvShowsCell.tvShowOriginLanguage.text = filteredTvShows[indexPath.row].originalLanguage
                let generes = ApiHandler.shared.getTvShowsGeneresString(genereNumber: filteredTvShows[indexPath.row].genreIds)
                tvShowsCell.tvShowGeneres.text = generes
                searchcell =
                tvShowsCell
            default:
                break
            }
        }
        return searchcell
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchString = searchBarLabel.text!
        ApiHandler.shared.searchMovies(searchString: searchString)
        {
            self.didEndSearch = true
            self.filteredMovies = AppManager.shared.filteredMovies
            DispatchQueue.main.async
                {
                    self.searchTableViewOutlet.reloadData()
                    
            }
        }
        ApiHandler.shared.searchTvShows(searchString: searchString)
        {
            self.didEndSearch = true
            self.filteredTvShows = AppManager.shared.filteredTvShows
            DispatchQueue.main.async
                {
                    self.searchTableViewOutlet.reloadData()
                    
            }
        }
        AppManager.shared.filteredMovies.removeAll()
        AppManager.shared.filteredTvShows.removeAll()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let selectedSection = searchTableViewOutlet.indexPathForSelectedRow?.section
        {
            if let selectedIndexPath = searchTableViewOutlet.indexPathForSelectedRow
            {
                if let detailsViewController = segue.destination as? DetailsViewController
                {
                    switch selectedSection
                    {
                    case 0:
                        
                        AppManager.shared.mediaType = .movie
                        detailsViewController.currentMovie = filteredMovies[selectedIndexPath.row]
                    case 1:
                        
                        AppManager.shared.mediaType = .tvShow
                        detailsViewController.currentTvShow = filteredTvShows[selectedIndexPath.row]
                        
                    default:
                        break
                    }
                }
            }
        }
    }
    
    
    
    
}

