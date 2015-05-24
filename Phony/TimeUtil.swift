//
//  TimeUtil.swift
//  Phony
//
//  Created by Dmitri Nesterenko on 5/24/15.
//  Copyright (c) 2015 Dmitri Nesterenko. All rights reserved.
//

import Foundation

class TimeUtil{
    
    static func delayFromNow(delayInSeconds:Double) -> UInt64{
        return dispatch_time(DISPATCH_TIME_NOW, (Int64) (delayInSeconds * Double(NSEC_PER_SEC)))
    }
}
