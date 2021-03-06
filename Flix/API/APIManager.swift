//
//  APIManager.swift
//  Flix
//
//  Created by Pat Khai on 9/28/18.
//  Copyright © 2018 Pat Khai. All rights reserved.
//

import Foundation
class APIManager {
    
    
static let baseUrl = "https://api.themoviedb.org/3/movie/"
static let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
var session: URLSession

init() {
    session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
}

func nowPlayingMovies(completion: @escaping ([Movie]?, Error?) -> ()) {
    let url = URL(string: APIManager.baseUrl + "now_playing?api_key=\(APIManager.apiKey)")!
    makeRequest(from: url, completion: completion)
}
func fetchTrailer(movieId id: Int, completion: @escaping (URLRequest?, Error?) -> ()) {
        let url = URL(string: APIManager.baseUrl + "\(id)/videos?api_key=\(APIManager.apiKey)")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(nil, error)
            } else if let data = data {
                let dataDictionary =  try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any] //cast dictionary[]
                let videos = dataDictionary["results"] as! [[String: Any]]
                let video = videos[0]
                let key = video["key"] as! String
                if  let youtubeURL = URL(string: "https://www.youtube.com/watch?v=" + key) {
                    let youtubeRequest = URLRequest(url: youtubeURL)
                completion(youtubeRequest, nil)
                }
            }
        }
        task.resume()
    }
    

    
    func popularMovies(completion: @escaping ([Movie]?, Error?) -> ()) {
        let url = URL(string: APIManager.baseUrl + "popular?api_key=\(APIManager.apiKey)")!
        makeRequest(from: url, completion: completion)
    }
    
    
    private func makeRequest(from url: URL, completion: @escaping ([Movie]?, Error?) -> ()) {
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            
            if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let movieDictionaries = dataDictionary["results"] as! [[String: Any]]
                
                let movies = Movie.movies(dictionaries: movieDictionaries)
                completion(movies, nil)
            } else {
                completion(nil, error)
            }
        }
        task.resume()
    }
}
