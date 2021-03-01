//
//  HomeVC.swift
//  KioskApp
//
//  Created by Pankaj on 03/10/20.
//  Copyright © 2020 Pankaj. All rights reserved.
//

import Foundation
import  UIKit

class HomeVC : UIViewController {
    
    @IBOutlet weak var btnCheckIn       : UIButton!
    @IBOutlet weak var btnCheckOut      : UIButton!
    @IBOutlet weak var lblHeader        : UILabel!
    @IBOutlet weak var btnLanguage      : UIButton!
    @IBOutlet weak var btnHelp          : UIButton!
    @IBOutlet weak var lblCheckIn          : UILabel!
    @IBOutlet weak var lblcheckout          : UILabel!
    @IBOutlet weak var imgCheckIn          : UIImageView!
    @IBOutlet weak var imgcheckout          : UIImageView!
    
    var obj = HeaderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpPage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        changeColor(color: .grayColor)
    }
    
    func setUpPage() {
        self.navigationController?.navigationBar.isHidden = true
        guard let header = loadViewFromNib() else { return }
        self.view.addSubview(header)
        obj = header as! HeaderView
        obj.setShadow()
        self.view.viewWithTag(3)?.backgroundColor = .white
        changeColor(color: .grayColor)
    }
    
    func loadViewFromNib() -> UIView? {
        let nib = UINib(nibName: "HeaderView", bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}

extension HomeVC {
    
    func changeColor(color : UIColor) {
        
        lblCheckIn.textColor = color
        if let myImage = UIImage(named: "hotel") {
            let tintableImage = myImage.withRenderingMode(.alwaysTemplate)
            imgCheckIn.image = tintableImage
            imgCheckIn.tintColor = color
        }
    }
    
    @IBAction func checkInPressed(sender : UIButton) {
        changeColor(color: .white)
        self.view.viewWithTag(3)?.backgroundColor = .yellowColor
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            let vc = Home_storyboard.instantiateViewController(withIdentifier: "CheckInVC") as! CheckInVC
            self.navigationController?.show(vc, sender: self)
        }
        
    }
    
    @IBAction func checkOutPressed(sender : UIButton) {
        
    }
    
    @IBAction func helpPressed(sender : UIButton) {
        
    }
    
    @IBAction func chooseLangPressed(sender : UIButton) {
        
    }
    
}
