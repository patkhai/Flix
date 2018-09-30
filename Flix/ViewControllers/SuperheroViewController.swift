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
    
    var movies: [Movie?] = []
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(SuperheroViewController.didPullToRefresh(_:)), for: .valueChanged)
        collectionView.insertSubview(refreshControl, at: 0)
        //dynamically layout the rows for the cells
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = layout.minimumInteritemSpacing
        let cellsPerLine: CGFloat = 2
        let interItemSpacing = layout.minimumInteritemSpacing * (cellsPerLine - 1)
        let widthCell = collectionView.frame.size.width / cellsPerLine - interItemSpacing / cellsPerLine
        //start the HUD
        PKHUD.sharedHUD.contentView = PKHUDProgressView()
        PKHUD.sharedHUD.show(onView: collectionView)
        layout.itemSize = CGSize(width: widthCell
            , height: widthCell * 3 / 2)
        
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


        APIManager().popularMovies{ (movies : [Movie]?, error: Error?) in
            if let movies = movies {
                self.movies = movies
            //need this becsaue the system is call the Network api very fast
         PKHUD.sharedHUD.hide(afterDelay: 1.0)
            self.collectionView.reloadData()
            self.refreshControl.endRefreshing()
            
            
            }
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PosterCell", for: indexPath) as! PosterCell
         cell.movie = self.movies[indexPath.item]
      
        return cell
    }
    
    //initiation the segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UICollectionViewCell
        let indexPath = collectionView.indexPath(for: cell)!
            let detailViewController = segue.destination as! ViewController
            detailViewController.movies = self.movies[indexPath.row]
        }

    
    
    func alertControl () {
        let alertController = UIAlertController(title: "No Network Detected", message: "Connect to Network and Try Again" , preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) {(action) in
            
        }
        alertController.addAction(cancelAction)
        let OKAction = UIAlertAction(title: "OK", style: .cancel) { (action) in }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true) {
            // optional code for what happens after the alert controller has finished presenting
        }
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


