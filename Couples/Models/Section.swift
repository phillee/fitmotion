//
//  Content.swift
//  Couples
//
//  Created by Винниченко Дмитрий on 01.11.16.
//  Copyright © 2016 Philip Lee. All rights reserved.
//

import Foundation

class Section {
    
    struct JSONKeys {
        
        static let name         = "name"
        static let thumbnail    = "thumbnail"
        static let videoUrl     = "videoUrl"
        static let free         = "free"
        static let time         = "time"
    }
    
    var name: String?
    var thumbnail: String?
    var videoUrl: String?
    var free: Bool? = false
    var time: Double?
    
    
    convenience init(_ dictionary: NSDictionary) {
        self.init()
        
        name        = dictionary[JSONKeys.name] as? String
        thumbnail   = dictionary[JSONKeys.thumbnail] as? String
        videoUrl    = dictionary[JSONKeys.videoUrl] as? String
        
        let freeValues = (dictionary[JSONKeys.free]) as? NSNumber
        if (freeValues != nil) {
            free = freeValues?.boolValue
        }
    
        time = dictionary[JSONKeys.time] as? Double
    }
}
