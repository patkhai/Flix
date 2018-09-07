//
//  SuperheroViewController.swift
//  Flix
//
//  Created by Pat Khai on 9/6/18.
//  Copyright © 2018 Pat Khai. All rights reserved.
//

import UIKit
import PKHUD
import AlamofireImage

class SuperheroViewController: UIViewController, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var movies: [[String: Any]] = []
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(SuperheroViewController.didPullToRefresh(_:)), for: .valueChanged)
        collectionView.insertSubview(refreshControl, at: 0)
        fetchMovie()

        // Do any additional setup after loading the view.
    }
    
    //for refresh when pull down the movies
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl) {
        fetchMovie()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchMovie() {
    //network referesh
    
    let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
    let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
    //start the HUD
    PKHUD.sharedHUD.contentView = PKHUDProgressView()
    PKHUD.sharedHUD.show(onView: collectionView)
    
    let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
    let task = session.dataTask(with: request) {(data, response, error) in
        //end the HUD
        
        PKHUD.sharedHUD.hide(afterDelay: 1.0)
        
        //Network request returns
        if let error = error {
            print(error.localizedDescription)
        } else if let data = data {
            //parse the API network and turn it into dictionary
            let dataDictionary =  try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any] //cast dictionary[]
            //will get all the movies title in the api
            let movies = dataDictionary["results"] as! [[String: Any]]
            //need this becsaue the system is call the Network api very fast
            self.movies = movies
            self.collectionView.reloadData()
            self.refreshControl.endRefreshing()
            
            
        }
    }
    task.resume()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PosterCell", for: indexPath) as! PosterCell
        let movie = movies[indexPath.item]
        let posterPath = movie[MovieKeys.posterPath] as! String
        let baseURL = "https://image.tmdb.org/t/p/w500"
        let posterURL = URL(string: baseURL + posterPath)!
        cell.posterImage.af_setImage(withURL: posterURL)
        return cell
    }
    
    
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


