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
    
    //to avoid threading problems you can run everything on the main thread
    var player = Player(fileUrl:"")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TODO: load files from the selected dictionary
        

    
//        var audioPlayer = AVAudioPlayer()
//        var currentFileUrl = NSURL(string:hello)!
//        var error:NSError?
//        audioPlayer = AVAudioPlayer(contentsOfURL: currentFileUrl, error: &error)
//        
//        audioPlayer.prepareToPlay()
//        audioPlayer.play()
        
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

    @IBAction func play(sender: AnyObject) {
        let dictionaryUrl = FileManager.dictionariesUrl("Sample")
        //let fileUrl = dictionaryUrl.stringByAppendingPathComponent("Hello.caf")
        let fileUrl = FileManager.rootUrl().stringByAppendingPathComponent("Hello.caf")
        
        //hardcoded
       /* var error:NSError?
        var currentFileUrl = NSURL(string:fileUrl)!
        Log.debug(fileUrl)
        audioPlayer = AVAudioPlayer(contentsOfURL: currentFileUrl, error: &error)
        audioPlayer.playing
        if error != nil{
            Log.exception(error!.localizedDescription)
        }
        audioPlayer.prepareToPlay()
        audioPlayer.play()
        //because of threading this stops execution unless we pause the main thread
        //or if we do this on another thread
        while(audioPlayer.playing){
            Log.debug("Playing")
        }
        if audioPlayer.playing{
            Log.debug("Playing")
        }else{
            Log.debug("Not playing")
        }
*/
        //end hardcoded
        
        player = Player(fileUrl: fileUrl)
        player.play(fileUrl	)
        
        
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

