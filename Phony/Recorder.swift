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
    
    //TODO: Move this into it's own class called Boombox
    var audioPlayer = AVAudioPlayer()

    //MARK: Actions
    //TODO: Think about moving most of this into init()
    func record(){
        var audioSession:AVAudioSession = AVAudioSession.sharedInstance()
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
        
        
        var error: NSError?
        //TODO: This has to stay inside record() to make user a new recording is created each time
        var url = storagePath(generateId())
        
        audioRecorder = AVAudioRecorder(
            URL:url,
            settings: recordSettings as [NSObject:AnyObject],
            error: &error)
        //TODO: This can be the way to refactor the initializer but initialize a new recording each time
        //audioRecorder.url
        if let e = error {
            println(e.localizedDescription)
        } else {
            recorded.append(url)
            audioRecorder.record()
        }
    }
    
    func stop(){
        if audioRecorder.recording {
            println("Recording stopped")
            audioRecorder.stop()
        }
    }
    
    func recording() -> Bool {
        return audioRecorder.recording
    }
    
    func playLast(){
        var error:NSError?
        audioPlayer = AVAudioPlayer(contentsOfURL: recorded.last, error: &error)
        audioPlayer.prepareToPlay()
        audioPlayer.play()
    }
    
    //MARK: Helpers
    //TODO: Move these to a shared concern
    private func storagePath(recordingId: String) -> NSURL{
        var documents: AnyObject = NSSearchPathForDirectoriesInDomains( NSSearchPathDirectory.DocumentDirectory,  NSSearchPathDomainMask.UserDomainMask, true)[0]
        var recordings: String = documents.stringByAppendingPathComponent("Recordings")
        var fm = NSFileManager()
        var error: NSError?
        //TODO: Move this to an app initialization state
        fm.createDirectoryAtPath(recordings, withIntermediateDirectories: true, attributes: nil, error: &error)
        if let e = error{
            println(e.localizedDescription)
        }
        var str =  "\(recordings)/\(fileName(recordingId))"
        var url = NSURL.fileURLWithPath(str as String)
        println("url : \(url)")
        return url!
    }
    
    private func fileName(recordingId : String) -> String {
        return "\(recordingId).caf"
    }
    
    private func generateId() -> String{
        return NSUUID().UUIDString
    }
    
    
}
