//
//  MovieController.swift
//  Flix
//
//  Created by Pat Khai on 9/8/18.
//  Copyright © 2018 Pat Khai. All rights reserved.
//

import UIKit
import PKHUD
import AlamofireImage


class MovieController: UIViewController {


    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    

    @IBOutlet weak var detailLabel: UILabel!

    
    var movies: [String: Any]?
    @IBOutlet weak var posterLabel: UIImageView!
    
 
    @IBAction func posterTap(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "Trailer", sender: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    

        
        if let movie = movies {
            titleLabel.text = movie[MovieKeys.title] as? String
            releaseDateLabel.text = movie[MovieKeys.releaseDate] as? String
            detailLabel.text = movie[MovieKeys.overView] as? String
        
            let posterPath = movie[MovieKeys.posterPath] as! String
            let baseURL = "https://image.tmdb.org/t/p/w500"
            let posterURL = URL(string: baseURL + posterPath)!
            posterLabel.af_setImage(withURL: posterURL)
//
//            // The didTap: method will be defined in Step 3 below.
//            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTap(sender:)))
//
//            // Optionally set the number of required taps, e.g., 2 for a double click
//            tapGestureRecognizer.numberOfTapsRequired = 1
//
//            // Attach it to a view of your choice. If it's a UIImageView, remember to enable user interaction
//            posterLabel.isUserInteractionEnabled = true
//            posterLabel.addGestureRecognizer(tapGestureRecognizer)
//
//
        }
//
        
       
    }
    
   
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let trailerController = segue.destination as! TrailerViewController
        //from the trailer variable movies and pass it to this movies variable
        trailerController.movie = self.movies
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
