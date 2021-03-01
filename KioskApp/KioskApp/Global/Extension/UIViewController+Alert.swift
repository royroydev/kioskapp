//
//  UIViewController+Alert.swift
//  QRScanner
//
//  Created by KM, Abhilash a on 11/03/19.
//  Copyright © 2019 KM, Abhilash. All rights reserved.
//

import Foundation
import UIKit


extension UIColor {
    static var yellowColor : UIColor {
        return UIColor(red: 245.0/255.0, green: 175.0/255.0 , blue: 73.0/255.0 , alpha: 1.0)
    }
    
    static var grayColor : UIColor {
        return UIColor(red: 145.0/255.0, green: 145.0/255.0 , blue: 145.0/255.0 , alpha: 1.0)
    }
}



extension UIViewController {
    
    func presentAlert(withTitle title: String, message : String, completion : @escaping(String?) -> Void)
    {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { action in
            //print("You've pressed OK Button")
            completion("OK")
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }

}
