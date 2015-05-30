//
//  Log.swift
//  Phony
//
//  Created by Dmitri Nesterenko on 5/9/15.
//  Copyright (c) 2015 Dmitri Nesterenko. All rights reserved.
//

import Foundation

class Log{
    static func exception(message: String, opts: Dictionary<String, NSObject>?=nil){
        log(message);
    }
    
    static func debug(message: String){
       log(message)
    }
    
    private static func log(message: String){
         NSLog(message);
    }
}
