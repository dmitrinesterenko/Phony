//
//  Conductor.swift
//  Phony
//
//  Created by Dmitri Nesterenko on 5/24/15.
//  Copyright (c) 2015 Dmitri Nesterenko. All rights reserved.
//

import Foundation

class Conductor{
    
    static func playAt(time: NSTimeInterval){
        NSException(name: "Not implemented", reason: "", userInfo: nil).raise()
    }
    
    // After a certain delay execute the tune closure provided which currently
    // does not take or return any parameters
    // NOTE: This currently plays the tune on the dispatch_get_main_queue
    static func playAfter(delayInSeconds:NSTimeInterval, tune: ()->()){
        let popTime = TimeUtil.delayFromNow(delayInSeconds)
        Log.debug("delay \(delayInSeconds)")
        // Here have to wait for each to finish
        dispatch_after(popTime, dispatch_get_main_queue(),{
            tune()
        })
    }
}
