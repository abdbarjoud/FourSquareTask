//
//  VenueAnnotationView.swift
//  FSquare
//
//  Created by abdullah barjoud on 6/28/16.
//  Copyright © 2016 abdullah barjoud. All rights reserved.
//

import UIKit
import MapKit

class VenueAnnotationView: MKAnnotationView {
    let label:UILabel
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        let frame = CGRectMake(0, 2, 25 ,25)
        label = UILabel(frame: frame)
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        let venueAnnotation = annotation as! VenueAnnotation
        label.text = String("\(venueAnnotation.order)")
        label.textAlignment = NSTextAlignment.Center
        label.textColor = UIColor.whiteColor()
        label.font = UIFont.boldSystemFontOfSize(16)
        self.addSubview(label)
        self.image = UIImage(named: "pin")
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     override init(frame: CGRect) {
        let frame2 = CGRectMake(0, 2, 25 ,25)
        label = UILabel(frame: frame2)
        super.init(frame: frame)
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        if selected {
        self.image = UIImage(named: "pinSelected")
        self.label.textColor = UIColor.fSOrange()
            self.label.frame = CGRectMake(0, 5, 30 ,25)
        }
        else {
            self.image = UIImage(named: "pin")
            self.label.textColor = UIColor.whiteColor()
            self.label.frame = CGRectMake(0, 2, 25 ,25)

        }
    }
    

    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
