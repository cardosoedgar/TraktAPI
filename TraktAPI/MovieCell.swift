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
    
    func setup(with title: String, urlString: String) {
        titleLabel.text = title
        image.image = UIImage(named: "placeholder")
    }
}
