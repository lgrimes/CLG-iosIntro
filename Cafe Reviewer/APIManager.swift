//
//  APIManager.swift
//  Cafe Reviewer
//
//  Created by Lauren Grimes on 29/8/17.
//  Copyright © 2017 Code like a girl. All rights reserved.
//

import Foundation
import UIKit

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
    
    var localCachesPath : String {
        get {
            return NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0]
        }
    }
    
    func getAllResturants(entityID: Int, entityType: String, collectionID: Int, completion: @escaping ([Restaurant]) -> Void ){
        if let url = URL(string: urlString + "?entity_id=259&entity_type=city&collection_id=1") {
            let request = NSMutableURLRequest(url: url)
            request.addValue(userKey, forHTTPHeaderField: "user-key")
            request.httpMethod = "GET"
            URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
                var restaurants: [Restaurant] = []
                if let response = response as? HTTPURLResponse {
                    if response.statusCode < 400 {
                        if let data = data {
                            if let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String: Any] {
                                if let restsDict = json["restaurants"] as? [Any] {
                                    for node in restsDict {
                                        if let restDict = node as? [String: Any] {
                                            if let restNode = restDict["restaurant"] as? [String: Any] {
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
                                                if let featured = restNode["featured_image"] as? String {
                                                    restaurant.featuredImageUrlString = featured
                                                }
                                                if let menuURL = restNode["menu_url"] as? String {
                                                    restaurant.menuUrlString = menuURL
                                                }
                                                restaurants.append(restaurant)
                                            }
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
    
    func getImageAtURL(remoteURLString: String, localFileName: String, completion: @escaping (Bool) -> Void) {
        if let url = URL(string: remoteURLString) {
            let request = NSMutableURLRequest(url: url)
            request.httpMethod = "GET"
            URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode < 300 && data != nil {
                        let filename = URL(fileURLWithPath: self.localCachesPath + "/\(localFileName).jpeg")
                        do {
                            try data!.write(to: filename)
                            completion(true)
                        } catch {
                            completion(false)
                        }
                    }
                }
                completion(false)
            }).resume()
        } else {
            completion(false)
        }
        
    }
}
