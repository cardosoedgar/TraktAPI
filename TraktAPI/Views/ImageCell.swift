//
//  ImageCell.swift
//  TraktAPI
//
//  Created by Edgar Cardoso on 06/08/18.
//  Copyright © 2018 Edgar Cardoso. All rights reserved.
//

import UIKit
import Kingfisher

class ImageCell: UICollectionViewCell, ReusableCell, LoadNib {
    @IBOutlet weak var imageView: UIImageView!
    
    func setup(with url: String) {
        let url = URL(string: "https://image.tmdb.org/t/p/w300\(url)")
        imageView.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"))
    }
}
