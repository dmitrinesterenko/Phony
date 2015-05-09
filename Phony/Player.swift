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
    //var currentFileUrl : NSURL
    init(fileUrl: String){
       // var error:NSError?
        //currentFileUrl = NSURL(string:fileUrl)!
        //audioPlayer = AVAudioPlayer(contentsOfURL: currentFileUrl, error: &error)
        //if error != nil{
        //    Log.exception(error!.localizedDescription)
        //}
    }
    
    func play(fileUrl: String){
        var error:NSError?
        var currentFileUrl = NSURL(string:fileUrl)!
        Log.debug(fileUrl)
        audioPlayer = AVAudioPlayer(contentsOfURL: currentFileUrl, error: &error)

        audioPlayer.prepareToPlay()
        audioPlayer.play()
    }
    
    func length(){
       //audioPlayer.
    }
}