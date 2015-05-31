//
//  FirstViewController.swift
//  Phony
//
//  Created by Dmitri Nesterenko on 5/2/15.
//  Copyright (c) 2015 Dmitri Nesterenko. All rights reserved.
//

import UIKit
import AVFoundation
import QuartzCore

class FirstViewController: UIViewController {

    var recorder = Recorder()
    
    //To avoid having to use and understand threading with the play back you can run everything on the main thread
    //including the player here makes the controller functions wait on the 
    //response from a player instance
    //TODO: understand this better
    var player = Player()
    var timer = NSTimer()
    var progress : Progress!
    
    @IBOutlet weak var playButton: UIButton!

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.progress = Progress(inView:self.view)
        self.playButton.layer.borderWidth = 1.0
        self.playButton.layer.cornerRadius = 4.0
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        

        //TODO: load files from the selected dictionary

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //
    // 1. Play
    // 2. Record the user
    // 3. Playback the recording to the user
    // The duration of the sample in step 1 determines the entire orchestration of the 3 steps
    @IBAction func play(sender: AnyObject) {
        let dictionaryUrl = FileManager.dictionariesUrl("Sample")
        let filePath = dictionaryUrl.stringByAppendingPathComponent("Hello.caf")
        // Play
        progress.fadeOut(playButton, duration: 0.5)
        player = Player(filePath:filePath)
        player.play()
        
        progress.start()
        progress.showFirstStep(player.duration)
        Conductor.playAfter(player.duration){
            self.progress.showIntermission()
        }
        // Record
        Conductor.playAfter(player.duration+progress.intermissionSeconds){
            //self.progress.recording()
            self.recorder.record(self.player.duration)
            self.progress.showSecondStep(self.player.duration)
           
           
        }

        // Play back 
        Conductor.playAfter(2*player.duration+progress.intermissionSeconds){
            self.progress.showThirdStep(self.player.duration)
            self.player = Player(fileURL:self.recorder.recorded.last!)
            self.player.play()
            self.progress.fadeIn(self.playButton, duration: 0.5)
        }
    }
    
}

