//
//  TvShowSeasonViewController.swift
//  FinalProject
//
//  Created by Matan Levi on 25.11.2017.
//  Copyright © 2017 Matan Levi. All rights reserved.
//

import UIKit

class TvShowSeasonViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var seasonImage: UIImageView!
    
    @IBOutlet weak var seasonName: UILabel!
    
    @IBOutlet weak var seasonNumberLabel: UILabel!
    
    @IBOutlet weak var seasonEpisodesNumber: UILabel!
    
    @IBOutlet weak var episodesTableViewOutlet: UITableView!
    
    var currentSeason : Season!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if currentSeason != nil
        {
            
            makeUi()
            print("Check: \(currentSeason.episodes.count)")
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return currentSeason.episodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let episodeCellNew = tableView.dequeueReusableCell(withIdentifier: "episodeCell") as! EpisodeTableViewCell
        episodeCellNew.episodeImage.makeImageFromString(imageString: currentSeason.episodes[indexPath.row].stillPath)
        episodeCellNew.episodeNumber.text = String(currentSeason.episodes[indexPath.row].number)
        episodeCellNew.episodeName.text = currentSeason.episodes[indexPath.row].name
        episodeCellNew.episodeAirDate.text = currentSeason.episodes[indexPath.row].airDate
        episodeCellNew.episodeOverview.text = currentSeason.episodes[indexPath.row].overview
        
        return episodeCellNew
    }
    
    func makeUi()
    {
        self.seasonImage.makeImageFromString(imageString:
            self.currentSeason.posterPath);
        self.seasonEpisodesNumber.text = String(currentSeason.episodes.count)
        if currentSeason.seasonNumber == 0 || currentSeason.seasonName.isEmpty == false
        {
            seasonNumberLabel.isHidden = true
            seasonName.text = currentSeason.seasonName
            
        }else
        {
            self.seasonNumberLabel.text = String(self.currentSeason.seasonNumber)
        }
        DispatchQueue.main.async
            {
                self.episodesTableViewOutlet.reloadData()
        }
    }
    
    
    
    
    
    
}
