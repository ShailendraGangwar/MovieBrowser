//
//  MBMovieHttpHandler.swift
//  MovieBrowser
//
//  Created by Shailendra Gangwar on 06/11/18.
//  Copyright © 2018 Shailendra Gangwar. All rights reserved.
//

import Foundation

class MBMovieHttpHandler {
    
    static let movieListURL = "http://www.omdbapi.com/?apikey=5335e485&s="
    static let titleSearchURL = "http://www.omdbapi.com/?apikey=5335e485&t="
    static let featuredURL = "http://www.omdbapi.com/?apikey=5335e485&y=2018&s="
    static let session = URLSession.shared
    
    static func movieSearch(keyword: String, completion: @escaping (Error?, [MBMovie]?) -> Void) {
        session.dataTask(with: URL(string: "\(movieListURL)\(keyword)")!, completionHandler: { (data, response, error) in
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
    
    static func featureMovieSearch(keyword: String, completion: @escaping (Error?, [MBMovie]?) -> Void) {
        session.dataTask(with: URL(string: "\(featuredURL)\(keyword)")!, completionHandler: { (data, response, error) in
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
    
    static func titleSearch(keyword: String, completion: @escaping (Error?, MBMovie?) -> Void) {
        session.dataTask(with: URL(string: "\(titleSearchURL)\(keyword)")!, completionHandler: { (data, response, error) in
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
