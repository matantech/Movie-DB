//
//  ViewController.swift
//  FinalProject
//
//  Created by Matan Levi on 7.11.2017.
//  Copyright © 2017 Matan Levi. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITabBarDelegate, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var firstTableViewOutlet: UITableView!
    
    
    
    var srt = ""
    var nowPlaying : [Movie] = []
    var srtNew = ""
    var onAirNow : [TvShow] = []
    var getNowPlayingMoviesBool = false
    var getOnAirTvShows = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        ApiHandler.shared.getMoviesGeners()
        ApiHandler.shared.getTvShowsGeneres()
        ApiHandler.shared.getNowPlayingMovies{
            DispatchQueue.main.async {
                self.getNowPlayingMoviesBool = true; self.firstTableViewOutlet.reloadData()
            }
        }
        
        ApiHandler.shared.getTvShowsAiringNow {
            DispatchQueue.main.async {
                self.getOnAirTvShows = true; self.firstTableViewOutlet.reloadData()
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let firstCell = tableView.dequeueReusableCell(withIdentifier: "firstCell") as! FirstTableViewCell
        uiMakeShadowDesign(viewForShadowDesign: firstCell.mainViewShadowOutletNew)
        uiMakeDesign(viewForDesign: firstCell.mainViewOutletNew)
        switch indexPath.row {
        case 0:
            if getNowPlayingMoviesBool == true
            {
                firstCell.mainLabel.text = "In Theaters"
                firstCell.imageViewOne.makeImageFromString(imageString: AppManager.shared.nowPlayingMovies[0].posterPath)
                firstCell.imageViewTwo.makeImageFromString(imageString: AppManager.shared.nowPlayingMovies[1].posterPath)
                for i in 0...8
                {
                    self.srt += "\(AppManager.shared.nowPlayingMovies[i].title),"
                }
                firstCell.names.text = srt
            }
        case 1:
            if getOnAirTvShows == true
            {
                firstCell.mainLabel.text = "On Air"
                firstCell.imageViewOne.makeImageFromString(imageString: AppManager.shared.onAirNow[0].posterPath)
                firstCell.imageViewTwo.makeImageFromString(imageString: AppManager.shared.onAirNow[1].posterPath)
                for i in 0...8
                {
                    self.srtNew += "\(AppManager.shared.onAirNow[i].name),"
                }
                firstCell.names.text = srtNew
            }
            
        default:
            break
        }
        
        
        return firstCell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    func uiMakeDesign(viewForDesign : UIView)
    {
        viewForDesign.layer.cornerRadius = 20
        viewForDesign.layer.cornerRadius = 20
        viewForDesign.layer.masksToBounds = true
    }
    
    func uiMakeShadowDesign(viewForShadowDesign : UIView)
    {
        viewForShadowDesign.layer.shadowColor = UIColor.black.cgColor
        viewForShadowDesign.layer.shadowOpacity = 1
        viewForShadowDesign.layer.shadowOffset = CGSize.zero
        viewForShadowDesign.layer.shadowRadius = 10
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let selectedIndexPath = firstTableViewOutlet.indexPathForSelectedRow
            
        {
            if let inTheatereOrOnAirNowViewController = segue.destination as? InTheatersOrOnAirNowViewController
            {
                inTheatereOrOnAirNowViewController.movieOrTvShow = selectedIndexPath.row
            }
        }
    }
    
    
}

