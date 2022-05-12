//
//  APIService.swift
//  Podcasts
//
//  Created by abdalla mahmoud on 03/05/2022.
//

import Foundation
import Alamofire
import FeedKit

class APIService {
    
    static let shared = APIService()
    
    func fetchEpisodes(feedUrl: String, completion: @escaping ([Episode]) -> ()) {
        let secureFeedUrl = feedUrl.contains("https") ? feedUrl :
        feedUrl.replacingOccurrences(of: "http", with: "https")
        
        guard let url = URL(string: secureFeedUrl) else { return }
        
        DispatchQueue.global(qos: .background).async {
            let parser = FeedParser(URL: url)
            
            parser.parseAsync { result in
                switch result {
                case .success(let feed):
                    
    //                feed.rssFeed
                    
                    switch feed {
                    case let .rss(feed):
                        
                       let imageUrl = feed.iTunes?.iTunesImage?.attributes?.href
                        
                        var episodes = [Episode]()
                        
                        feed.items?.forEach({ feedItem in
                            var episode = Episode(feedItem: feedItem)
                            
                            if episode.imageUrl == nil {
                                episode.imageUrl = imageUrl
                            }
                            
                            episodes.append(episode)
                        })
                        
                        completion(episodes)
                        
                    default:
                        print("Found a feed...")
                 
                    }
                    
                case .failure(let error):
                    print(error)
                }
                
               
                }
        }
        
    
    }
    
    func fetchPodcasts(searchText: String, completion: @escaping ([Results]) -> Void) {
        
        let url = "https://itunes.apple.com/search"
        let parameters = ["term": searchText, "media": "podcast"]
        
       let request = AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            
        request.responseData { dataResponse in
            if let error = dataResponse.error {
                print("Failed to connect", error)
                return
            }
            
            guard let data = dataResponse.data else { return }
            
            do {
                let searchResult = try JSONDecoder().decode(SearchResult.self, from: data)
                completion(searchResult.results)
//                self.results = searchResult.results
//                self.tableView.reloadData()
                
            } catch let error {
                print("Failed to decode:", error)
            }
        }
        
    }
}
