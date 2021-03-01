//
//  QRScannerViewController.swift
//  QRCodeReader
//
//  Created by KM, Abhilash a on 08/03/19.
//  Copyright © 2019 KM, Abhilash. All rights reserved.
//

import UIKit
import JGProgressHUD


class QRScannerViewController: UIViewController {
    
    @IBOutlet weak var lblTitle : UILabel!
    var obj = HeaderView()
    let hud = JGProgressHUD(style: .dark)
    
    @IBOutlet weak var scannerView: QRScannerView! {
        didSet {
            scannerView.delegate = self
        }
    }
   
    
    var qrData: QRData? = nil {
        didSet {
            if qrData != nil {
                self.performSegue(withIdentifier: "detailSeuge", sender: self)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpPage()
        lblTitle.text = "Hold the QR code in front \n of the camera"
    }
    
    func setUpPage() {
        self.navigationController?.navigationBar.isHidden = true
        guard let header = loadViewFromNib() else { return }
        self.view.addSubview(header)
        obj = header as! HeaderView
        obj.setShadow()
    }
      
    func loadViewFromNib() -> UIView? {
        let nib = UINib(nibName: "HeaderView", bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if !scannerView.isRunning {
            scannerView.startScanning()
            
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if !scannerView.isRunning {
            scannerView.stopScanning()
        }
    }
}


extension QRScannerViewController: QRScannerViewDelegate {
    func qrScanningDidStop() {
//        let buttonTitle = scannerView.isRunning ? "STOP" : "SCAN"
//        scanButton.setTitle(buttonTitle, for: .normal)
    }
    
    func qrScanningDidFail() {
        self.presentAlert(withTitle: "", message: "Scanning Failed. Please try again") {
            (str) in
        }
        
    }
    
    func qrScanningSucceededWithCode(_ str: String?) {
        self.qrData = QRData(codeString: str)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        callApi()
    }
}

extension QRScannerViewController {
    
    func callApi() {
        
        let dict = ["qrdata"  :   self.qrData]
        ServiceApi.fetchGetRequest(call: ApiCall.checkInQR, prams: dict as [String : Any]) { (response, status) in
            
            DispatchQueue.main.async {
                self.hud.dismiss()
                 self.presentAlert(withTitle: "", message: response ?? "") {
                     [weak self]      (str) in
                    
                    if status ?? false {
                        DispatchQueue.main.asyncAfter(deadline: .now() ) {
                            let vc = Home_storyboard.instantiateViewController(withIdentifier: "WelcomeVC") as! WelcomeVC
                            self?.navigationController?.show(vc, sender: self)
                        }
                    }
                }
            }
        }
    }
}

