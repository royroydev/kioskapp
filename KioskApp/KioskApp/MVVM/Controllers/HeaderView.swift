//
//  HeaderView.swift
//  KioskApp
//
//  Created by Pankaj on 04/10/20.
//  Copyright © 2020 Pankaj. All rights reserved.
//

import Foundation
import UIKit

class HeaderView : UIView {
    
    @IBOutlet weak var lblHeader     :   UILabel!
    @IBOutlet weak var optionView    :   UIView!
    @IBOutlet weak var lblLang       :   UIView!
    @IBOutlet weak var lblHelp       :    UIView!
    @IBOutlet weak var btnLang       :   UIButton!
    @IBOutlet weak var btnHelp       :   UIButton!
    @IBOutlet weak var bgView        :   UIView!
    
    func setShadow() {
        
        lblHeader.text = "The \n Hotel"
        bgView.layer.shadowColor = UIColor.lightGray.cgColor
        bgView.layer.shadowOpacity = 0.1
        bgView.layer.shadowOffset = .zero
        bgView.layer.shadowRadius = 25
        bgView.layer.shadowPath = UIBezierPath(rect: bgView.bounds).cgPath
        bgView.layer.shouldRasterize = true
        bgView.layer.rasterizationScale = UIScreen.main.scale
    }
}

extension HeaderView {
    
    @IBAction func changeLanguage() {
        print("change")
    }
}
