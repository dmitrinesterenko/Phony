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
        intermissionSeconds = 1.0
        progress = UIView()
        progress.backgroundColor = UIColor.blackColor()
        progress.frame = CGRect(x:0, y:self.view.frame.height / 2.0, width:self.width, height:self.height)
        self.view.addSubview(progress)
    }
    
    deinit{
       self.progress.removeFromSuperview()
    }
    
    func showFirstStep(duration:NSTimeInterval){
        UIView.animateWithDuration(duration,
            animations: {
                self.progress.backgroundColor = UIColor.whiteColor()
                self.progress.frame = CGRect(x:self.view.frame.width - self.width, y:self.view.frame.height / 2.0, width:self.width, height:self.height)
            },
            completion: { finished in
                println("finished")
        })
    }
    
    func showSecondStep(duration:NSTimeInterval){
        UIView.animateWithDuration(duration,
            animations: {
                self.progress.backgroundColor = UIColor.redColor()
                self.progress.frame = CGRect(x:self.view.frame.width - self.width, y:self.view.frame.height / 2.0, width:self.view.frame.width, height:self.height)
            },
            completion: { finished in
                println("finished")
        })
    }
    
    func showIntermissions(){
        let blips = 3
        for index in 1...blips {
            let duration = self.intermissionSeconds / Double(blips)
            blip(duration)
        }
        
    }
    
    private func blip(duration:NSTimeInterval){
        var options = UIViewAnimationOptions.Autoreverse | UIViewAnimationOptions.Repeat
        UIView.animateWithDuration(duration,
            animations: {
                self.progress.alpha = 0
            },
            completion: { finished in
                println("finished")
        })
        
    }
}
