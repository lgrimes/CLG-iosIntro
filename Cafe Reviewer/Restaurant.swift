//
//  Restaurant.swift
//  Cafe Reviewer
//
//  Created by Lauren Grimes on 29/8/17.
//  Copyright © 2017 Code like a girl. All rights reserved.
//

import Foundation

class Restaurant {
    var name: String
    var urlString: String
    var address: String
    var latitude: String
    var longitude: String
    var cuisine: String
    var rating: String
    var thumbnailUrlString: String
    var menuUrlString: String
    
    init(name: String = "",
         urlString: String = "",
         address: String = "",
         latitude: String = "",
         longitude: String = "",
         cuisine: String = "",
         rating: String = "",
         thumbnailUrlString: String = "",
         menuUrlString: String = "") {
        self.name = name
        self.urlString = urlString
        self.address = address
        self.latitude = latitude
        self.longitude = longitude
        self.cuisine = cuisine
        self.rating = rating
        self.thumbnailUrlString = thumbnailUrlString
        self.menuUrlString = menuUrlString
    }
}
