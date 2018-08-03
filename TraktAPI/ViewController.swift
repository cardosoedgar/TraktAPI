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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(loadMovies), for: .valueChanged)
        collectionView.register(cellType: MovieCell.self)
    }
    
    @objc func loadMovies() {
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: MovieCell.self)
        cell.setup(with: "movie \(indexPath.row) (YEAR)", urlString: "")
        return cell
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

