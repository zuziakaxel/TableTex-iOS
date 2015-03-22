//
//  InfoViewController.swift
//  TableTex-iOS
//
//  Created by Axel Zuziak on 22.03.2015.
//  Copyright (c) 2015 Axel Zuziak. All rights reserved.
//

import UIKit


class InfoViewController: UIViewController {
    
    @IBOutlet weak var txtInfo: UITextView!
    
    @IBOutlet var btnHam: UIButton!
    var blurView: UIView!
    
    
    @IBAction func onBurger() {
        (tabBarController as TabBarController).sidebar.showInViewController(self, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtInfo.backgroundColor = UIColor.clearColor()
        txtInfo.textColor = UIColor.whiteColor()
        blurView = UIView(frame: self.view.frame)
        
        addBlurToView(blurView)
        self.view.insertSubview(blurView, belowSubview: btnHam)
        
        
    }
    
    
    
}