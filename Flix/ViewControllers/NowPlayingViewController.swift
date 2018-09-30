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
    
    
    var movies: [Movie]? = []
    var refreshControl: UIRefreshControl!
    
//
    override func viewDidLoad() {
        super.viewDidLoad()
      
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(NowPlayingViewController.didPullToRefresh(_:)), for: .valueChanged)
        tableView.dataSource = self
        //start the HUD
        PKHUD.sharedHUD.contentView = PKHUDProgressView()
        PKHUD.sharedHUD.show(onView: tableView)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
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
        APIManager().nowPlayingMovies { ( movies : [Movie]?, error: Error?) in
            if let movies = movies {
                self.movies = movies
                self.tableView.reloadData()
        
            //end the HUD
        
     

                self.refreshControl.endRefreshing()
        PKHUD.sharedHUD.hide(afterDelay: 1.0)
//               self.activityIndicator.startAnimating()
                
            }
            
        }
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
       if let movies = self.movies {
            return movies.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! TableViewMovieCell
        cell.movie = self.movies![indexPath.row]
       
        
        return cell
    }
    
    
    //initiation the segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        let viewController = segue.destination as! ViewController
        let indexPath = tableView.indexPath(for: cell)!
        viewController.movies  = self.movies![indexPath.row]
        
        
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
