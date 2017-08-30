//
//  ViewController.swift
//  Cafe Reviewer
//
//  Created by Lauren Grimes on 26/8/17.
//  Copyright © 2017 Code like a girl. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class HomeViewController: UICollectionViewController, ZomatoAPIManager {
    var cellReuseIdentifier = "restCell"
    var restaurants: [Restaurant] = []
    var cachesPath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0]
    let columnLayout = ColumnFlowLayout(
        cellsPerRow: 3,
        minimumInteritemSpacing: 0,
        minimumLineSpacing: 0,
        sectionInset: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.collectionViewLayout = columnLayout
        DispatchQueue(label: "background").async {
            self.getAllResturants(entityID: 259, entityType: "city", collectionID: 1) { (restaurants) in
                self.restaurants = restaurants
                DispatchQueue.main.async {
                    self.collectionView?.reloadData()
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return restaurants.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as? RestaurantCollectionViewCell
        if indexPath.row < restaurants.count-1 {
            let restuarant = restaurants[indexPath.row]
            cell?.setDetails(name: restuarant.name, rating: restuarant.rating)
            cell?.imageView.sd_setImage(with: URL(string: restuarant.thumbnailUrlString), completed: { (image, error, cacheType, url) in
                cell?.activityIndicator.stopAnimating()
                if let returnedImage = image {
                    cell?.imageView.image = returnedImage
                    self.collectionView?.reloadItems(at: [indexPath])
                }
            })
        }
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width/2.9, height: collectionView.frame.size.width/2.9)
    }
}

