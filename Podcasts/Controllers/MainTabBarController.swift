//
//  MainTabBarController.swift
//  Podcasts
//
//  Created by abdalla mahmoud on 16/04/2022.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = .purple
        
        
        viewControllers = [
            CreateNavController(for: PodcastsSearchController(), title: "Search", image: #imageLiteral(resourceName: "search")),
            CreateNavController(for: ViewController(), title: "Favorites", image: #imageLiteral(resourceName: "favorites")),
            CreateNavController(for: ViewController(), title: "Downloads", image: #imageLiteral(resourceName: "downloads"))
        ]
        
        setupPlayerDetailsView()
        
    }
    
   @objc func minimizedPlayerDetails() {
       maximizedTopAnchorConstraint.isActive = false
       minimizedTopAnchorConstraint.isActive = true
       
       UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut) {
           self.view.layoutIfNeeded()
           
           self.tabBar.transform = .identity
           
           self.playerDetailsView.maximizedStackView.alpha = 0
           self.playerDetailsView.miniPlayerView.alpha = 1
       }
    }
    
     func maximizePlayerDetails(episode: Episode?) {
        maximizedTopAnchorConstraint.isActive = true
        maximizedTopAnchorConstraint.constant = 0
        minimizedTopAnchorConstraint.isActive = false
         
         if episode != nil {
         playerDetailsView.episode = episode
         }
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut) {
            self.view.layoutIfNeeded()
            
            self.tabBar.transform = CGAffineTransform(translationX: 0, y: 100)
            
            self.playerDetailsView.maximizedStackView.alpha = 1
            self.playerDetailsView.miniPlayerView.alpha = 0
        }
    }
    
    
    // MARK: - Helpers
    let playerDetailsView = PlayerDetailsView.initFromNib()
    
    var maximizedTopAnchorConstraint: NSLayoutConstraint!
    var minimizedTopAnchorConstraint: NSLayoutConstraint!
    
    fileprivate func setupPlayerDetailsView() {
               
        view.insertSubview(playerDetailsView, belowSubview: tabBar)
        
        playerDetailsView.translatesAutoresizingMaskIntoConstraints = false
        
        maximizedTopAnchorConstraint = playerDetailsView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height)
        
        
        maximizedTopAnchorConstraint.isActive = true
        
       minimizedTopAnchorConstraint = playerDetailsView.topAnchor.constraint(equalTo: tabBar.topAnchor, constant: -64)
//        minimizedTopAnchorConstraint.isActive = true
        
        
        playerDetailsView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        playerDetailsView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        playerDetailsView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        
        
    }
    
    fileprivate func CreateNavController(for rootViewController: UIViewController, title: String, image: UIImage) -> UINavigationController {
        
        let navController = UINavigationController(rootViewController: rootViewController)
        rootViewController.view.backgroundColor = .white
        rootViewController.navigationItem.title = title
        navController.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        navController.navigationBar.prefersLargeTitles = true
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        return navController
    }
    
}
