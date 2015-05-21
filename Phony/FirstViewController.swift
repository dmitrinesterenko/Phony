//
//  FirstViewController.swift
//  Phony
//
//  Created by Dmitri Nesterenko on 5/2/15.
//  Copyright (c) 2015 Dmitri Nesterenko. All rights reserved.
//

import UIKit
import AVFoundation

class FirstViewController: UIViewController {

    var recorder = Recorder()
    
    //To avoid having to use and understand threading with the play back you can run everything on the main thread
    //including the player here makes the controller functions wait on the 
    //response from a player instance
    var player = Player()
    var timer = NSTimer()
    
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var soundCircle: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TODO: load files from the selected dictionary

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func play(sender: AnyObject) {
        let dictionaryUrl = FileManager.dictionariesUrl("Sample")
        let fileUrl = dictionaryUrl.stringByAppendingPathComponent("Hello.caf")
        let progressSelector : Selector = "updatePlayTime:"
        
        player = Player(fileUrl: fileUrl)
        player.play()
        timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target:self, selector: progressSelector, userInfo: player.currentTime, repeats:true)
       
        UIView.animateWithDuration(0.7, delay: 1.0, options: .CurveEaseOut, animations: {
            self.soundCircle.increaseSize()
            /*
            var basketTopFrame = self.basketTop.frame
            basketTopFrame.origin.y -= basketTopFrame.size.height
            
            var basketBottomFrame = self.basketBottom.frame
            basketBottomFrame.origin.y += basketBottomFrame.size.height
            
            self.basketTop.frame = basketTopFrame
            self.basketBottom.frame = basketBottomFrame
*/
            }, completion: { finished in
                println("Basket doors opened!")
        })
        
    }
    
    func updatePlayTime(currentTime:NSTimeInterval){
       duration.text = "\(player.currentTime)"
    }
    
    @IBAction func record(sender: AnyObject) {
        recorder.record()
        //TODO: Refactor into a UIStateUpdater
        sender.setTitle("Stop", forState: UIControlState.Normal)
        sender.removeTarget(self, action: "record:", forControlEvents:UIControlEvents.TouchUpInside)
        sender.addTarget(self, action: "stop:", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    @IBAction func stop(sender: AnyObject) {
        recorder.stop()
        //TODO: Refactor into a UIStateUpdateri
        timer.invalidate()
        
        
        sender.setTitle("Record", forState: UIControlState.Normal)
        sender.removeTarget(self, action: "stop:", forControlEvents:UIControlEvents.TouchUpInside)
        sender.addTarget(self, action: "record:", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    @IBAction func playLast(sender: AnyObject) {
        recorder.playLast()
    }
}

