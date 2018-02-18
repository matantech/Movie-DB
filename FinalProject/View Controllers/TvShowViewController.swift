//
//  TvShowViewController.swift
//  FinalProject
//
//  Created by Matan Levi on 28.11.2017.
//  Copyright © 2017 Matan Levi. All rights reserved.
//

import UIKit

class TvShowViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var popularTvShowsCollectionView: UICollectionView!
    
    
    var didGetTvShows = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ApiHandler.shared.getPopularTvShows
            {
                self.didGetTvShows = true
                DispatchQueue.main.async {
                    self.popularTvShowsCollectionView.reloadData()
                }
        }
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var cellsToReturn = 0
        if didGetTvShows == true
        {
            cellsToReturn = AppManager.shared.popularTvShows.count
        }
        return cellsToReturn
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cellToReturn : UICollectionViewCell!
        if didGetTvShows == true
        {
            let tvShowsCell = collectionView.dequeueReusableCell(withReuseIdentifier: "tvShowCell", for: indexPath) as! TvShowsCollectionViewCell
            tvShowsCell.tvShowImage.makeImageFromString(imageString: AppManager.shared.popularTvShows[indexPath.row].posterPath)
            tvShowsCell.tvShowLabel.text = AppManager.shared.popularTvShows[indexPath.row].name
            cellToReturn = tvShowsCell
        }
        return cellToReturn
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let selectedIndexPath = popularTvShowsCollectionView.indexPathsForSelectedItems?.first
            
            
        {
            if let detailsViewControllers = segue.destination as? DetailsViewController
            {
                
                AppManager.shared.mediaType = .tvShow
                detailsViewControllers.currentTvShow = AppManager.shared.popularTvShows[selectedIndexPath.item]
                
                
            }
        }
    }

    
    
    
    
}
