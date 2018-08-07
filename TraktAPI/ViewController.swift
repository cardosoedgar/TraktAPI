//
//  ViewController.swift
//  TraktAPI
//
//  Created by Edgar Cardoso on 02/08/18.
//  Copyright © 2018 Edgar Cardoso. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    let refreshControl = UIRefreshControl()
    
    let manager = MovieManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configInterface()
        loadMovies()
    }
    
    func configInterface() {
        self.collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(loadMovies), for: .valueChanged)
        collectionView.register(cellType: MovieCell.self)
    }
    
    @objc func loadMovies() {
        manager.requestPopularMovies { success in
            if success {
                self.collectionView.reloadData()
                self.refreshControl.endRefreshing()
                return
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return manager.getMoviesCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: MovieCell.self)
        let movie = manager.getMovie(at: indexPath.row)
        cell.setup(with: movie)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            vc.manager = manager
            vc.movie = manager.getMovie(at: indexPath.row)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let vertical = self.traitCollection.verticalSizeClass
        let horizontal = self.traitCollection.horizontalSizeClass
        var width = collectionView.bounds.size.width
        
        if vertical == .regular && horizontal == .regular {
            width = width/6
        } else if (vertical == .compact) {
            width = width/4
        } else {
            width = width/2
        }
        
        return CGSize(width: width, height: width*1.3)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
    }
}

