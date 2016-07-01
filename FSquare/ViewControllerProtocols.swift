//
//  ViewControllerProtocols.swift
//  FSquare
//
//  Created by abdullah barjoud on 6/25/16.
//  Copyright © 2016 abdullah barjoud. All rights reserved.
//

import UIKit
import PKHUD
protocol alertProtocol {
    func alertError(message:String) -> Void ;
}

protocol loadingProtocol {
    func startLoader() ->Void
    func endLoader() -> Void
}

extension alertProtocol  where Self:UIViewController {
    func alertError(message:String) -> Void {
        let alert:UIAlertController = UIAlertController(title: "Oops", message: message, preferredStyle: .Alert)
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alert.addAction(defaultAction)
         self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    
    func alertErrorWithHandler(message:String,handler:((UIAlertAction) -> Void)?) -> Void {
        let alert:UIAlertController = UIAlertController(title: "Oops", message: message, preferredStyle: .Alert)
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: handler)
        alert.addAction(defaultAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
}



extension loadingProtocol  where Self:UIViewController {
    func startLoader() ->Void {
        PKHUD.sharedHUD.contentView = PKHUDProgressView()
        PKHUD.sharedHUD.show()
    }
    
    func endLoader() -> Void {
        PKHUD.sharedHUD.hide(afterDelay: 1.0)
    }
    
}


