//
//  MovieCell.swift
//  TraktAPI
//
//  Created by Edgar Cardoso on 02/08/18.
//  Copyright © 2018 Edgar Cardoso. All rights reserved.
//

import UIKit
import Kingfisher

class MovieCell: UICollectionViewCell, ReusableCell, LoadNib {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    func setup(with movie: Movie?) {
        if let movie = movie {
            titleLabel.text = "\(movie.title)(\(movie.year))"
            let url = URL(string: "http://img.omdbapi.com/?apikey=d06bc8b3&i=\(movie.id)")
            image.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"))
        }
    }
}
