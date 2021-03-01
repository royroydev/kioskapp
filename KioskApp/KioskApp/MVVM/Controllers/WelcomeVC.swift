//
//  WelcomeVC.swift
//  KioskApp
//
//  Created by Pankaj on 04/10/20.
//  Copyright © 2020 Pankaj. All rights reserved.
//

import UIKit

class WelcomeVC: UIViewController , MTSlideToOpenDelegate {

    lazy var slideToOpen: MTSlideToOpenView = {
           let slide = MTSlideToOpenView(frame: CGRect(x: btnSwipe.frame.origin.x, y: btnSwipe.frame.origin.y, width: btnSwipe.frame.size.width, height: btnSwipe.frame.size.height))
           slide.sliderViewTopDistance = 0
           slide.sliderCornerRadius = 28
           slide.showSliderText = true
           slide.thumbnailColor = UIColor.clear
           slide.slidingColor = UIColor.clear
           slide.textColor = UIColor.clear
           slide.sliderBackgroundColor = UIColor.clear
           slide.delegate = self
          
            let tintableImage = #imageLiteral(resourceName: "swipe-left").withRenderingMode(.alwaysTemplate)
            icon.image = tintableImage
            
            slide.thumnailImageView.image =
                tintableImage.imageFlippedForRightToLeftLayoutDirection()
            slide.thumnailImageView.tintColor = .white
           //}
           

           return slide
       }()
    
    @IBOutlet weak var btnSwipe : UIButton!
    @IBOutlet weak var lblMessage : UILabel!
    @IBOutlet weak var icon : UIImageView!
    
    var obj = HeaderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpPage()
    }
    
    func setUpPage() {
        
        let swipeButtonDown: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(continuePressed))
        self.btnSwipe.addGestureRecognizer(swipeButtonDown)
        self.navigationController?.navigationBar.isHidden = true
        guard let header = loadViewFromNib() else { return }
        self.view.addSubview(header)
        obj = header as! HeaderView
        obj.setShadow()
        
        slideToOpen.frame = CGRect(x: 30, y: -15, width: btnSwipe.frame.size.width - 120 , height: btnSwipe.frame.size.height)
        btnSwipe.addSubview(slideToOpen)
        icon.tintColor = .white
        lblMessage.text = "Welcome to the Hotel.\n We are pleased to have \n you as our guest."
    }
    
    func loadViewFromNib() -> UIView? {
        let nib = UINib(nibName: "HeaderView", bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    @objc func continuePressed() {
        self.presentAlert(withTitle: "", message: "Coming Soon", completion: {
            (str) in 
         })
    }
    
    // MARK: MTSlideToOpenDelegate
    func mtSlideToOpenDelegateDidFinish(_ sender: MTSlideToOpenView) {
        let alertController = UIAlertController(title: "", message: "Done!", preferredStyle: .alert)
        let doneAction = UIAlertAction(title: "Okay", style: .default) { (action) in
            sender.resetStateWithAnimation(false)
        }
        alertController.addAction(doneAction)
        self.present(alertController, animated: true, completion: nil)
     }
}
