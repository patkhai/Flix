//
//  TrailerViewController.swift
//  Flix
//
//  Created by Pat Khai on 9/10/18.
//  Copyright © 2018 Pat Khai. All rights reserved.
//

import UIKit
import WebKit

class TrailerViewController: UIViewController, WKUIDelegate {
    var movie : [String: Any]?
    
    @IBOutlet  weak var wkView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchTrailer()
    }
        
        // Do any additional setup after loading the view.
        
    func fetchTrailer() {
        let movieURL = "https://api.themoviedb.org/3/movie/"
        let apiKey = "/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US"
        let movieID = movie! [MovieKeys.movieID] as! NSNumber
        let urlPath = URL(string: movieURL + movieID.stringValue + apiKey)!
        //network request
        let urlRequest = URLRequest(url: urlPath, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            // run when the network request return
            if let error = error {
               self.alertControl()
                print(error.localizedDescription)
            } else if let data = data {
                //parse the API network and turn it into dictionary
                let dataDictionary =  try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any] //cast dictionary[]
                let videos = dataDictionary["results"] as! [[String: Any]]
                
                let video = videos[0]
                let key = video["key"] as! String
                if  let youtubeURL = URL(string: "https://www.youtube.com/watch?v=" + key) {
                let youtubeRequest = URLRequest(url: youtubeURL)
                    self.wkView.load(youtubeRequest)
            }
            }
        }
        task.resume()
    }
    
    func alertControl () {
    let alertController = UIAlertController(title: "No Network Detected", message: "Connect to Network and Try Again" , preferredStyle: .alert)
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) {(action) in
        
    }
    alertController.addAction(cancelAction)
    let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in }
    alertController.addAction(OKAction)
    self.present(alertController, animated: true) {
    // optional code for what happens after the alert controller has finished presenting
    }
    }


    
    @IBAction func backTap(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
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
