//
//  MoviesViewController.swift
//  FinalProject
//
//  Created by Matan Levi on 28.11.2017.
//  Copyright © 2017 Matan Levi. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var didGetMovies = false
    
    @IBOutlet weak var popularMoviesCollectionViewOutlet: UICollectionView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        ApiHandler.shared.getPopularMovies {
            
            self.didGetMovies = true
            DispatchQueue.main.async {
                                   self.popularMoviesCollectionViewOutlet.reloadData()
            }
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var cellsToReturn = 0
        if didGetMovies == true
        {
            cellsToReturn = AppManager.shared.popularMovies.count
        }
        return cellsToReturn
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cellToReturn : UICollectionViewCell!
        if didGetMovies == true
        {
            let movieCell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! MoviesCollectionViewCell
            movieCell.MovieImage.makeImageFromString(imageString: AppManager.shared.popularMovies[indexPath.row].posterPath)
            movieCell.movieLabel.text = AppManager.shared.popularMovies[indexPath.row].title
            cellToReturn = movieCell
            
        }
        
        return cellToReturn
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                if let selectedIndexPath = popularMoviesCollectionViewOutlet.indexPathsForSelectedItems?.first


                {
                    if let detailsViewControllers = segue.destination as? DetailsViewController
                    {
                        
                         AppManager.shared.mediaType = .movie
                        detailsViewControllers.currentMovie = AppManager.shared.popularMovies[selectedIndexPath.item]
                        
                        
            }
        }
    }
    
    
    
    
    
    
}
