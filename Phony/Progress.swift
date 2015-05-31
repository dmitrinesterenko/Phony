//
//  Progress.swift
//  Phony
//
//  Created by Dmitri Nesterenko on 5/23/15.
//  Copyright (c) 2015 Dmitri Nesterenko. All rights reserved.
//

import Foundation
import UIKit

class Progress{

    var view : UIView
    var width : CGFloat = 50.0
    var height : CGFloat = 50.0
    var progress : UIView
    var playbackProgress: UIView
    var recordingProgress: UIView
    var intermissionSeconds : Double
    
    init(inView: UIView){
        view = inView
        intermissionSeconds = 0.6
        progress = UIView()
        playbackProgress = UIView()
        recordingProgress = UIView()
        start()

    }
    
    deinit{
        unload()
    }
    
    func start(){
        view.addSubview(progress)
        progress.alpha = 1.0
        progress.backgroundColor = UIColor.blackColor()
        progress.frame = CGRect(x:0, y:0, width:self.view.frame.width, height:self.height)
    }
    
    func fadeOut(element: UIView, duration:NSTimeInterval){
        UIView.animateWithDuration(duration,
            animations: {
                element.alpha = 0
            },
            completion: { finished in
                //TODO decide if the element should be removed from it's super view
                Log.debug("Finished \(__FUNCTION__)")
            })
    }
    
    func fadeIn(element: UIView, duration:NSTimeInterval){
        UIView.animateWithDuration(duration,
            animations: {
                element.alpha = 1
            },
            completion: { finished in
                //TODO decide if the element should be removed from it's super view
                Log.debug("Finished \(__FUNCTION__)")
        })
    }
    
    func showFirstStep(duration:NSTimeInterval){
        UIView.animateWithDuration(duration,
            animations: {
                self.progress.backgroundColor = UIColor.whiteColor()
                self.progress.frame = CGRect(x:0, y:self.view.frame.height - self.height - 50, width:self.view.frame.width, height:self.height)
            },
            completion: { finished in
                Log.debug("Finished \(__FUNCTION__)")
               
        })
    }
    // Intermission changes the color to red
    func showSecondStep(duration:NSTimeInterval){
        self.view.addSubview(recordingProgress)
        self.recordingProgress.backgroundColor = self.progress.backgroundColor
        self.recordingProgress.frame = CGRect(x:self.view.frame.width, y:self.view.frame.height - self.height - 50, width:0, height:self.height)
        
        UIView.animateWithDuration(duration,
            animations: {
                self.recordingProgress.backgroundColor = UIColor.redColor()
                self.recordingProgress.frame = CGRect(x:0, y:self.view.frame.height - self.height - 50, width:self.view.frame.width, height:self.height)
            },
            completion: { finished in
                Log.debug("Finished \(__FUNCTION__)")
        })
    }
    
    func showThirdStep(duration:NSTimeInterval){
        self.view.addSubview(playbackProgress)
        self.playbackProgress.backgroundColor = UIColor.greenColor()
        self.playbackProgress.frame = CGRect(x:0, y:self.view.frame.height - self.height - 50, width:0, height:self.height)
        UIView.animateWithDuration(duration,
            animations: {
                self.playbackProgress.frame = CGRect(x:0, y:self.view.frame.height - self.height - 50, width:self.view.frame.width, height:self.height)
            },
            completion: { finished in
                Log.debug("Finished \(__FUNCTION__)")
                self.unload()
        })
    }
    
    func showIntermission(){
        let blips = 3
        for index in 1...blips {
            let duration = (self.intermissionSeconds / Double(blips))
            let delayInSeconds = duration * Double(index)
            Conductor.playAfter(delayInSeconds){
                self.blip(duration)
            }
  
        }
        
    }
    
    func recording(){
        UIView.animateWithDuration(0.5,
            animations: {
                self.progress.backgroundColor = UIColor.redColor()
            },
            completion: { finished in
                Log.debug("Finished \(__FUNCTION__)")
        })

    }
    
    private func blip(duration:NSTimeInterval){
        var options = UIViewAnimationOptions.Autoreverse | UIViewAnimationOptions.Repeat
        UIView.animateWithDuration(duration,
            animations: {
                Log.debug("Animating \(__FUNCTION__)")
                self.progress.alpha = 0.2
            },
            completion: { finished in
                if finished {
                    self.progress.alpha = 1
                    Log.debug("Finished \(__FUNCTION__)")
                }
        })
        
    }
    
    private func unload(){
        self.progress.removeFromSuperview()
        self.playbackProgress.removeFromSuperview()
        self.recordingProgress.removeFromSuperview()
    }
}
