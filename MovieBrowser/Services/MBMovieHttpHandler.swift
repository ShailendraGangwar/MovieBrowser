//
//  MBMovieHttpHandler.swift
//  MovieBrowser
//
//  Created by Shailendra Gangwar on 06/11/18.
//  Copyright © 2018 Shailendra Gangwar. All rights reserved.
//

import Foundation

/**
 ## MBMovieHttpHandler responsible for:
 - Creating a url session and making request.
 */
class MBMovieHttpHandler {
    
    /// Url session
    static let session = URLSession.shared
    
    /**
     Get movies list.
     - Parameter topic: topic to be searched for movies.
     - Parameter completion: completion block.
     */
    static func getMovies(topic: String, completion: @escaping (Error?, [MBMovie]?) -> Void) {
        session.dataTask(with: URL(string: "\(MBUrls.movieListURL)\(topic)")!, completionHandler: { (data, response, error) in
            if let error = error {
                completion(error, [])
                
            } else if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let searchResults = try decoder.decode(SearchResults.self, from: data)
                    completion(nil, searchResults.search)
                } catch {
                    print("decoding error: \(error.localizedDescription)")
                }
            }
        }).resume()
    }
    
    /**
     Get feaatured movies list.
     - Parameter topic: topic to be searched for movies.
     - Parameter completion: completion block.
     */
    static func getFeatureMovies(topic: String, completion: @escaping (Error?, [MBMovie]?) -> Void) {
        session.dataTask(with: URL(string: "\(MBUrls.featuredURL)\(topic)")!, completionHandler: { (data, response, error) in
            if let error = error {
                completion(error, [])
            } else if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let searchResults = try decoder.decode(SearchResults.self, from: data)
                    completion(nil, searchResults.search)
                } catch {
                    print("decoding error: \(error.localizedDescription)")
                }
            }
        }).resume()
    }
    
    /**
     Get movies details.
     - Parameter movie: movie to be searched.
     - Parameter completion: completion block.
     */
    static func getDetailsFor(movie: String, completion: @escaping (Error?, MBMovie?) -> Void) {
        session.dataTask(with: URL(string: "\(MBUrls.titleSearchURL)\(movie)")!, completionHandler: { (data, response, error) in
            if let error = error {
                completion(error, nil)
            } else if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let movie = try decoder.decode(MBMovie.self, from: data)
                    completion(nil, movie)
                } catch {
                    print("decoding error: \(error.localizedDescription)")
                }
            }
        }).resume()
    }
    
}
