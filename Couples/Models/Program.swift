//
//  Program.swift
//  Couples
//
//  Created by Винниченко Дмитрий on 31.10.16.
//  Copyright © 2016 Philip Lee. All rights reserved.
//

import Foundation

class Program {
    
    struct JSONKeys {
        
        static let name             = "name"
        static let coverImage       = "coverImage"
        static let description      = "desc"
        static let appleProductId   = "appleProductId"
        static let introUrl         = "introUrl"
        static let introImage       = "introImage"
        static let sections         = "sections"
    }
    
    var name: String?
    var coverImage: String?
    var description: String?
    var appleProductId: String?
    var introUrl: String?
    var introImage: String?
    var sections: NSArray = []

    
    convenience init(_ dictionary: NSDictionary) {
        self.init()
        
        name            = dictionary[JSONKeys.name] as? String
        coverImage      = dictionary[JSONKeys.coverImage] as? String
        description     = dictionary[JSONKeys.description] as? String
        appleProductId  = dictionary[JSONKeys.appleProductId] as? String
        introUrl        = dictionary[JSONKeys.introUrl] as? String
        introImage      = dictionary[JSONKeys.introImage] as? String
        
        
        var allSections = [Section]()
        for dictionary in dictionary[JSONKeys.sections] as! NSArray {
            
            let section = Section.init(dictionary as! NSDictionary)
            allSections.append(section)
        }
        
        sections = allSections as NSArray
    }
}
