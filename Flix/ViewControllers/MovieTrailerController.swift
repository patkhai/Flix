//
//  MovieTrailerController.swift
//  Flix
//
//  Created by Pat Khai on 9/16/18.
//  Copyright © 2018 Pat Khai. All rights reserved.
//

import UIKit
import WebKit

class MovieTrailerController: UIViewController, WKUIDelegate {

    @IBOutlet weak var wkView: WKWebView!
    var movie : Movie?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchTrailer()
    }
    
    // Do any additional setup after loading the view.
    
    func fetchTrailer() {
        
        let ID = movie?.movieID
        APIManager().fetchTrailer(movieId: ID! ) { (request: URLRequest?, error: Error?) in
            if let error = error {
                self.alertControl()
                print(error.localizedDescription)
            } else if let request = request {
                self.wkView.load(request)
            }
        }
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
