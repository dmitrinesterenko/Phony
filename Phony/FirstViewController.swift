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
    //TODO: understand this better
    var player = Player()
    var timer = NSTimer()
    var progress : Progress!
    
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var soundCircle: UIImageView!
    

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.progress = Progress(inView:self.view)
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        

        //TODO: load files from the selected dictionary

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // play is play and record + feedback
    @IBAction func play(sender: AnyObject) {
        let dictionaryUrl = FileManager.dictionariesUrl("Sample")
        let filePath = dictionaryUrl.stringByAppendingPathComponent("Hello.caf")
        let progressSelector : Selector = "updatePlayTime:"
        player = Player(filePath:filePath)
        player.play()
        timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target:self, selector: progressSelector, userInfo: player.currentTime, repeats:true)
        
        progress.start()
        progress.showFirstStep(player.duration)
        Conductor.playAfter(player.duration){
            self.progress.showIntermission()
        }
    
        
        // Start Recording
        // this selector means to check if the time of the recording has surpassed the time
        // of the sample and will stop recording if this is the case
        let checkRecordingTime : Selector = "checkRecordingTime:"

        recorder.record(player.duration)
        timer.invalidate()
        timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target:self, selector: checkRecordingTime,
            userInfo: recorder, repeats:true)
        
    }
    
    // Check if the recorded time exceeds the duration of the sample and indicate that the recording is done
    func checkRecordingTime(sender: AnyObject?){
        if let recorder = sender as? Recorder {
            //TODO: refactor into helper method
            if recorder.currentTime > recorder.durationToRecord{
                //HALT AND CATCH FIRE
                recorder.stop()
            }
        }
        
    }
    
    func updatePlayTime(currentTime:NSTimeInterval){
       duration.text = "\(player.currentTime)"
    }
    
    @IBAction func record(sender: AnyObject) {
        
        
        
//        timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target:self, selector: progressSelector, userInfo: player.currentTime, repeats:true)
        
        
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

