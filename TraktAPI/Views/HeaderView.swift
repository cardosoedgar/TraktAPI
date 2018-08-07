//
//  HeaderView.swift
//  TraktAPI
//
//  Created by Edgar Cardoso on 06/08/18.
//  Copyright © 2018 Edgar Cardoso. All rights reserved.
//

import UIKit

class HeaderView: UICollectionReusableView {
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var runtime: UILabel!
    @IBOutlet weak var tagline: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var overview: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(with movie: Movie?) {
        if let movie = movie {
            releaseDate.text = movie.released
            runtime.text = "\(movie.runtime)min"
            tagline.text = movie.tagline
            rating.text = "\(movie.rating)"
            genre.text = movie.genres.joined(separator: ", ")
            overview.text = movie.overview
        }
    }
}
