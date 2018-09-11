//
//  ViewController.swift
//  Flix
//
//  Created by Pat Khai on 9/6/18.
//  Copyright © 2018 Pat Khai. All rights reserved.
//

import UIKit

enum MovieKeys {
    static let title = "title"
    static let releaseDate = "release_date"
    static let overView = "overview"
    static let backdropPath = "backdrop_path"
    static let posterPath = "poster_path"
    static let movieID = "id"
}

class ViewController: UIViewController {
    
    @IBOutlet weak var backDropImage: UIImageView!
    
    @IBOutlet weak var posterImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    @IBOutlet weak var overviewLabel: UILabel!
    
    
    var movies: [String: Any]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let movie = movies {
            titleLabel.text = movie[MovieKeys.title] as? String
            releaseDateLabel.text = movie[MovieKeys.releaseDate] as? String
            overviewLabel.text = movie[MovieKeys.overView] as? String
            let backdropPath = movie[MovieKeys.backdropPath] as! String
            let posterPath = movie[MovieKeys.posterPath] as! String
            let baseURL = "https://image.tmdb.org/t/p/w500"
            let backdropURL = URL(string: baseURL + backdropPath)!
            backDropImage.af_setImage(withURL: backdropURL)
            let posterURL = URL(string: baseURL + posterPath)!
            posterImage.af_setImage(withURL: posterURL)
            
        }
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
