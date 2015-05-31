//
//  Recorder.swift
//  Phony
//
//  Created by Dmitri Nesterenko on 5/2/15.
//  Copyright (c) 2015 Dmitri Nesterenko. All rights reserved.
//

import Foundation
import AVFoundation
// TODO: Singleton class
class Recorder{
    
    var audioRecorder:AVAudioRecorder!
    var recorded: Array<NSURL> = []
    var durationToRecord: NSTimeInterval = 0.0
    
    //MARK: Actions

    func record(duration: NSTimeInterval){
        //TODO: Think about moving most of this into init()
        var audioSession:AVAudioSession = AVAudioSession.sharedInstance()
        durationToRecord = duration
        
        audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        audioSession.setActive(true, error: nil)
        
        
        var recordSettings = [
            AVFormatIDKey:kAudioFormatAppleIMA4,
            AVSampleRateKey:44100.0,
            AVNumberOfChannelsKey:2,
            AVEncoderBitRateKey:12800,
            AVLinearPCMBitDepthKey:16,
            AVEncoderAudioQualityKey:AVAudioQuality.Max.rawValue
            
        ]
        //TODO: This is to also send over the recording as a record to an external DB
        var id = IdManager.generateId()
        var url = FileManager.recordingStoragePath(id)

        //TODO: This has to stay inside record() to make user a new recording is created each time
        
        //TODO: This can be the way to refactor the initializer but initialize a new recording each time
        //audioRecorder.url
        
        
        var error: NSError?
        audioRecorder = AVAudioRecorder(
            URL:url,
            settings: recordSettings as [NSObject:AnyObject],
            error: &error)

        if let e = error {
            println(e.localizedDescription)
        } else {
            recorded.append(url)
            audioRecorder.record()
            Conductor.playAfter(duration){
                self.stop()
            }
        }
    }
    
    var currentTime : NSTimeInterval{
        return audioRecorder.currentTime
    }
    
    func stop(){
        if audioRecorder.recording {
            audioRecorder.stop()
            Log.debug("Recording stopped")
        }
    }
    
    func recording() -> Bool {
        return audioRecorder.recording
    }
    

    
        
    
}
