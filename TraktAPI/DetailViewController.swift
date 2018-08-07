//
//  DetailViewController.swift
//  TraktAPI
//
//  Created by Edgar Cardoso on 06/08/18.
//  Copyright © 2018 Edgar Cardoso. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var runtime: UILabel!
    @IBOutlet weak var tagline: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var overview: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var movie: Movie?
    var manager: MovieManager?
    var gallery = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(cellType: ImageCell.self)
        setupMovie()
    }
    
    func setupMovie() {
        title = movie?.title
        releaseDate.text = movie?.released
        runtime.text = "\(movie?.runtime ?? 0)min"
        tagline.text = movie?.tagline
        rating.text = "\(movie?.rating ?? 0)"
        genre.text = movie?.genres.joined(separator: ", ")
        overview.text = movie?.overview
        manager?.requestImages(with: movie?.tmdbId ?? 0) { images in
            if let images = images {
                self.gallery = images
                self.collectionView.reloadData()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gallery.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: ImageCell.self)
        cell.setup(with: gallery[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.size.width/3
        return CGSize(width: width, height: width * 0.5625)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
    }
}
