//
//  VideoTableViewCell.swift
//  MoviesApps
//
//  Created by Rifqi Alfaizi on 20/09/22.
//

import youtube_ios_player_helper
import UIKit

class VideoTableViewCell: UITableViewCell {
    
    static var reuseIdentifier = "videoCell"
    
    @IBOutlet weak var playerView: YTPlayerView!
    @IBOutlet weak var videoName: UILabel!
    @IBOutlet weak var videoType: UILabel!
    
    func updateView(video: Video?) {
        guard let video = video else { return }
        self.videoName.text = video.name
        self.videoType.text = "\(video.type)"
        self.playerView.load(withVideoId: "\(video.key)")
    }
    
}
