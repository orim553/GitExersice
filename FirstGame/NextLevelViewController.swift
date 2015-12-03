//
//  NextLevelViewController.swift
//  FirstGame
//
//  Created by ori mizrachi on 10/31/15.
//  Copyright © 2015 B-Up!. All rights reserved.
//

import UIKit

class NextLevelViewController: UIViewController {
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //background stuff
        let ivBackGround : UIImageView = UIImageView(frame: CGRectMake(0, 0, 320, 568))
        ivBackGround.image = UIImage(named: "SkySprite.jpg")
        ivBackGround.layer.zPosition = -100
        self.view.addSubview(ivBackGround)
    }

    
    

}