//
//  ViewController.swift
//  FirstGame
//
//  Created by ori mizrachi on 10/19/15.
//  Copyright © 2015 B-Up!. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var lblTimer: UILabel!
    @IBOutlet weak var lblScore: UILabel!
    @IBOutlet weak var btnPlayOutlet: UIButton!
    @IBOutlet weak var ivGoodGuyTutorial: UIImageView!
    @IBOutlet weak var TutorialText: UITextView!
    @IBOutlet weak var ivTalkBubble: UIImageView!
    
    var Timer : NSTimer!
    var Score : Int = 0
    var TimerShow = 15
    var PlayCounter = 0
    var lvlCounter = 1
    var WaitingTimer : NSTimer!
    var WaitingCounter : Int = 0
    var HpShow : UIImageView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //background stuff
        let ivBackGround : UIImageView = UIImageView(frame: CGRectMake(0, 0, 320, 568))
        ivBackGround.image = UIImage(named: "SkySprite.jpg")
        ivBackGround.layer.zPosition = -100
        self.view.addSubview(ivBackGround)
        
        //labels stuff
        lblScore.hidden = true
        lblTimer.hidden = true
    }

    @IBAction func btnUp(sender: AnyObject)
    {
        if TimerShow > 0 && PlayCounter != 0 && Score < 4
        {
            self.view.viewWithTag(1)!.frame = CGRectMake( self.view.viewWithTag(1)!.frame.origin.x,  self.view.viewWithTag(1)!.frame.origin.y-20,  self.view.viewWithTag(1)!.frame.size.width,  self.view.viewWithTag(1)!.frame.size.height)
            self.SubsIsColided()
        }
    }
    
    @IBAction func btnright(sender: AnyObject)
    {
        if TimerShow > 0 && PlayCounter != 0 && Score < 4
        {
            self.view.viewWithTag(1)!.frame = CGRectMake( self.view.viewWithTag(1)!.frame.origin.x+20,  self.view.viewWithTag(1)!.frame.origin.y,  self.view.viewWithTag(1)!.frame.size.width,  self.view.viewWithTag(1)!.frame.size.height)
            self.SubsIsColided()
        }
    }

    @IBAction func btnDown(sender: AnyObject)
    {
        if TimerShow > 0 && PlayCounter != 0 && Score < 4
        {
            self.view.viewWithTag(1)!.frame = CGRectMake( self.view.viewWithTag(1)!.frame.origin.x,  self.view.viewWithTag(1)!.frame.origin.y+20,  self.view.viewWithTag(1)!.frame.size.width,  self.view.viewWithTag(1)!.frame.size.height)
            self.SubsIsColided()
        }
    }
    
    @IBAction func btnLeft(sender: AnyObject)
    {
        if TimerShow > 0 && PlayCounter != 0 && Score < 4
        {
            self.view.viewWithTag(1)!.frame = CGRectMake( self.view.viewWithTag(1)!.frame.origin.x-20,  self.view.viewWithTag(1)!.frame.origin.y,  self.view.viewWithTag(1)!.frame.size.width,  self.view.viewWithTag(1)!.frame.size.height)
            self.SubsIsColided()
        }
    }
    
    @IBAction func btnPlay(sender: AnyObject)
    {
        Timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "update", userInfo: nil, repeats: true)
        PlayCounter++
        btnPlayOutlet.hidden = true
        ivGoodGuyTutorial.hidden = true
        ivTalkBubble.hidden = true
        TutorialText.hidden = true
        
        //player stuff
        self.createPlayer()
        
        //apples stuff
        self.createApples(lvlCounter + 3)
        
        //labels stuff
        lblTimer.hidden = false
        lblScore.hidden = false
    }
    
    func createPlayer()
    {
        let ivGood : UIImageView = UIImageView(frame: CGRectMake(216, 60, 84, 84))
        ivGood.image = UIImage(named: "totoro_by_moedini-d48mazo")
        ivGood.tag = 1
        ivGood.layer.zPosition = -1
        self.view.addSubview(ivGood)
    }
    
    func createApples(apples : Int)
    {
        for var i=0;i<apples;i++
        {
            let x : CGFloat = CGFloat(arc4random()%210)
            let y : CGFloat = CGFloat(arc4random()%400)
            
            let ivApple : UIImageView = UIImageView(frame: CGRectMake(x, y, 48, 45))
            ivApple.image = UIImage(named: "a2.jpeg")
            ivApple.tag = 1001 + i
            ivApple.layer.zPosition = -2
            self.view.addSubview(ivApple)
        }
    }

    
    func SubsIsColided()
    {
        let views : [AnyObject] = self.view.subviews
        for v in views
        {
            if v.tag > 1000 && CGRectIntersectsRect(v.frame, (self.view.viewWithTag(1)?.frame)!)
            {
                v.removeFromSuperview()
                Score++
                lblScore.text = "\(Score)"
            }
            
            else if v.tag == 4 && CGRectIntersectsRect(v.frame, (self.view.viewWithTag(1)?.frame)!)
            {
                v.removeFromSuperview()
                Score = Score + 3
                lblScore.text = "\(Score)"
            }
        }
    }
    
    func update()
    {
        TimerShow--
        lblTimer.text = "\(TimerShow)"
        
        if TimerShow == 12
        {
            let ivBonus : UIImageView = UIImageView(frame: CGRectMake(180, 55, 48, 45))
            ivBonus.image = UIImage(named: "a3.jpeg")
            ivBonus.tag = 4
            self.view.addSubview(ivBonus)
        }
        
        // timer colors
        if TimerShow < 10 && TimerShow % 2 == 0
        {
            lblTimer.textColor = UIColor.redColor()
        }
        
        else
        {
            lblTimer.textColor = UIColor.blackColor()
        }
        self.GameOver()
        self.GameWon()
        self.SubsIsColided()
    }
    
    func GameOver()
    {
        if TimerShow == 0 && Score < 4
        {
            let ivGameOver : UIImageView = UIImageView(frame: CGRectMake(0, 0, 320, 397))
            ivGameOver.image = UIImage(named: "GameOverWedding.png")
            ivGameOver.tag = 3
            self.view.addSubview(ivGameOver)
            Timer?.invalidate()
        }
    }
    
    func GameWon()
    {
        if Score >= lvlCounter + 3
        {
            let ivGoodJob : UIImageView = UIImageView(frame: CGRectMake(0, 0, 320, 397))
            ivGoodJob.image = UIImage(named: "GoodJob.jpg")
            ivGoodJob.tag = 2
            self.view.addSubview(ivGoodJob)
            Timer?.invalidate()
            lvlCounter++
            
            let btnNext : UIButton = UIButton(type: UIButtonType.System) as UIButton
            btnNext.frame = CGRectMake(80, 400, 175, 55)
            btnNext.backgroundColor = UIColor.blackColor()
            btnNext.setTitle("Next Level", forState: UIControlState.Normal)
            btnNext.addTarget(self, action: "buttonAction", forControlEvents: UIControlEvents.TouchUpInside)
            btnNext.titleLabel?.font = UIFont(name: (btnNext.titleLabel?.font?.fontName)!, size: 25)
            
            self.view.addSubview(btnNext)
        }
    }// just git fun
    
    func buttonAction()
    {
        let story : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let NextLevel : NextLevelViewController = story.instantiateViewControllerWithIdentifier("lvl2") as! NextLevelViewController
        self.navigationController?.pushViewController(NextLevel, animated: true)
    }
}