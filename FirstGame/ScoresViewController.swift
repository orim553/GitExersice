//
//  ScoresViewController.swift
//  FirstGame
//
//  Created by ori mizrachi on 11/1/15.
//  Copyright © 2015 B-Up!. All rights reserved.
//

import UIKit

class ScoresViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var lblBestScore: UILabel!
    @IBOutlet weak var tbl: UITableView!
    
    var arr : [AnyObject]!
    var bestScore : AnyObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //background stuff
        let ivBackGround : UIImageView = UIImageView(frame: CGRectMake(0, 0, 320, 568))
        ivBackGround.image = UIImage(named: "SkySprite.jpg")
        ivBackGround.layer.zPosition = -100
        self.view.addSubview(ivBackGround)
        
        //tbl stuff
        tbl.backgroundColor = UIColor.clearColor()
    }
    
    override func viewDidAppear(animated: Bool) {
        self.getAllScore()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell : UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("id")
        
        if cell == nil
        {
            
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "id")
        }
        
        let temp : PFObject = arr[indexPath.row] as! PFObject
        
        cell?.textLabel?.text = temp.objectForKey("score") as? String
        cell?.backgroundColor = UIColor.clearColor()
        return cell!
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if arr == nil
        {
            return 0
        }
        return arr.count
    }
    
    func getAllScore()
    {
        let query = PFQuery(className:"scores")
        query.findObjectsInBackgroundWithBlock
            {
                (objects: [PFObject]?, error: NSError?) -> Void in
                if error == nil
                {
                    self.arr = objects
                    self.tbl.reloadData()
                }
        }
    }
}