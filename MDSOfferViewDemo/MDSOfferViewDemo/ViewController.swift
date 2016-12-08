//
//  ViewController.swift
//  MDSOfferViewDemo
//
//  Created by YuAo on 3/16/16.
//  Copyright © 2016 YuAo. All rights reserved.
//

import UIKit
import MDSOfferView

class ViewController: UIViewController {

    @IBOutlet weak var offerView: MDSOfferView!
    
    var showingConfirmation = false
    
    let price = "$2.99"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.offerView.setTitle(price, for: .normal)

        self.offerView.actionHandler = { _ in
            self.offerViewTapped()
        }
    }
    
    func offerViewTapped() {
        if !showingConfirmation {
            showingConfirmation = true
            
            self.offerView.setTitle("BUY", for: .normal)
            self.offerView.tintColor = UIColor(red: 0.039, green: 0.733, blue: 0.545, alpha: 1)
        } else {
            
            self.offerView.setTitle(price, for: .normal)
            self.offerView.tintColor = nil
            
            self.offerView.state = .pendingDownload
            
            Delay(interval: 2.second) {
                
                self.offerView.state = .downloading
                self.offerView.setProgress(0.1, animated: true)
                
            }.then(Delay(interval: 0.6.second) {
                
                self.offerView.setProgress(0.3, animated: true)
                
            }).then(Delay(interval: 0.5.second) {
                
                self.offerView.setProgress(0.7, animated: true)
                
            }).then(Delay(interval: 0.5.second) {
                
                self.offerView.setProgress(0.75, animated: true)
                
            }).then(Delay(interval: 0.5.second) {
                
                self.offerView.setProgress(1.0, animated: true)
                
            }).then(Delay(interval: 0.5.second) {
                
                self.offerView.state = .downloaded
                self.offerView.enabled = false
                
            }).run()
        }
    }
}

