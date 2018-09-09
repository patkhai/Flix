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

    @IBOutlet weak var backDrop: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    @IBOutlet weak var detailLabel: UILabel!

    
    var movies: [String: Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        if let movie = movies {
            titleLabel.text = movie["title"] as? String
            releaseDateLabel.text = movie["release_date"] as? String
            detailLabel.text = movie["overview"] as? String
            let backdropPath = movie["poster_path"] as! String
            let baseURL = "https://image.tmdb.org/t/p/w500"
            let backdropURL = URL(string: baseURL + backdropPath)!
            backDrop.af_setImage(withURL: backdropURL)
           
           
            
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
