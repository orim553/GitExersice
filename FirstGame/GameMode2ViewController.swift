//
//  GameMode2ViewController.swift
//  FirstGame
//
//  Created by ori mizrachi on 11/1/15.
//  Copyright © 2015 B-Up!. All rights reserved.
//

import UIKit

class GameMode2ViewController: UIViewController {

    @IBOutlet weak var TalkBubble: UIImageView!
    @IBOutlet weak var PlayerTutorial: UIImageView!
    @IBOutlet weak var TutorialText: UITextView!
    @IBOutlet weak var lblScore: UILabel!
    @IBOutlet weak var lblTimer: UILabel!
    @IBOutlet weak var btnUpOutlet: UIButton!
    @IBOutlet weak var btnRightOutlet: UIButton!
    @IBOutlet weak var btnDownOutlet: UIButton!
    @IBOutlet weak var btnLeftOutlet: UIButton!
    @IBOutlet weak var btnPlayOutlet: UIButton!
    
    var PlayCounter : Int = 0
    var Score : Int = 0
    var Timer : NSTimer!
    var TimerShow = 50
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //label stuff
        lblScore.hidden = true
        lblTimer.hidden = true
        
        lblTimer.text = "\(TimerShow)"
        
        //background stuff
        let ivBackGround : UIImageView = UIImageView(frame: CGRectMake(0, 0, 320, 568))
        ivBackGround.image = UIImage(named: "SkySprite.jpg")
        ivBackGround.layer.zPosition = -100
        self.view.addSubview(ivBackGround)
    }

    @IBAction func btnPlay(sender: AnyObject)
    {
        Timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "update", userInfo: nil, repeats: true)
        
        TalkBubble.hidden = true
        PlayerTutorial.hidden = true
        TutorialText.hidden = true
        PlayCounter++
        
        //player and apple create
        self.createPlayer()
        createApples(4)
        //label stuff
        lblScore.hidden = false
        lblTimer.hidden = false
        
        btnPlayOutlet.hidden = true
        
    }
  
    @IBAction func btnUp(sender: AnyObject)
    {
        if  PlayCounter != 0 && TimerShow > 0
        {
            self.view.viewWithTag(1)!.frame = CGRectMake( self.view.viewWithTag(1)!.frame.origin.x,  self.view.viewWithTag(1)!.frame.origin.y-20,  self.view.viewWithTag(1)!.frame.size.width,  self.view.viewWithTag(1)!.frame.size.height)
            self.SubsIsColided()
        }
    }

    @IBAction func btnRight(sender: AnyObject)
    {
        if PlayCounter != 0 && TimerShow > 0
        {
            self.view.viewWithTag(1)!.frame = CGRectMake( self.view.viewWithTag(1)!.frame.origin.x+20,  self.view.viewWithTag(1)!.frame.origin.y,  self.view.viewWithTag(1)!.frame.size.width,  self.view.viewWithTag(1)!.frame.size.height)
            self.SubsIsColided()
        }
    }
    @IBAction func btnDown(sender: AnyObject)
    {
        if PlayCounter != 0 && TimerShow > 0
        {
            self.view.viewWithTag(1)!.frame = CGRectMake( self.view.viewWithTag(1)!.frame.origin.x,  self.view.viewWithTag(1)!.frame.origin.y+20,  self.view.viewWithTag(1)!.frame.size.width,  self.view.viewWithTag(1)!.frame.size.height)
            self.SubsIsColided()
        }
    }
    
    @IBAction func btnLeft(sender: AnyObject)
    {
        if PlayCounter != 0 && TimerShow > 0
        {
            self.view.viewWithTag(1)!.frame = CGRectMake( self.view.viewWithTag(1)!.frame.origin.x-20,  self.view.viewWithTag(1)!.frame.origin.y,  self.view.viewWithTag(1)!.frame.size.width,  self.view.viewWithTag(1)!.frame.size.height)
            self.SubsIsColided()
        }
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
    
    func update()
    {
        TimerShow--
        lblTimer.text = "\(TimerShow)"
        
        if TimerShow == 12
        {
            let ivBonus : UIImageView = UIImageView(frame: CGRectMake(180, 55, 48, 45))
            ivBonus.image = UIImage(named: "a3.jpeg")
            ivBonus.tag = 4
            ivBonus.layer.zPosition = 5
            self.view.addSubview(ivBonus)
        }
        
        if TimerShow % 1 == 0 && TimerShow > 0 && TimerShow < 48
        {
            let x : CGFloat = CGFloat(arc4random()%210)
            let y : CGFloat = CGFloat(arc4random()%400)
            
            let ivApple : UIImageView = UIImageView(frame: CGRectMake(x, y, 48, 45))
            ivApple.image = UIImage(named: "a2.jpeg")
            ivApple.tag = 1010
            ivApple.layer.zPosition = -2
            self.view.addSubview(ivApple)
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
        
        self.gameEnded()
        self.SubsIsColided()
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
    
    func gameEnded()
    {
        if TimerShow == 0
        {
            Timer.invalidate()
            
            //end game image
            let ivGameOver : UIImageView = UIImageView(frame: CGRectMake(0, 40, 320, 397))
            ivGameOver.image = UIImage(named: "GoodJob.jpg")
            ivGameOver.tag = 3
            ivGameOver.layer.zPosition = 3
            self.view.addSubview(ivGameOver)
            
            //your score
            let ScoreLabel = UILabel(frame: CGRectMake(29, 425, 263, 100))
            ScoreLabel.textAlignment = NSTextAlignment.Center
            ScoreLabel.text = "Your Score is: \(Score)"
            ScoreLabel.font = UIFont.systemFontOfSize(30)
            self.view.addSubview(ScoreLabel)
        
            //buttons
            btnDownOutlet.hidden = true
            btnUpOutlet.hidden = true
            btnLeftOutlet.hidden = true
            btnRightOutlet.hidden = true
            
            //score view
            let ScoreSaver : PFObject = PFObject(className: "scores")
            ScoreSaver.setObject(String(Score), forKey: "score")
            ScoreSaver.saveInBackground()
        }
    }
}
