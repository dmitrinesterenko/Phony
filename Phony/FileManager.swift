//
//  FileManager.swift
//  Phony
//
//  Created by Dmitri Nesterenko on 5/3/15.
//  Copyright (c) 2015 Dmitri Nesterenko. All rights reserved.
//

import Foundation

class FileManager{

    //MARK: Phony specific methods
    static func recordingUrl() -> String{
        var documents: AnyObject = NSSearchPathForDirectoriesInDomains( NSSearchPathDirectory.DocumentDirectory,  NSSearchPathDomainMask.UserDomainMask, true)[0]
        var recordingUrl: String = documents.stringByAppendingPathComponent("Recordings")
        return recordingUrl
    }
    
    static func dictionariesUrl(dictionaryTitle: String) -> String?{
        return NSBundle.mainBundle().resourcePath?.stringByAppendingPathComponent("Dictionaries").stringByAppendingPathComponent(dictionaryTitle)
    }
    
    static func rootUrl() -> String{
        return NSBundle.mainBundle().resourcePath!
        
    }
    
    /*static func getFilesInPath(path: String)->Array{
        var fm = NSFileManager()
        fm.enumeratorAtPath(path)
        
    }*/
    
    static func recordingStoragePath(recordingId: String) -> NSURL{
        var fullPath =  "\(self.recordingUrl())/\(recordingFileName(recordingId))"
        var url = NSURL.fileURLWithPath(fullPath as String)
        println("url : \(url)")
        return url!
    }
    
    static func recordingFileName(Id : String) -> String {
        return "\(Id).caf"
    }
    
    //MARK: General file system methods
    // This is called from AppDelegate init to create if the path does not yet exist
    static func createIfDoesNotExist(path: String){
        var fm = NSFileManager()
        var error: NSError?

        fm.createDirectoryAtPath(path, withIntermediateDirectories: true, attributes: nil, error: &error)
        if let e = error{
            //TODO: This should freak out
            println(e.localizedDescription)
        }
    }
    
}
