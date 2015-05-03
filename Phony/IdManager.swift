//
//  IdManager.swift
//  Phony
//
//  Created by Dmitri Nesterenko on 5/3/15.
//  Copyright (c) 2015 Dmitri Nesterenko. All rights reserved.
//

import Foundation

class IdManager{
    static func generateId() -> String{
        return NSUUID().UUIDString
    }

}
