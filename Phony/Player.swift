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
    
    func play(fileUrl: String){
        var error:NSError?
        let url = NSURL(string: fileUrl)
        audioPlayer = AVAudioPlayer(contentsOfURL: url, error: &error)
        audioPlayer.prepareToPlay()
        audioPlayer.play()
    }
}