//
//  NowPlayingViewController.swift
//  Flix
//
//  Created by Pat Khai on 9/5/18.
//  Copyright © 2018 Pat Khai. All rights reserved.
//

import UIKit
import AlamofireImage
import PKHUD

class NowPlayingViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    
    var movies: [[String: Any]] = []
    var refreshControl: UIRefreshControl!
    
//
    override func viewDidLoad() {
        super.viewDidLoad()
      
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(NowPlayingViewController.didPullToRefresh(_:)), for: .valueChanged)
        tableView.dataSource = self
         tableView.rowHeight = 169
        fetchMovies()
        tableView.insertSubview(refreshControl, at: 0)

        
    
        // Do any additional setup after loading the view.


    }
    
    //for refresh when pull down the movies
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl) {
        fetchMovies()
        
    }
   
   
    
    func fetchMovies(){
        //network referesh
       
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US&page=1")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        //start the HUD
        PKHUD.sharedHUD.contentView = PKHUDProgressView()
        PKHUD.sharedHUD.show(onView: tableView)
        
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) {(data, response, error) in
            //end the HUD
        
            PKHUD.sharedHUD.hide(afterDelay: 1.0)
            
            //Network request returns
            if let error = error {
                self.alertControl()
                print(error.localizedDescription)
                
            } else if let data = data {
                //parse the API network and turn it into dictionary
                let dataDictionary =  try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any] //cast dictionary[]
                //will get all the movies title in the api
                let movies = dataDictionary["results"] as! [[String: Any]]
                //need this becsaue the system is call the Network api very fast
                self.movies = movies
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
//               self.activityIndicator.startAnimating()
                
            }
            
        }
        task.resume()
    }
    
    func alertControl () {
        let alertController = UIAlertController(title: "No Network Detected", message: "Connect to Network and Try Again" , preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .cancel) { (action) in }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) {(action) in
            
        }
       
        
        alertController.addAction(OKAction)
         alertController.addAction(cancelAction)
        self.present(alertController, animated: true) {
            // optional code for what happens after the alert controller has finished presenting
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! TableViewMovieCell
        let movie = movies[indexPath.row]
        let title = movie["title"] as! String
        let overview = movie["overview"] as! String
        cell.titleLabel.text = title
        cell.overviewLabel.text = overview
        
        
        //get the image url from api config and actualy image path
        let posterPathURL = movie["poster_path"] as! String
        let baseURLString = "https://image.tmdb.org/t/p/w500"
        let posterURL = URL(string: baseURLString +  posterPathURL)!
        cell.posterImage.af_setImage(withURL: posterURL)
       
        
        return cell
    }
    
    
    //initiation the segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        if let indexPath = tableView.indexPath(for: cell) {
           let movie = movies[indexPath.row]
            let viewController = segue.destination as! ViewController
            viewController.movies = movie
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
