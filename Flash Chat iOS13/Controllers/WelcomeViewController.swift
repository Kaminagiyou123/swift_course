//
//  WelcomeViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import CLTypingLabel

class WelcomeViewController: UIViewController {
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }

    @IBOutlet weak var titleLabel: CLTypingLabel!
    
    var label = "⚡️FlashChat"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text=label
       
    }
    

}
