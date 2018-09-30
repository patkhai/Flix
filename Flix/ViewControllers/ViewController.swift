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
    
    var movies: Movie?

    
    @IBAction func posterTap(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "Trailer", sender: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let movie = self.movies {
            titleLabel.text = movie.title
            releaseDateLabel.text = movie.releaseDate
            overviewLabel.text = movie.overview
            backDropImage.af_setImage(withURL: movie.backdropURL!)
            posterImage.af_setImage(withURL: movie.posterURL!)
            
        }
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let MovieController = segue.destination as! MovieTrailerController
        //from the trailer variable movies and pass it to this movies variable
        MovieController.movie = self.movies
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
