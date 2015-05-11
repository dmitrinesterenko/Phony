//
//  Player.swift
//  Phony
//
//  Created by Dmitri Nesterenko on 5/3/15.
//  Copyright (c) 2015 Dmitri Nesterenko. All rights reserved.
//

import Foundation
import AVFoundation

class Player{
    
    var audioPlayer = AVAudioPlayer()
    var currentFileUrl = NSURL()
    
    var currentTime : NSTimeInterval{
        return audioPlayer.currentTime
    }
    
    var duration : NSTimeInterval{
        return audioPlayer.duration
    }
    
    var playing : Bool{
        return audioPlayer.playing
    }
    
    init (){
    
    }
    
    init(fileUrl: String){
        var error:NSError?
        currentFileUrl = NSURL(string:fileUrl)!
        audioPlayer = AVAudioPlayer(contentsOfURL: currentFileUrl, error: &error)
        if error != nil{
            Log.exception(error!.localizedDescription)
        }
    }
    
    func play(){
        audioPlayer.prepareToPlay()
        audioPlayer.play()
    }
    
    
  
}