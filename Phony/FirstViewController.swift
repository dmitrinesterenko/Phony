//
//  FirstViewController.swift
//  Phony
//
//  Created by Dmitri Nesterenko on 5/2/15.
//  Copyright (c) 2015 Dmitri Nesterenko. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    var recorder = Recorder()
    var player = Player()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TODO: load files from the selected dictionary
        
        let dictionaryUrl = FileManager.dictionariesUrl("Sample")
        let hello = FileManager.rootUrl().stringByAppendingPathComponent("Hello.caf")
        player.play(hello)
    
        
        
        //TODO: Move into an separate function
        /*var recordAndStop:UIButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        recordAndStop.frame = CGRectMake(0,0,100,44)
        recordAndStop.setTitle("Record", forState: UIControlState.Normal)
        self.view.addSubview(recordAndStop as UIView)
        //Start in the record state
        recordAndStop.addTarget(self, action: "record:", forControlEvents: UIControlEvents.TouchUpInside)
        */
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

