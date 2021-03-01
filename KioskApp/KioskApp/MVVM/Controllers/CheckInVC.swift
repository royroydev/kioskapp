//
//  CheckInVC.swift
//  KioskApp
//
//  Created by Pankaj on 03/10/20.
//  Copyright © 2020 Pankaj. All rights reserved.
//

import UIKit

class CheckInVC: UIViewController {

    @IBOutlet weak var btnQRCode   : UIButton!
    @IBOutlet weak var btnPassword  : UIButton!
    @IBOutlet weak var lblCheckIn   : UILabel!
    @IBOutlet weak var lblPwd       : UILabel!
    @IBOutlet weak var lblCode      : UILabel!
    @IBOutlet weak var icon   : UIImageView!
    @IBOutlet weak var imgkey   : UIImageView!
    
    var obj = HeaderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpPage()
        changeColor(.grayColor, btnQRCode)
    }
    
    func setUpPage() {
        if let myImage = UIImage(named: "qr-code-scan") {
            let tintableImage = myImage.withRenderingMode(.alwaysTemplate)
            icon.image = tintableImage
            icon.tintColor = UIColor.white
        }
        
        self.navigationController?.navigationBar.isHidden = true
        guard let header = loadViewFromNib() else { return }
        self.view.addSubview(header)
        obj = header as! HeaderView
        obj.setShadow()
    }
    
    func changeColor(_ color : UIColor , _  btn : UIButton) {
        
        if btn == btnPassword {
            lblPwd.textColor = color
            if let myImage = UIImage(named: "key") {
                let tintableImage = myImage.withRenderingMode(.alwaysTemplate)
                imgkey.image = tintableImage
                imgkey.tintColor = color
            }
        }else {
            lblCode.textColor = color
            if let myImage = UIImage(named: "qr-code-scan") {
                let tintableImage = myImage.withRenderingMode(.alwaysTemplate)
                icon.image = tintableImage
                icon.tintColor = color
            }
        }
    }
      
    func loadViewFromNib() -> UIView? {
        let nib = UINib(nibName: "HeaderView", bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    @IBAction func pwdPressed(sender : UIButton) {
        changeColor(.white, sender)
        self.view.viewWithTag(4)?.backgroundColor = .yellowColor
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            let vc = Home_storyboard.instantiateViewController(withIdentifier: "PasswordVC") as! PasswordVC
            self.navigationController?.show(vc, sender: self)
        }
    }
    
    @IBAction func qrCodePressed(sender : UIButton) {
        changeColor(.white, sender)
        self.view.viewWithTag(3)?.backgroundColor = .yellowColor
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            let vc = Home_storyboard.instantiateViewController(withIdentifier: "QRScannerViewController") as! QRScannerViewController
            self.navigationController?.show(vc, sender: self)
        }
    }
}

extension CheckInVC {
    
  
}
