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
    var intermissionSeconds : Double
    
    init(inView: UIView){
        view = inView
        intermissionSeconds = 0.6
        progress = UIView()
        self.start()
        self.view.addSubview(progress)
    }
    
    deinit{
       self.progress.removeFromSuperview()
    }
    
    func start(){
        progress.alpha = 1.0
        progress.backgroundColor = UIColor.blackColor()
        progress.frame = CGRect(x:0, y:self.view.frame.height / 2.0, width:self.width, height:self.height)
    }
    func showFirstStep(duration:NSTimeInterval){
        UIView.animateWithDuration(duration,
            animations: {
                self.progress.backgroundColor = UIColor.whiteColor()
                self.progress.frame = CGRect(x:self.view.frame.width - self.width, y:self.view.frame.height / 2.0, width:self.width, height:self.height)
            },
            completion: { finished in
                Log.debug("Finished \(__FUNCTION__)")
                //self.showIntermission()
               
        })
    }
    
    func showSecondStep(duration:NSTimeInterval){
        UIView.animateWithDuration(duration,
            animations: {
                self.progress.backgroundColor = UIColor.redColor()
                self.progress.frame = CGRect(x:self.view.frame.width - self.width, y:self.view.frame.height / 2.0, width:self.view.frame.width, height:self.height)
            },
            completion: { finished in
                Log.debug("Finished \(__FUNCTION__)")
        })
    }
    
    func showIntermission(){
        let blips = 3
        for index in 1...blips {
            //TODO: Refactor this into independent utility methods
            let duration = (self.intermissionSeconds / Double(blips))
            let delayInSeconds = duration * Double(index)
            let popTime = TimeUtil.delayFromNow(delayInSeconds)
            Log.debug("delay \(delayInSeconds)")
       
            // Here have to wait for each to finish
            dispatch_after(popTime, dispatch_get_main_queue(),{
                self.blip(duration)
            })
        }
        
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
}
