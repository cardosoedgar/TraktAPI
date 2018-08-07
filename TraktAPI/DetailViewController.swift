//
//  DetailViewController.swift
//  TraktAPI
//
//  Created by Edgar Cardoso on 06/08/18.
//  Copyright © 2018 Edgar Cardoso. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var movie: Movie?
    var manager: MovieManager?
    var gallery = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(cellType: ImageCell.self)
        collectionView.register(UINib(nibName: "HeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "HeaderView")
        setupMovie()
    }
    
    func setupMovie() {
        title = movie?.title
        manager?.requestImages(with: movie?.tmdbId ?? 0) { images in
            if let images = images {
                self.gallery = images
                self.collectionView.reloadData()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "HeaderView", for: indexPath)
        if let header = header as? HeaderView {
            header.setup(with: movie)
        }
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        var height: CGFloat = 0
        if let header = UINib(nibName: "HeaderView", bundle:nil).instantiate(withOwner: nil, options: nil)[0] as? HeaderView {
            header.setup(with: movie)
            header.setNeedsLayout()
            header.setNeedsUpdateConstraints()
            height = header.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
        }
        return CGSize(width: UIScreen.main.bounds.width, height: height)
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
