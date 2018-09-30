//
//  TableViewMovieCell.swift
//  Flix
//
//  Created by Pat Khai on 9/5/18.
//  Copyright © 2018 Pat Khai. All rights reserved.
//

import UIKit

class TableViewMovieCell: UITableViewCell {

    @IBOutlet weak var posterImage: UIImageView!
    
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    var movie : Movie! {
        didSet {
            self.overviewLabel.text = movie.overview
            self.titleLabel.text = movie.title
            self.posterImage.af_setImage(withURL: (movie.posterURL)!)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
