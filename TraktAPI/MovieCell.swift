//
//  MovieCell.swift
//  TraktAPI
//
//  Created by Edgar Cardoso on 02/08/18.
//  Copyright © 2018 Edgar Cardoso. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell, ReusableCell, LoadNib {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    func setup(with movie: Movie?) {
        if let movie = movie {
            titleLabel.text = "\(movie.title)(\(movie.year))"
            image.image = UIImage(named: "placeholder")
        }
    }
}
