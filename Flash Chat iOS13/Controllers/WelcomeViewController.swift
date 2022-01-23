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

    @IBOutlet weak var titleLabel: CLTypingLabel!

override func viewWillAppear(_ animated: Bool) {
super.viewWillAppear(animated)
navigationController?.isToolbarHidden=true

}

override func viewWillDisappear(_ animated: Bool) {
super.viewWillDisappear(animated)
navigationController?.isToolbarHidden=false

}
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
   
    titleLabel.text=K.appName
        titleLabel.charInterval = 0.08
    }

}
