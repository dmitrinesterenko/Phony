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
    
    @IBOutlet weak var duration: UILabel!
    
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
        player = Player(fileUrl: fileUrl)
        player.play()
        
        while(player.playing){
            duration.text = "\(player.currentTime) of  \(player.duration.description)s"
        }
        
        
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
        //TODO: Refactor into a UIStateUpdater
        sender.setTitle("Record", forState: UIControlState.Normal)
        sender.removeTarget(self, action: "stop:", forControlEvents:UIControlEvents.TouchUpInside)
        sender.addTarget(self, action: "record:", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    @IBAction func playLast(sender: AnyObject) {
        recorder.playLast()
    }
}

