//
//  VenueCell.swift
//  FSquare
//
//  Created by abdullah barjoud on 6/25/16.
//  Copyright © 2016 abdullah barjoud. All rights reserved.
//

import UIKit
import AlamofireImage

class VenueCell: UITableViewCell {

    @IBOutlet weak var venueImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var tipIconLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    
    
    
    // customize design for all labels and buttons
    override func awakeFromNib() {
        super.awakeFromNib()
        self.titleLabel.textColor = UIColor.fSOrange()
        self.typeLabel.textColor = UIColor.fSLightGray()
        self.locationLabel.textColor = UIColor.fSLightGray()
        self.tipLabel.textColor = UIColor.fSDarkGray()
        self.tipIconLabel.font = UIFont.fSIconFont()
        self.tipIconLabel.text = ""
        self.tipIconLabel.textColor = UIColor.fSLightGray()
        self.ratingLabel.backgroundColor = UIColor.fSGreen()
        self.venueImageView.layer.cornerRadius = 4.0
        self.venueImageView.clipsToBounds = true
        self.ratingLabel.layer.cornerRadius = 8
        self.ratingLabel.clipsToBounds = true
        
        // Initialization code
    }
    
    /*
     Fill all values of labels using nearby model
    */
    func configureCellWithModel(nearby:NearbyModel) -> Void {
        if let venue = nearby.venue,location = venue.location , category = venue.category {
            self.titleLabel.text = venue.name
            self.locationLabel.text = location.address
            self.typeLabel.text = category.name
            self.ratingLabel.text = String(venue.rating!)
        }
        
        if let tips = nearby.tips {
            self.tipLabel.text = tips[0].text
        }
        
        if let photos = nearby.venue?.photos {
            let urlString = photos[0].getImageLink()
            self.venueImageView.af_setImageWithURL(
                NSURL(string: urlString)!,
                placeholderImage:UIImage(named: "placeHolder.png"),
                filter: AspectScaledToFillSizeWithRoundedCornersFilter(size:CGSizeMake(80, 80) , radius: 5.0),
                imageTransition: .CrossDissolve(0.2)
            )
        }


    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
