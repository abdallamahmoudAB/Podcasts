//
//  PodcastCell.swift
//  Podcasts
//
//  Created by abdalla mahmoud on 03/05/2022.
//

import UIKit
import SDWebImage

class PodcastCell: UITableViewCell {
    
    @IBOutlet weak var podcastImageView: UIImageView!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var episodeCountLabel: UILabel!
    

    var podcast: Results! {
        didSet {
            trackNameLabel.text = podcast.trackName
            artistNameLabel.text = podcast.artistName
            episodeCountLabel.text = "\(podcast.trackCount ?? 0) Episodes"
            
            guard let url = URL(string: podcast.artworkUrl100 ?? "") else {
                return
            }
            
            // DOWNLOAD IMAGE DATA WITHOUT CACHING
            
//            URLSession.shared.dataTask(with: url) { data, _, _ in
//
//                guard let data = data else { return }
//                DispatchQueue.main.async {
//                    self.podcastImageView.image = UIImage(data: data)
//
//                }
//
//            }.resume()
            
            
            // DOWNLOAD IMAGE DATA WITH CACHING
            
            podcastImageView.sd_setImage(with: url, completed: nil)
        }
    }
}
