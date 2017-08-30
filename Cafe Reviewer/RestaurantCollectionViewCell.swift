//
//  RestaurantCollectionViewCell.swift
//  Cafe Reviewer
//
//  Created by Lauren Grimes on 30/8/17.
//  Copyright © 2017 Code like a girl. All rights reserved.
//

import Foundation
import UIKit

class RestaurantCollectionViewCell : UICollectionViewCell {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var ratingLabel: UILabel!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    
    func setDetails(name: String, rating: String) {
        nameLabel.text = name
        ratingLabel.text = rating
    }
    
    override func prepareForReuse() {
        // Remove the image and start animating
        activityIndicator.startAnimating()
        imageView.image = nil
    }
}
