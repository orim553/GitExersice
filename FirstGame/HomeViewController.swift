//
//  HomeViewController.swift
//  FirstGame
//
//  Created by ori mizrachi on 10/31/15.
//  Copyright © 2015 B-Up!. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Home"
        
        
        //background stuff
        let ivBackGround : UIImageView = UIImageView(frame: CGRectMake(0, 0, 320, 568))
        ivBackGround.image = UIImage(named: "SkySprite.jpg")
        ivBackGround.layer.zPosition = -100
        self.view.addSubview(ivBackGround)
    }
    @IBAction func btnPlayMode2(sender: AnyObject)
    {
        let story : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let GameMode2View : GameMode2ViewController = story.instantiateViewControllerWithIdentifier("play2") as! GameMode2ViewController
        self.navigationController?.pushViewController(GameMode2View, animated: true)
    }

    @IBAction func btnScores(sender: AnyObject)
    {
        let story : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let ScoresView : ScoresViewController = story.instantiateViewControllerWithIdentifier("scores") as! ScoresViewController
        self.navigationController?.pushViewController(ScoresView, animated: true)
    }
    
    @IBAction func btnPlay(sender: AnyObject)
    {
        let story : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let PlayView : ViewController = story.instantiateViewControllerWithIdentifier("play") as! ViewController
        self.navigationController?.pushViewController(PlayView, animated: true)
    }
    @IBAction func btnSettings(sender: AnyObject)
    {
        let story : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let SettingsView : SettingsViewController = story.instantiateViewControllerWithIdentifier("settings") as! SettingsViewController
        self.navigationController?.pushViewController(SettingsView, animated: true)
    }

    override func viewDidAppear(animated: Bool) {
        let navbar = self.navigationController?.navigationBar
        navbar?.barStyle = UIBarStyle.BlackOpaque
        navbar?.frame.origin.y = -0.1
    }
}
