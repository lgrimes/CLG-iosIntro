//
//  APIManager.swift
//  Cafe Reviewer
//
//  Created by Lauren Grimes on 29/8/17.
//  Copyright © 2017 Code like a girl. All rights reserved.
//

import Foundation

protocol ZomatoAPIManager { }

extension ZomatoAPIManager {
    var urlString: String {
        get {
            return "https://developers.zomato.com/api/v2.1/search"
        }
    }
    var userKey: String {
        get {
            return "cfac3977b2f99c23e9114bade8c4561d"
        }
    }
    
    var melbourneEntityID: String {
        get {
            return "259"
        }
    }
    
    var trendingCollectionIDForMelbourne: String {
        get {
            return "1"
        }
    }
    
    func getAllResturants(entityID: Int, entityType: String, collectionID: Int, completion: @escaping ([Restaurant]) -> Void ){
        if let url = URL(string: urlString) {
            var headers = [String : String]()
            headers["user-key"] = userKey
            headers["entity_id"] = melbourneEntityID
            headers["entity_type"] = "city"
            headers["collection_id"] = trendingCollectionIDForMelbourne
            let config = URLSessionConfiguration()
            config.httpAdditionalHeaders = headers
            let session = URLSession(configuration: config)
            session.dataTask(with: url, completionHandler: { (data, response, error) in
                var restaurants: [Restaurant] = []
                if let response = response as? HTTPURLResponse {
                    if response.statusCode < 400 {
                        if let data = data {
                            if let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String: Any] {
                                if let restDict = json["restaurants"] as? [Any] {
                                    for node in restDict {
                                        if let restNode = node as? [String: Any] {
                                            let restaurant = Restaurant()
                                            if let name = restNode["name"] as? String {
                                                restaurant.name = name
                                            }
                                            if let cuisine = restNode["cuisines"] as? String {
                                                restaurant.cuisine = cuisine
                                            }
                                            if let link = restNode["url"] as? String {
                                                restaurant.urlString = link
                                            }
                                            if let locationData = restNode["location"] as? [String: Any] {
                                                if let longitude = locationData["longitude"] as? String {
                                                    restaurant.longitude = longitude
                                                }
                                                if let latitude = locationData["latitude"] as? String {
                                                    restaurant.latitude = latitude
                                                }
                                                if let address = locationData["address"] as? String {
                                                    restaurant.address = address
                                                }
                                            }
                                            if let ratingData = restNode["user_rating"] as? [String: Any] {
                                                if let rating = ratingData["aggregate_rating"] as? String {
                                                    restaurant.rating = rating
                                                }
                                            }
                                            if let thumbnail = restNode["thumb"] as? String {
                                                restaurant.thumbnailUrlString = thumbnail
                                            }
                                            if let menuURL = restNode["menu_url"] as? String {
                                                restaurant.thumbnailUrlString = menuURL
                                            }
                                            restaurants.append(restaurant)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                completion(restaurants)
            }).resume()
        }
    }
}
