//
//  ReusableCell.swift
//  TraktAPI
//
//  Created by Edgar Cardoso on 02/08/18.
//  Copyright © 2018 Edgar Cardoso. All rights reserved.
//
import UIKit

public protocol ReusableCell: class {
    static var reuseIdentifier: String { get }
}

public extension ReusableCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

public protocol LoadNib: class {
    static var nib: UINib { get }
}

public extension LoadNib {
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
    }
}

public extension UICollectionView {
    
    final func register<T: UICollectionViewCell>(cellType: T.Type)
        where T: ReusableCell & LoadNib {
            self.register(cellType.nib, forCellWithReuseIdentifier: cellType.reuseIdentifier)
    }
    
    final func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath, cellType: T.Type = T.self)
        -> T where T: ReusableCell {
            let dequeueCell = self.dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath)
            guard let cell = dequeueCell as? T else {
                fatalError()
            }
            return cell
    }
}
