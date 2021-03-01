//
//  PasswordVC.swift
//  KioskApp
//
//  Created by Pankaj on 03/10/20.
//  Copyright © 2020 Pankaj. All rights reserved.
//

import Foundation
import UIKit
import JGProgressHUD

class PasswordVC: UIViewController  {
    
    @IBOutlet weak var txtPwd : UITextField!
    @IBOutlet weak var borderview : UIView!
    @IBOutlet weak var btnSlide : UIButton!
    
    var obj = HeaderView()
    let hud = JGProgressHUD(style: .dark)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpPage()
    }
    
    func setUpPage() {
        self.navigationController?.navigationBar.isHidden = true
        guard let header = loadViewFromNib() else { return }
        self.view.addSubview(header)
        obj = header as! HeaderView
        obj.setShadow()
        
        borderview.layer.borderColor =  UIColor.lightGray.cgColor
        borderview.layer.borderWidth = 1.0
        borderview.layer.masksToBounds = true
    }
    
    func loadViewFromNib() -> UIView? {
        let nib = UINib(nibName: "HeaderView", bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    @IBAction func onPressed(sender : UIButton) {
        
        if !(txtPwd.text?.isEmpty ?? true) {
        
            hud.textLabel.text = "Loading"
            hud.show(in: self.view)
            callApi()
        }else {
            self.presentAlert(withTitle: "", message: "Please enter the password") {
                (str) in
            }
        }
    }
}


extension PasswordVC {
    
    func callApi() {
        
        let dict = ["password"  :   txtPwd.text ?? ""]
        ServiceApi.fetchGetRequest(call: ApiCall.checkInPwd, prams: dict) { (response, status) in
            
            DispatchQueue.main.async {
                self.hud.dismiss()
                 self.presentAlert(withTitle: "", message: response ?? "") {
                     [weak self]      (str) in
                    
                    if status ?? false {
                        DispatchQueue.main.asyncAfter(deadline: .now() ) {
                            let vc = Home_storyboard.instantiateViewController(withIdentifier: "WelcomeVC") as! WelcomeVC
                            self?.navigationController?.show(vc, sender: self)
                        }
                    }else {
                        self?.txtPwd.text = ""
                    }
                }
            }
        }
    }
}
